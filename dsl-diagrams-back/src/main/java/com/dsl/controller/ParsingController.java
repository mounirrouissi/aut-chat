package com.dsl.controller;

import com.dsl.grammar.AivaLexer;
import com.dsl.grammar.AivaParser;
import com.dsl.models.*;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.regex.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:5173")
public class ParsingController {

    // kept as fields so helper methods can access the token stream / original text
    private CommonTokenStream tokenStream;
    private String originalSource;

    // Regexes to detect branch-line syntaxes:
    // Example 1: "R1. FORD_0K_NEW_A_NRTA > GOTO FORD_0K_NRTA_1ST_TRACK:S1"
    private static final Pattern BRANCH_WITH_ARROW = Pattern.compile(
            "^\\s*[^\\.]+\\.\\s*([^>]+?)\\s*>\\s*GOTO\\s*([^:]+):([^\\s;]+)\\s*$",
            Pattern.CASE_INSENSITIVE);

    // Example 2: "R_default. GOTO MANUAL_INTERNAL_HANDOFF:S1" or "R1. GOTO TRACK:S1"
    private static final Pattern BRANCH_GOTO_ONLY = Pattern.compile(
            "^\\s*([^\\.]+?)\\.\\s*GOTO\\s*([^:]+):([^\\s;]+)\\s*$",
            Pattern.CASE_INSENSITIVE);

    @PostMapping("/parse")
    public List<TrackNode> parseScript(@RequestBody String script) {
        originalSource = script == null ? "" : script;
        CharStream input = CharStreams.fromString(originalSource);
        AivaLexer lexer = new AivaLexer(input);
        tokenStream = new CommonTokenStream(lexer);
        AivaParser parser = new AivaParser(tokenStream);

        AivaParser.ScriptContext scriptCtx = parser.script();
        if (scriptCtx == null) return Collections.emptyList();

        // Map each track and return
        List<TrackNode> trackNodes = scriptCtx.track().stream()
                .map(this::mapTrackAndResolve)
                .collect(Collectors.toList());
        System.out.println("the returned track nodes = ");
        trackNodes.forEach(System.out::println);
        return trackNodes;
    }

    // Map a track and resolve SwitchAction branchless cases by consuming inline branch-lines inside the same state.

    private TrackNode mapTrackAndResolve(AivaParser.TrackContext trackCtx) {
        String trackName = safeTextOf(trackCtx.IDENTIFIER());

        // Map raw states first
        List<StateNode> rawStates = trackCtx.state().stream().map(this::mapStateRaw).toList();

        // For each state, if it contains a SwitchAction with empty branches,
        // gather BranchAction lines that exist in that state's action list and attach them.
        List<StateNode> resolvedStates = new ArrayList<>();

        // COLLECT ALL BRANCH ACTIONS FROM REACTIVE_GOTO_STATES
        Map<String, String> allBranches = new LinkedHashMap<>();

        for (StateNode s : rawStates) {
            List<Action> actions = new ArrayList<>(s.actions());

            // Check if this is a reactive goto state (R1, R2, etc.)
            if (s.trackName().startsWith("R") && !s.trackName().contains("-R")) {
                for (Action action : actions) {
                    if (action instanceof BranchAction ba) {
                        allBranches.put(s.trackName(), ba.target()); // Use state name as branch label
                    }
                }
            }

            // collect branch-line actions that appear in this state's actions
            List<BranchAction> branchLines = new ArrayList<>();
            Iterator<Action> it = actions.iterator();
            while (it.hasNext()) {
                Action a = it.next();
                if (a instanceof BranchAction ba) {
                    branchLines.add(ba);
                    it.remove(); // remove branch lines from the action list
                }
            }

            if (!branchLines.isEmpty()) {
                // find the first SwitchAction in actions with empty branches, and attach gathered branches
                boolean attached = false;
                for (int i = 0; i < actions.size(); i++) {
                    Action a = actions.get(i);
                    if (a instanceof SwitchAction sw) {
                        Map<String, String> existing = sw.branches();
                        if (existing == null || existing.isEmpty()) {
                            // build map preserving order - combine branchLines + allBranches
                            Map<String, String> gathered = new LinkedHashMap<>();
                            for (BranchAction ba : branchLines) gathered.put(ba.label(), ba.target());
                            gathered.putAll(allBranches); // Add R1, R2, etc. from reactive states

                            // create new SwitchAction record with same function and filled branches
                            SwitchAction newSw = new SwitchAction(sw.function(), gathered);
                            actions.set(i, newSw);
                            attached = true;
                            break;
                        }
                    }
                }
            }

            // Only add non-reactive states to resolved states (skip R1, R2, etc.)
            if (!s.trackName().startsWith("R") || s.trackName().contains("-R")) {
                resolvedStates.add(new StateNode(s.trackName(), s.id(), List.copyOf(actions)));
            }
        }

        // If we found branches but no switch was updated, find the switch and update it
        if (!allBranches.isEmpty()) {
            for (int i = 0; i < resolvedStates.size(); i++) {
                StateNode state = resolvedStates.get(i);
                for (int j = 0; j < state.actions().size(); j++) {
                    Action action = state.actions().get(j);
                    if (action instanceof SwitchAction sw && (sw.branches() == null || sw.branches().isEmpty())) {
                        List<Action> newActions = new ArrayList<>(state.actions());
                        newActions.set(j, new SwitchAction(sw.function(), allBranches));
                        resolvedStates.set(i, new StateNode(state.trackName(), state.id(), newActions));
                        break;
                    }
                }
            }
        }

        return new TrackNode(trackName, List.copyOf(resolvedStates));
    }

