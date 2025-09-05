// AivaGraph.tsx
import React, { useState } from "react";
import { parseScript } from "./http/api";
import {
  ReactFlow,
  MiniMap,
  Controls,
  Background,
  Node,
  Edge,
  MarkerType,
  useNodesState,
  useEdgesState,
  Handle,
  Position,
} from "@xyflow/react";
import "@xyflow/react/dist/style.css";

// Custom Switch Node Component
const SwitchNode = ({ data }: { data: any }) => {
  return (
    <div
      style={{
        background: "#fbbf24",
        border: "2px solid #f59e0b",
        borderRadius: "50%",
        width: "80px",
        height: "80px",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        position: "relative",
        boxShadow: "0 4px 8px rgba(0,0,0,0.2)",
      }}
    >
      <Handle
        type="target"
        position={Position.Top}
        style={{ background: "#555" }}
      />
      <div
        style={{
          textAlign: "center",
          fontSize: "10px",
          fontWeight: "bold",
          color: "#92400e",
          padding: "4px",
          lineHeight: "1.1",
        }}
      >
        <div>⚡</div>
        <div>{data.functionName}</div>
      </div>
      <Handle
        type="source"
        position={Position.Bottom}
        style={{ background: "#555" }}
      />
    </div>
  );
};

// Custom node types
const nodeTypes = {
  switch: SwitchNode,
};

/**
 * Defensive helpers to read state/action fields that backend may use
 * slightly differently. The backend sample you posted had:
 *  TrackNode[name=WelcomeTrack, states=[StateNode[trackName=S1, id=START, actions=[...]]]]
 *
 * So a state sometimes has:
 *  - state.trackName === "S1"   (the state's id)
 *  - state.id === "START"       (the state's type)
 *
 * We'll read both and fall back safely.
 */

type RawTrack = {
  name?: string;
  id?: string;
  states?: any[];
};

type RawState = {
  // backend variant 1: (trackName=S1, id=START)
  trackName?: string;
  id?: string;
  // other variant: (id=S1, type=START)
  type?: string;
  actions?: any[];
};

const safeStateKey = (track: RawTrack, state: RawState) => {
  // determine state name (S1) and state type (START)
  const stateName =
    // prefer the field that looks like an "S1" (starts with 'S' or 'R' frequently),
    // fallback order based on observed backend shapes:
    state.trackName ?? state.id ?? state.type ?? "UNKNOWN_STATE";
  const stateType = state.type ?? state.id ?? "UNKNOWN_TYPE";
  const trackName = track.name ?? track.id ?? "UNKNOWN_TRACK";
  return { trackName, stateName, stateType };
};

