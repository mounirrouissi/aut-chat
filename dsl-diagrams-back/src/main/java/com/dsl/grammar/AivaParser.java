package com.dsl.grammar;// Generated from Aiva.g4 by ANTLR 4.13.1

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.ATN;
import org.antlr.v4.runtime.atn.ATNDeserializer;
import org.antlr.v4.runtime.atn.ParserATNSimulator;
import org.antlr.v4.runtime.atn.PredictionContextCache;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.tree.ParseTreeListener;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.List;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class AivaParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		GOTO=1, CALL_FUNCTION_SWITCH=2, SENDMESSAGE=3, MARK_LEAD_PHASE=4, UNSCHEDULE=5, 
		SWITCH_DIRECTION=6, SEND_TEMPLATE=7, START_TRACK=8, END_TRACK=9, END=10, 
		GT=11, COLON=12, ARROW=13, DOT=14, IDENTIFIER=15, WS=16;
	public static final int
		RULE_script = 0, RULE_track = 1, RULE_state = 2, RULE_action_block_state = 3, 
		RULE_reactive_goto_state = 4, RULE_action = 5, RULE_branch = 6;
	private static String[] makeRuleNames() {
		return new String[] {
			"script", "track", "state", "action_block_state", "reactive_goto_state", 
			"action", "branch"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'GOTO'", "'CALL_FUNCTION_SWITCH'", "'SENDMESSAGE'", "'MARK_LEAD_PHASE'", 
			"'UNSCHEDULE'", "'SWITCH_DIRECTION'", "'SEND_TEMPLATE'", "'START_TRACK'", 
			"'END_TRACK'", "'END'", "'>'", "':'", "'->'", "'.'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "GOTO", "CALL_FUNCTION_SWITCH", "SENDMESSAGE", "MARK_LEAD_PHASE", 
			"UNSCHEDULE", "SWITCH_DIRECTION", "SEND_TEMPLATE", "START_TRACK", "END_TRACK", 
			"END", "GT", "COLON", "ARROW", "DOT", "IDENTIFIER", "WS"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Aiva.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public AivaParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ScriptContext extends ParserRuleContext {
		public TerminalNode EOF() { return getToken(AivaParser.EOF, 0); }
		public List<TrackContext> track() {
			return getRuleContexts(TrackContext.class);
		}
		public TrackContext track(int i) {
			return getRuleContext(TrackContext.class,i);
		}
		public ScriptContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_script; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).enterScript(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).exitScript(this);
		}
	}

	public final ScriptContext script() throws RecognitionException {
		ScriptContext _localctx = new ScriptContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_script);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(15); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(14);
				track();
				}
				}
				setState(17); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==START_TRACK );
			setState(19);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class TrackContext extends ParserRuleContext {
		public TerminalNode START_TRACK() { return getToken(AivaParser.START_TRACK, 0); }
		public TerminalNode IDENTIFIER() { return getToken(AivaParser.IDENTIFIER, 0); }
		public TerminalNode END_TRACK() { return getToken(AivaParser.END_TRACK, 0); }
		public List<StateContext> state() {
			return getRuleContexts(StateContext.class);
		}
		public StateContext state(int i) {
			return getRuleContext(StateContext.class,i);
		}
		public TrackContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_track; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).enterTrack(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).exitTrack(this);
		}
	}

	public final TrackContext track() throws RecognitionException {
		TrackContext _localctx = new TrackContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_track);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(21);
			match(START_TRACK);
			setState(22);
			match(IDENTIFIER);
			setState(24); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(23);
				state();
				}
				}
				setState(26); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==IDENTIFIER );
			setState(28);
			match(END_TRACK);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class StateContext extends ParserRuleContext {
		public Action_block_stateContext action_block_state() {
			return getRuleContext(Action_block_stateContext.class,0);
		}
		public Reactive_goto_stateContext reactive_goto_state() {
			return getRuleContext(Reactive_goto_stateContext.class,0);
		}
		public StateContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_state; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).enterState(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).exitState(this);
		}
	}

	public final StateContext state() throws RecognitionException {
		StateContext _localctx = new StateContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_state);
		try {
			setState(32);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,2,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(30);
				action_block_state();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(31);
				reactive_goto_state();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Action_block_stateContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(AivaParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(AivaParser.IDENTIFIER, i);
		}
		public TerminalNode DOT() { return getToken(AivaParser.DOT, 0); }
		public TerminalNode END() { return getToken(AivaParser.END, 0); }
		public List<ActionContext> action() {
			return getRuleContexts(ActionContext.class);
		}
		public ActionContext action(int i) {
			return getRuleContext(ActionContext.class,i);
		}
		public Action_block_stateContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_action_block_state; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).enterAction_block_state(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).exitAction_block_state(this);
		}
	}

	public final Action_block_stateContext action_block_state() throws RecognitionException {
		Action_block_stateContext _localctx = new Action_block_stateContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_action_block_state);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(34);
			match(IDENTIFIER);
			setState(35);
			match(DOT);
			setState(36);
			match(IDENTIFIER);
			setState(38); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(37);
				action();
				}
				}
				setState(40); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & 254L) != 0) );
			setState(42);
			match(END);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Reactive_goto_stateContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(AivaParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(AivaParser.IDENTIFIER, i);
		}
		public TerminalNode DOT() { return getToken(AivaParser.DOT, 0); }
		public TerminalNode GT() { return getToken(AivaParser.GT, 0); }
		public TerminalNode GOTO() { return getToken(AivaParser.GOTO, 0); }
		public TerminalNode COLON() { return getToken(AivaParser.COLON, 0); }
		public Reactive_goto_stateContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_reactive_goto_state; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).enterReactive_goto_state(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).exitReactive_goto_state(this);
		}
	}

	public final Reactive_goto_stateContext reactive_goto_state() throws RecognitionException {
		Reactive_goto_stateContext _localctx = new Reactive_goto_stateContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_reactive_goto_state);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(44);
			match(IDENTIFIER);
			setState(45);
			match(DOT);
			setState(46);
			match(IDENTIFIER);
			setState(47);
			match(GT);
			setState(48);
			match(GOTO);
			setState(49);
			match(IDENTIFIER);
			setState(50);
			match(COLON);
			setState(51);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ActionContext extends ParserRuleContext {
		public TerminalNode CALL_FUNCTION_SWITCH() { return getToken(AivaParser.CALL_FUNCTION_SWITCH, 0); }
		public List<TerminalNode> IDENTIFIER() { return getTokens(AivaParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(AivaParser.IDENTIFIER, i);
		}
		public TerminalNode ARROW() { return getToken(AivaParser.ARROW, 0); }
		public List<BranchContext> branch() {
			return getRuleContexts(BranchContext.class);
		}
		public BranchContext branch(int i) {
			return getRuleContext(BranchContext.class,i);
		}
		public TerminalNode SENDMESSAGE() { return getToken(AivaParser.SENDMESSAGE, 0); }
		public TerminalNode MARK_LEAD_PHASE() { return getToken(AivaParser.MARK_LEAD_PHASE, 0); }
		public TerminalNode UNSCHEDULE() { return getToken(AivaParser.UNSCHEDULE, 0); }
		public TerminalNode SWITCH_DIRECTION() { return getToken(AivaParser.SWITCH_DIRECTION, 0); }
		public TerminalNode GOTO() { return getToken(AivaParser.GOTO, 0); }
		public TerminalNode COLON() { return getToken(AivaParser.COLON, 0); }
		public TerminalNode SEND_TEMPLATE() { return getToken(AivaParser.SEND_TEMPLATE, 0); }
		public ActionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_action; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).enterAction(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).exitAction(this);
		}
	}

	public final ActionContext action() throws RecognitionException {
		ActionContext _localctx = new ActionContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_action);
		int _la;
		try {
			setState(81);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case CALL_FUNCTION_SWITCH:
				enterOuterAlt(_localctx, 1);
				{
				setState(53);
				match(CALL_FUNCTION_SWITCH);
				setState(54);
				match(IDENTIFIER);
				setState(55);
				match(IDENTIFIER);
				setState(56);
				match(ARROW);
				setState(57);
				match(IDENTIFIER);
				setState(61);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==IDENTIFIER) {
					{
					{
					setState(58);
					branch();
					}
					}
					setState(63);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
				break;
			case SENDMESSAGE:
				enterOuterAlt(_localctx, 2);
				{
				setState(64);
				match(SENDMESSAGE);
				setState(65);
				match(IDENTIFIER);
				setState(66);
				match(IDENTIFIER);
				setState(67);
				match(IDENTIFIER);
				setState(68);
				match(IDENTIFIER);
				}
				break;
			case MARK_LEAD_PHASE:
				enterOuterAlt(_localctx, 3);
				{
				setState(69);
				match(MARK_LEAD_PHASE);
				setState(70);
				match(IDENTIFIER);
				}
				break;
			case UNSCHEDULE:
				enterOuterAlt(_localctx, 4);
				{
				setState(71);
				match(UNSCHEDULE);
				setState(72);
				match(IDENTIFIER);
				}
				break;
			case SWITCH_DIRECTION:
				enterOuterAlt(_localctx, 5);
				{
				setState(73);
				match(SWITCH_DIRECTION);
				setState(74);
				match(IDENTIFIER);
				}
				break;
			case GOTO:
				enterOuterAlt(_localctx, 6);
				{
				setState(75);
				match(GOTO);
				setState(76);
				match(IDENTIFIER);
				setState(77);
				match(COLON);
				setState(78);
				match(IDENTIFIER);
				}
				break;
			case SEND_TEMPLATE:
				enterOuterAlt(_localctx, 7);
				{
				setState(79);
				match(SEND_TEMPLATE);
				setState(80);
				match(IDENTIFIER);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class BranchContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(AivaParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(AivaParser.IDENTIFIER, i);
		}
		public TerminalNode COLON() { return getToken(AivaParser.COLON, 0); }
		public BranchContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_branch; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).enterBranch(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof AivaListener) ((AivaListener)listener).exitBranch(this);
		}
	}

	public final BranchContext branch() throws RecognitionException {
		BranchContext _localctx = new BranchContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_branch);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(83);
			match(IDENTIFIER);
			setState(84);
			match(COLON);
			setState(85);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\u0004\u0001\u0010X\u0002\u0000\u0007\u0000\u0002\u0001\u0007\u0001\u0002"+
		"\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004\u0007\u0004\u0002"+
		"\u0005\u0007\u0005\u0002\u0006\u0007\u0006\u0001\u0000\u0004\u0000\u0010"+
		"\b\u0000\u000b\u0000\f\u0000\u0011\u0001\u0000\u0001\u0000\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0004\u0001\u0019\b\u0001\u000b\u0001\f\u0001"+
		"\u001a\u0001\u0001\u0001\u0001\u0001\u0002\u0001\u0002\u0003\u0002!\b"+
		"\u0002\u0001\u0003\u0001\u0003\u0001\u0003\u0001\u0003\u0004\u0003\'\b"+
		"\u0003\u000b\u0003\f\u0003(\u0001\u0003\u0001\u0003\u0001\u0004\u0001"+
		"\u0004\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0004\u0001"+
		"\u0004\u0001\u0004\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001"+
		"\u0005\u0001\u0005\u0005\u0005<\b\u0005\n\u0005\f\u0005?\t\u0005\u0001"+
		"\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001"+
		"\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001"+
		"\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0003\u0005R\b"+
		"\u0005\u0001\u0006\u0001\u0006\u0001\u0006\u0001\u0006\u0001\u0006\u0000"+
		"\u0000\u0007\u0000\u0002\u0004\u0006\b\n\f\u0000\u0000[\u0000\u000f\u0001"+
		"\u0000\u0000\u0000\u0002\u0015\u0001\u0000\u0000\u0000\u0004 \u0001\u0000"+
		"\u0000\u0000\u0006\"\u0001\u0000\u0000\u0000\b,\u0001\u0000\u0000\u0000"+
		"\nQ\u0001\u0000\u0000\u0000\fS\u0001\u0000\u0000\u0000\u000e\u0010\u0003"+
		"\u0002\u0001\u0000\u000f\u000e\u0001\u0000\u0000\u0000\u0010\u0011\u0001"+
		"\u0000\u0000\u0000\u0011\u000f\u0001\u0000\u0000\u0000\u0011\u0012\u0001"+
		"\u0000\u0000\u0000\u0012\u0013\u0001\u0000\u0000\u0000\u0013\u0014\u0005"+
		"\u0000\u0000\u0001\u0014\u0001\u0001\u0000\u0000\u0000\u0015\u0016\u0005"+
		"\b\u0000\u0000\u0016\u0018\u0005\u000f\u0000\u0000\u0017\u0019\u0003\u0004"+
		"\u0002\u0000\u0018\u0017\u0001\u0000\u0000\u0000\u0019\u001a\u0001\u0000"+
		"\u0000\u0000\u001a\u0018\u0001\u0000\u0000\u0000\u001a\u001b\u0001\u0000"+
		"\u0000\u0000\u001b\u001c\u0001\u0000\u0000\u0000\u001c\u001d\u0005\t\u0000"+
		"\u0000\u001d\u0003\u0001\u0000\u0000\u0000\u001e!\u0003\u0006\u0003\u0000"+
		"\u001f!\u0003\b\u0004\u0000 \u001e\u0001\u0000\u0000\u0000 \u001f\u0001"+
		"\u0000\u0000\u0000!\u0005\u0001\u0000\u0000\u0000\"#\u0005\u000f\u0000"+
		"\u0000#$\u0005\u000e\u0000\u0000$&\u0005\u000f\u0000\u0000%\'\u0003\n"+
		"\u0005\u0000&%\u0001\u0000\u0000\u0000\'(\u0001\u0000\u0000\u0000(&\u0001"+
		"\u0000\u0000\u0000()\u0001\u0000\u0000\u0000)*\u0001\u0000\u0000\u0000"+
		"*+\u0005\n\u0000\u0000+\u0007\u0001\u0000\u0000\u0000,-\u0005\u000f\u0000"+
		"\u0000-.\u0005\u000e\u0000\u0000./\u0005\u000f\u0000\u0000/0\u0005\u000b"+
		"\u0000\u000001\u0005\u0001\u0000\u000012\u0005\u000f\u0000\u000023\u0005"+
		"\f\u0000\u000034\u0005\u000f\u0000\u00004\t\u0001\u0000\u0000\u000056"+
		"\u0005\u0002\u0000\u000067\u0005\u000f\u0000\u000078\u0005\u000f\u0000"+
		"\u000089\u0005\r\u0000\u00009=\u0005\u000f\u0000\u0000:<\u0003\f\u0006"+
		"\u0000;:\u0001\u0000\u0000\u0000<?\u0001\u0000\u0000\u0000=;\u0001\u0000"+
		"\u0000\u0000=>\u0001\u0000\u0000\u0000>R\u0001\u0000\u0000\u0000?=\u0001"+
		"\u0000\u0000\u0000@A\u0005\u0003\u0000\u0000AB\u0005\u000f\u0000\u0000"+
		"BC\u0005\u000f\u0000\u0000CD\u0005\u000f\u0000\u0000DR\u0005\u000f\u0000"+
		"\u0000EF\u0005\u0004\u0000\u0000FR\u0005\u000f\u0000\u0000GH\u0005\u0005"+
		"\u0000\u0000HR\u0005\u000f\u0000\u0000IJ\u0005\u0006\u0000\u0000JR\u0005"+
		"\u000f\u0000\u0000KL\u0005\u0001\u0000\u0000LM\u0005\u000f\u0000\u0000"+
		"MN\u0005\f\u0000\u0000NR\u0005\u000f\u0000\u0000OP\u0005\u0007\u0000\u0000"+
		"PR\u0005\u000f\u0000\u0000Q5\u0001\u0000\u0000\u0000Q@\u0001\u0000\u0000"+
		"\u0000QE\u0001\u0000\u0000\u0000QG\u0001\u0000\u0000\u0000QI\u0001\u0000"+
		"\u0000\u0000QK\u0001\u0000\u0000\u0000QO\u0001\u0000\u0000\u0000R\u000b"+
		"\u0001\u0000\u0000\u0000ST\u0005\u000f\u0000\u0000TU\u0005\f\u0000\u0000"+
		"UV\u0005\u000f\u0000\u0000V\r\u0001\u0000\u0000\u0000\u0006\u0011\u001a"+
		" (=Q";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}