    // Map a state (either action_block_state or reactive_goto_state)
    private StateNode mapStateRaw(AivaParser.StateContext stateCtx) {
        // Many grammars will give you either `action_block_state()` or `reactive_goto_state()`; handle both.
        AivaParser.Action_block_stateContext block = stateCtx.action_block_state();
        AivaParser.Reactive_goto_stateContext reactive = stateCtx.reactive_goto_state();

        if (block != null) {
            String id = safeTextOf(block.IDENTIFIER(0));       // S1
            String type = safeTextOf(block.IDENTIFIER(1));     // START
            List<Action> actions = new ArrayList<>();
            for (AivaParser.ActionContext aCtx : block.action()) {
                // Attempt structured mapping first
                Optional<Action> maybe = mapActionStructured(aCtx);
                if (maybe.isPresent()) {
                    actions.add(maybe.get());
                    continue;
                }
                // Fallback: try to detect branch-line syntaxes inside the state's action list
                String raw = textOf(aCtx).trim();
                // try arrow-style branch line: "R1. LABEL > GOTO TRACK:STATE"
                Matcher m1 = BRANCH_WITH_ARROW.matcher(raw);
                if (m1.find()) {
                    String label = m1.group(1).trim();
                    String tgtTrack = m1.group(2).trim();
                    String tgtState = m1.group(3).trim();
                    actions.add(new BranchAction(label, tgtTrack + ":" + tgtState));
                    continue;
                }
                // try goto-only style: "R_default. GOTO TRACK:STATE" or "R1. GOTO TRACK:STATE"
                Matcher m2 = BRANCH_GOTO_ONLY.matcher(raw);
                if (m2.find()) {
                    String maybeLabel = m2.group(1).trim();
                    String tgtTrack = m2.group(2).trim();
                    String tgtState = m2.group(3).trim();
                    // If maybeLabel is something like "R_default" or starts with "R", we treat it as a branch label.
                    actions.add(new BranchAction(maybeLabel, tgtTrack + ":" + tgtState));
                    continue;
                }

                // If not recognized, store UnknownAction with original raw text (safe for round-trip)
                actions.add(new UnknownAction(raw));
            }
            return new StateNode(id, type, List.copyOf(actions));
        }

        if (reactive != null) {
            // reactive line like: R1. FORD_0K_NEW_A_NRTA > GOTO FORD_0K_NRTA_1ST_TRACK:S1
            String id = safeTextOf(reactive.IDENTIFIER(0));   // R1
            String labelOrType = safeTextOf(reactive.IDENTIFIER(1)); // label or 'true'
            String targetTrack = safeTextOf(reactive.IDENTIFIER(2));
            String targetState = safeTextOf(reactive.IDENTIFIER(3));
            BranchAction branch = new BranchAction(labelOrType, targetTrack + ":" + targetState);
            return new StateNode(id, "REACTIVE", List.of(branch));
        }

        // Fallback — shouldn't happen
        return new StateNode("UNKNOWN", "UNKNOWN", List.of());
    }