const transformAstToFlow = (tracks: RawTrack[]) => {
  const nodes: Node[] = [];
  const edges: Edge[] = [];
  const nodeMap = new Map<string, Node>();

  // Determine parent track (first track is usually the parent)
  const parentTrackName = tracks[0]?.name || tracks[0]?.id || "WelcomeTrack";

  // Track positioning
  let baseY = 50;
  const trackSpacingX = 400;
  let switchNodeCreated = false;
  let switchTargets: string[] = [];

  tracks.forEach((track, ti) => {
    const states = track.states ?? [];
    const isParentTrack = (track.name || track.id) === parentTrackName;
    const trackName = track.name || track.id || "UNKNOWN_TRACK";

    // Color scheme based on track type
    const trackColors = isParentTrack
      ? {
          background: "#dbeafe",
          border: "#3b82f6",
          textColor: "#1e40af",
        }
      : {
          background: "#dcfce7",
          border: "#22c55e",
          textColor: "#15803d",
        };

    // Create main track node (simplified)
    const trackNodeId = trackName;
    const trackNode: Node = {
      id: trackNodeId,
      data: {
        label: (
          <div style={{ textAlign: "center", padding: "8px" }}>
            <div
              style={{
                fontWeight: "bold",
                color: trackColors.textColor,
                fontSize: "16px",
              }}
            >
              {trackName}
            </div>
          </div>
        ),
      },
      position: { x: ti * trackSpacingX + 100, y: baseY },
      type: "default",
      style: {
        width: 250,
        background: trackColors.background,
        border: `3px solid ${trackColors.border}`,
        borderRadius: "12px",
        boxShadow: "0 4px 8px rgba(0,0,0,0.15)",
      },
    };

    nodeMap.set(trackNodeId, trackNode);

    // Check if this track has a switch action (parent track)
    let hasSwitchInTrack = false;
    let gotoTargets: string[] = [];

    states.forEach((st: RawState) => {
      const { stateName } = safeStateKey(track, st);
      const isReactionState =
        stateName.includes("-R") || stateName.endsWith("R");

      // Handle reaction states separately
      if (isReactionState) {
        const reactionNodeId = `${trackName}:${stateName}`;
        const reactionNode: Node = {
          id: reactionNodeId,
          data: {
            label: (
              <div style={{ textAlign: "center", padding: "6px" }}>
                <div
                  style={{
                    fontWeight: "bold",
                    color: "#92400e",
                    fontSize: "12px",
                  }}
                >
                  {stateName} 🔄
                </div>
              </div>
            ),
          },
          position: {
            x: ti * trackSpacingX + 380,
            y: baseY + 20,
          },
          type: "default",
          style: {
            width: 120,
            background: "#fef3c7",
            border: "2px solid #f59e0b",
            borderRadius: "8px",
            boxShadow: "0 2px 8px rgba(245, 158, 11, 0.3)",
          },
        };

        nodeMap.set(reactionNodeId, reactionNode);

        // Connect reaction to main track
        edges.push({
          id: `e-${trackNodeId}-reaction-${reactionNodeId}`,
          source: trackNodeId,
          target: reactionNodeId,
          label: "reaction",
          animated: true,
          type: "smoothstep",
          markerEnd: { type: MarkerType.ArrowClosed },
          style: {
            stroke: "#f59e0b",
            strokeWidth: 2,
            strokeDasharray: "5,5",
          },
        } as Edge);
      } else {
        // Check for switch actions and goto targets in main states
        (st.actions ?? []).forEach((a: any) => {
          if (
            a.function &&
            (a.branches || Object.keys(a.branches || {}).length > 0)
          ) {
            hasSwitchInTrack = true;

            // Extract targets from switch branches
            if (a.branches && typeof a.branches === "object") {
              Object.values(a.branches).forEach((target: any) => {
                const targetStr = String(target);
                if (targetStr.includes(":")) {
                  const targetTrack = targetStr.split(":")[0];
                  if (!gotoTargets.includes(targetTrack)) {
                    gotoTargets.push(targetTrack);
                  }
                }
              });
            }
          }
          if (a.target && a.target.includes(":")) {
            const targetTrack = a.target.split(":")[0];
            if (!gotoTargets.includes(targetTrack)) {
              gotoTargets.push(targetTrack);
            }
          }
          // Also check for BranchAction targets (R1, R2 lines)
          if (a.label && a.target && a.target.includes(":")) {
            const targetTrack = a.target.split(":")[0];
            if (!gotoTargets.includes(targetTrack)) {
              gotoTargets.push(targetTrack);
            }
          }
        });
      }
    });

    // Create switch node for parent track
    if (hasSwitchInTrack && isParentTrack && !switchNodeCreated) {
      const switchNodeId = "decision-switch";
      const switchNode: Node = {
        id: switchNodeId,
        data: {
          functionName: "@customerType",
        },
        position: {
          x: 250,
          y: baseY + 150,
        },
        type: "switch",
      };

      nodeMap.set(switchNodeId, switchNode);
      switchNodeCreated = true;

      // Connect parent track to switch
      edges.push({
        id: `e-${trackNodeId}-to-switch`,
        source: trackNodeId,
        target: switchNodeId,
        animated: false,
        type: "smoothstep",
        markerEnd: { type: MarkerType.ArrowClosed },
      } as Edge);

      // Store targets for switch connections
      switchTargets = gotoTargets;
    }
  });

  // Connect switch to target tracks
  if (switchNodeCreated) {
    // WORKAROUND: Since backend isn't properly linking branches,
    // connect to all child tracks (non-parent tracks)
    const childTracks = tracks
      .filter((t) => (t.name || t.id) !== parentTrackName)
      .map((t) => t.name || t.id || "UNKNOWN");

    const targetsToConnect =
      switchTargets.length > 0 ? switchTargets : childTracks;

    targetsToConnect.forEach((targetTrack, idx) => {
      if (nodeMap.has(targetTrack)) {
        edges.push({
          id: `e-decision-switch-to-${targetTrack}`,
          source: "decision-switch",
          target: targetTrack,
          label: `R${idx + 1}`,
          animated: true,
          type: "smoothstep",
          markerEnd: { type: MarkerType.ArrowClosed },
          style: { stroke: "#f59e0b", strokeWidth: 2 },
        } as Edge);
      }
    });

    // Update switchTargets for positioning
    if (switchTargets.length === 0) {
      switchTargets = childTracks;
    }
  }

  // Position child tracks in a fan pattern around the switch
  const finalNodes = Array.from(nodeMap.values());
  const switchNode = finalNodes.find((n) => n.id === "decision-switch");

  if (switchNode && switchTargets.length > 0) {
    const switchX = switchNode.position.x ?? 0;
    const switchY = switchNode.position.y ?? 0;
    const radius = 250;

    switchTargets.forEach((targetTrack, i) => {
      const targetNode = nodeMap.get(targetTrack);
      if (targetNode) {
        // Position targets in a horizontal spread below the switch
        const spacing = 300;
        const startX = switchX - ((switchTargets.length - 1) * spacing) / 2;

        targetNode.position = {
          x: startX + i * spacing,
          y: switchY + radius,
        };

        // Also reposition the reaction state if it exists
        const reactionNodeId = `${targetTrack}:S1-R`;
        const reactionNode = nodeMap.get(reactionNodeId);
        if (reactionNode) {
          reactionNode.position = {
            x: startX + i * spacing + 280,
            y: switchY + radius + 20,
          };
        }
      }
    });
  }

  return { nodes: finalNodes, edges };
};

