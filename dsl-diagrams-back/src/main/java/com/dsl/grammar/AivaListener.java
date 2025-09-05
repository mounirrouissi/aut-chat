package com.dsl.grammar;// Generated from Aiva.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link AivaParser}.
 */
public interface AivaListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link AivaParser#script}.
	 * @param ctx the parse tree
	 */
	void enterScript(AivaParser.ScriptContext ctx);
	/**
	 * Exit a parse tree produced by {@link AivaParser#script}.
	 * @param ctx the parse tree
	 */
	void exitScript(AivaParser.ScriptContext ctx);
	/**
	 * Enter a parse tree produced by {@link AivaParser#track}.
	 * @param ctx the parse tree
	 */
	void enterTrack(AivaParser.TrackContext ctx);
	/**
	 * Exit a parse tree produced by {@link AivaParser#track}.
	 * @param ctx the parse tree
	 */
	void exitTrack(AivaParser.TrackContext ctx);
	/**
	 * Enter a parse tree produced by {@link AivaParser#state}.
	 * @param ctx the parse tree
	 */
	void enterState(AivaParser.StateContext ctx);
	/**
	 * Exit a parse tree produced by {@link AivaParser#state}.
	 * @param ctx the parse tree
	 */
	void exitState(AivaParser.StateContext ctx);
	/**
	 * Enter a parse tree produced by {@link AivaParser#action_block_state}.
	 * @param ctx the parse tree
	 */
	void enterAction_block_state(AivaParser.Action_block_stateContext ctx);
	/**
	 * Exit a parse tree produced by {@link AivaParser#action_block_state}.
	 * @param ctx the parse tree
	 */
	void exitAction_block_state(AivaParser.Action_block_stateContext ctx);
	/**
	 * Enter a parse tree produced by {@link AivaParser#reactive_goto_state}.
	 * @param ctx the parse tree
	 */
	void enterReactive_goto_state(AivaParser.Reactive_goto_stateContext ctx);
	/**
	 * Exit a parse tree produced by {@link AivaParser#reactive_goto_state}.
	 * @param ctx the parse tree
	 */
	void exitReactive_goto_state(AivaParser.Reactive_goto_stateContext ctx);
	/**
	 * Enter a parse tree produced by {@link AivaParser#action}.
	 * @param ctx the parse tree
	 */
	void enterAction(AivaParser.ActionContext ctx);
	/**
	 * Exit a parse tree produced by {@link AivaParser#action}.
	 * @param ctx the parse tree
	 */
	void exitAction(AivaParser.ActionContext ctx);
	/**
	 * Enter a parse tree produced by {@link AivaParser#branch}.
	 * @param ctx the parse tree
	 */
	void enterBranch(AivaParser.BranchContext ctx);
	/**
	 * Exit a parse tree produced by {@link AivaParser#branch}.
	 * @param ctx the parse tree
	 */
	void exitBranch(AivaParser.BranchContext ctx);
}