    // Try to map well-known structured actions (based on the parser tokens). Returns Optional.empty() when unknown.
    private Optional<Action> mapActionStructured(AivaParser.ActionContext ctx) {
        if (ctx == null) return Optional.empty();
        String first = ctx.getChild(0).getText();

        // use safe access: ctx.IDENTIFIER() -> list of TerminalNode
        List<TerminalNode> ids = ctx.IDENTIFIER();

        switch (first) {
            case "CALL_FUNCTION_SWITCH" -> {
                // structure: CALL_FUNCTION_SWITCH <util> <fn> '->' <resultVar> branch*
                String part1 = safeTextOf(ids, 0);
                String part2 = safeTextOf(ids, 1);
                String function = (part1 + " " + part2).trim();
                // resultVar likely at index 2
                String resultVar = safeTextOf(ids, 2);
                Map<String, String> inlineBranches = new LinkedHashMap<>();
                // inline branch children (if grammar produced them using branch rule)
                for (AivaParser.BranchContext b : ctx.branch()) {
                    List<TerminalNode> bids = b.IDENTIFIER();
                    if (bids.size() >= 2) {
                        String k = safeTextOf(bids, 0);
                        String v = safeTextOf(bids, 1);
                        if (!k.isEmpty() && !v.isEmpty()) inlineBranches.put(k, v);
                    }
                }
                return Optional.of(new SwitchAction(function + " -> " + resultVar, inlineBranches));
            }

            case "SENDMESSAGE" -> {
                // e.g. SENDMESSAGE SMS AGENT CUST $TEMPLATE  -> indices (0..3)
                String channel = safeTextOf(ids, 0);
                String from = safeTextOf(ids, 1);
                String to = safeTextOf(ids, 2);
                String template = safeTextOf(ids, 3);
                return Optional.of(new SendMessageAction(channel, from, to, template));
            }

            case "SENDMESSAGE_INTERNAL" -> {
                // Some scripts use SENDMESSAGE_INTERNAL, capture it similarly (optional)
                String channel = safeTextOf(ids, 0);
                String from = safeTextOf(ids, 1);
                String to = safeTextOf(ids, 2);
                String template = safeTextOf(ids, 3);
                // You can define SendMessageInternalAction record if you prefer; reuse SendMessageAction for now:
                return Optional.of(new SendMessageAction(channel, from + "_INTERNAL", to, template));
            }

            case "MARK_LEAD_PHASE" -> {
                String phase = safeTextOf(ids, 0);
                return Optional.of(new MarkLeadPhaseAction(phase));
            }

            case "UNSCHEDULE" -> {
                String target = safeTextOf(ids, 0);
                return Optional.of(new UnscheduleAction(target));
            }

            case "SWITCH_DIRECTION" -> {
                String d = safeTextOf(ids, 0);
                return Optional.of(new SwitchDirectionAction(d));
            }

            case "GOTO" -> {
                if (ids.size() >= 2) {
                    return Optional.of(new GotoAction(safeTextOf(ids, 0) + ":" + safeTextOf(ids, 1)));
                } else if (ids.size() == 1) {
                    return Optional.of(new GotoAction(safeTextOf(ids, 0)));
                } else {
                    return Optional.empty();
                }
            }

            case "SCHEDULE_FOLLOWUP" -> {
                // Complex structure: SCHEDULE_FOLLOWUP RELDAY:1 ABSTIME:09:57:am <TRACK>:<STATE>
                // fallback: take the full raw text and store as ScheduleFollowupAction
                String raw = textOf(ctx);
                return Optional.of(new ScheduleFollowupAction(raw));
            }

            case "IS_SUNDAY" -> {
                // e.g. IS_SUNDAY -> @isSunday
                String raw = textOf(ctx);
                return Optional.of(new IsSundayAction(raw));
            }

            case "SETMARK" -> {
                // SETMARK FOLLOW_UP FALSE
                String key = safeTextOf(ids, 0);
                String val = safeTextOf(ids, 1);
                return Optional.of(new SetMarkAction(key, val));
            }

            case "DELETE_INSIGHT" -> {
                String key = safeTextOf(ids, 0);
                return Optional.of(new DeleteInsightAction(key));
            }

            case "SEND_TEMPLATE" -> {
                String t = safeTextOf(ids, 0);
                return Optional.of(new SendTemplateAction(t));
            }

            // Add other structured actions as needed...

            default -> {
                return Optional.empty();
            }
        }
    }

    // Helper to get text of ctx using the tokenStream (prefer preserved whitespace/text)
    private String textOf(ParserRuleContext ctx) {
        if (ctx == null || tokenStream == null) return "";
        try {
            return tokenStream.getText(ctx);
        } catch (Exception e) {
            return ctx.getText();
        }
    }

    // safe helpers
    private String safeTextOf(TerminalNode node) {
        return node == null ? "" : node.getText();
    }
    private String safeTextOf(List<TerminalNode> list, int idx) {
        if (list == null || list.size() <= idx) return "";
        return safeTextOf(list.get(idx));
    }
}