function AivaGraph() {
  const [script, setScript] = useState(
    `START_TRACK WelcomeTrack
S1. START
    CALL_FUNCTION_SWITCH customerUtils findCustomerType -> @customerType
R1. FORD_0K_NEW_A_NRTA > GOTO FORD_0K_NRTA_1ST_TRACK:S1
R2. FORD_5K_NEW_A_NRTA > GOTO FORD_5K_NEW_NRTA_1ST_TRACK:S1

END_TRACK

START_TRACK FORD_0K_NRTA_1ST_TRACK
\tS1. START
\t\tSENDMESSAGE SMS AGENT CUST $AN_FORD_0K_NRTA_1ST_TEMP
\t\tMARK_LEAD_PHASE CONTACTED
\tEND
\tS1-R. START
\t\tUNSCHEDULE CUST
\t\tUNSCHEDULE SREP
\t\tSWITCH_DIRECTION OUTBOUND
\t\tMARK_LEAD_PHASE RESPONDED
\t\tGOTO GENERIC_NRTA_1STTEXT_TRACK_RESPONSE_HANDLER:S1
\tEND
END_TRACK

START_TRACK FORD_5K_NEW_NRTA_1ST_TRACK
\tS1. START
\t\tSENDMESSAGE SMS AGENT CUST $AN_FORD_5K_NEW_NRTA_1ST_TEMP
\t\tMARK_LEAD_PHASE CONTACTED
\t\tSCHEDULE_FOLLOWUP RELDAY:1 ABSTIME:09:57:am GENERIC_AN_FIRSTSERVICE_NRTA_1ST_NRAA_TRACK_V1:S1
\tEND
\tS1-R. START
\t\tUNSCHEDULE CUST
\t\tUNSCHEDULE SREP
\t\tSWITCH_DIRECTION OUTBOUND
\t\tMARK_LEAD_PHASE RESPONDED
\t\tGOTO GENERIC_NRTA_1STTEXT_TRACK_RESPONSE_HANDLER:S1
\tEND
END_TRACK`
  );

  const [nodes, setNodes, onNodesChange] = useNodesState<Node>([]);
  const [edges, setEdges, onEdgesChange] = useEdgesState<Edge>([]);
  const [error, setError] = useState("");

  const generateGraph = async () => {
    try {
      setError("");
      const ast = await parseScript(script); // expects TrackNode[]
      console.log("Backend AST:", JSON.stringify(ast, null, 2));
      const { nodes: newNodes, edges: newEdges } = transformAstToFlow(ast);
      console.log(
        "Generated nodes:",
        newNodes.map((n) => ({ id: n.id, type: n.type }))
      );
      console.log(
        "Generated edges:",
        newEdges.map((e) => ({
          id: e.id,
          source: e.source,
          target: e.target,
          label: e.label,
        }))
      );
      setNodes(newNodes);
      setEdges(newEdges);
    } catch (err) {
      console.error(err);
      setError("Failed to parse script. Check backend console.");
    }
  };

  return (
    <div
      style={{
        height: "100vh",
        width: "100%",
        display: "flex",
        backgroundColor: "#07101a",
      }}
    >
      <div style={{ padding: 20, borderRight: "1px solid #ccc", width: 420 }}>
        <h2 style={{ color: "white" }}>AIVA Script</h2>
        <textarea
          rows={20}
          cols={50}
          value={script}
          onChange={(e) => setScript(e.target.value)}
          style={{ fontFamily: "monospace", width: "100%" }}
        />
        <br />
        <button onClick={generateGraph} style={{ marginTop: 10 }}>
          Generate Graph
        </button>
        {error && <p style={{ color: "tomato" }}>{error}</p>}
      </div>

      <div style={{ flex: 1, position: "relative" }}>
        <div style={{ padding: 10, color: "white" }}>ReactFlow Container</div>
        <div style={{ width: "100%", height: "calc(100% - 40px)" }}>
          <ReactFlow
            nodes={nodes}
            edges={edges}
            onNodesChange={onNodesChange}
            onEdgesChange={onEdgesChange}
            nodeTypes={nodeTypes}
            fitView
            nodesDraggable={true}
            nodesConnectable={false}
            elementsSelectable={true}
          >
            <MiniMap />
            <Controls />
            <Background />
          </ReactFlow>
        </div>
      </div>
    </div>
  );
}

export default AivaGraph;
