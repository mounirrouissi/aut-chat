grammar Aiva;

// -------------------- Parser Rules --------------------

script
    : track+ EOF
    ;

track
    : 'START_TRACK' IDENTIFIER state+ 'END_TRACK'
    ;

state
    : action_block_state
    | reactive_goto_state
    ;

// block state with actions (S1. START ... END)
action_block_state
    : IDENTIFIER '.' IDENTIFIER action+ 'END'
    ;

// single-line reactive goto state (R1. LABEL > GOTO TRACK:STATE)
reactive_goto_state
    : IDENTIFIER '.' IDENTIFIER '>' 'GOTO' IDENTIFIER ':' IDENTIFIER
    ;

// multiple action types (branch optional for CALL_FUNCTION_SWITCH)
action
    : 'CALL_FUNCTION_SWITCH' IDENTIFIER IDENTIFIER '->' IDENTIFIER branch*    // branches optional inline
    | 'SENDMESSAGE' IDENTIFIER IDENTIFIER IDENTIFIER IDENTIFIER
    | 'MARK_LEAD_PHASE' IDENTIFIER
    | 'UNSCHEDULE' IDENTIFIER
    | 'SWITCH_DIRECTION' IDENTIFIER
    | 'GOTO' IDENTIFIER ':' IDENTIFIER
    | 'SEND_TEMPLATE' IDENTIFIER
    ;

// legacy inline branch notation (VIP : R1)
branch
    : IDENTIFIER ':' IDENTIFIER
    ;

// -------------------- Lexer Rules --------------------

// explicit keywords (put before IDENTIFIER so lexer prefers them)
GOTO: 'GOTO';
CALL_FUNCTION_SWITCH: 'CALL_FUNCTION_SWITCH';
SENDMESSAGE: 'SENDMESSAGE';
MARK_LEAD_PHASE: 'MARK_LEAD_PHASE';
UNSCHEDULE: 'UNSCHEDULE';
SWITCH_DIRECTION: 'SWITCH_DIRECTION';
SEND_TEMPLATE: 'SEND_TEMPLATE';
START_TRACK: 'START_TRACK';
END_TRACK: 'END_TRACK';
END: 'END';

// symbols (optional tokens)
GT: '>';
COLON: ':';
ARROW: '->';
DOT: '.';

// IDENTIFIER: allow leading @ or $ (templates/vars) and hyphens inside names
IDENTIFIER: [@\\$A-Za-z_][-@\\$A-Za-z0-9_]* ;

// Whitespace
WS: [ \t\r\n]+ -> skip ;
