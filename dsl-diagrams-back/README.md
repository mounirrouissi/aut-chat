# dsl-diagrams
app to convert dsl script into ui diagrams and vice versa 


### The Big Picture: A Blueprint for Language

Think of this file as a formal blueprint that describes a language's structure. It's written in ANTLR's own grammar syntax. The ANTLR tool reads this blueprint and automatically generates two Java classes for you:

1.  **A Lexer (`AivaLexer.java`):** Its job is to break your raw script text into a sequence of "tokens" or words. It's like splitting an English sentence into nouns, verbs, and punctuation.
2.  **A Parser (`AivaParser.java`):** Its job is to take the sequence of tokens from the Lexer and check if they form valid "sentences" according to the grammar rules. If they do, it creates a structured data object called a Parse Tree.

This explanation will be split into the two main sections of the file: **Lexer Rules** and **Parser Rules**.

---

### Part 1: The Lexer Rules (The "Words")

The Lexer's job is to define the vocabulary of your language. These rules are typically at the bottom of the file and written in all caps.

```antlr4
// Lexer Rules (Tokens)
IDENTIFIER: [a-zA-Z_@][a-zA-Z_0-9]*;
WS: [ \t\r\n]+ -> skip; // Skip whitespace
```

#### `IDENTIFIER`
*   **`IDENTIFIER:`** This defines a new token type named `IDENTIFIER`.
*   **`[a-zA-Z_@]`**: This is a regular expression that means "the first character *must* be a letter (lowercase or uppercase), an underscore, or an `@` symbol." This is why names like `S1`, `customerUtils`, and `@customerType` are all valid.
*   **`[a-zA-Z_0-9]*`**: This means "after the first character, you can have *zero or more* characters that are letters, underscores, or numbers."
*   **In simple terms:** An `IDENTIFIER` is any word that starts with a letter, underscore, or `@`, and is followed by any combination of letters, numbers, or underscores.
*   **Examples of `IDENTIFIER`s:** `S1`, `START`, `WelcomeTrack`, `customerUtils`, `@customerType`, `vipGreeting`.

#### `WS` (Whitespace)
*   **`WS:`**: This defines a token for whitespace.
*   **`[ \t\r\n]+`**: This regular expression means "match one or more (`+`) characters that are a space (` `), a tab (`\t`), a carriage return (`\r`), or a newline (`\n`)."
*   **`-> skip`**: This is a special ANTLR command. It tells the Lexer, "If you find this pattern, don't create a token for it. Just throw it away and move on." This is incredibly important because it means the formatting of your script (extra spaces, new lines) doesn't affect the parsing logic at all.

---

### Part 2: The Parser Rules (The "Sentences")

The Parser rules define the grammar—how you can combine the "words" (tokens) into valid structures. These are typically at the top and written in lowercase.

Let's go through them from the top down, from the biggest structure to the smallest.

#### `script`
```antlr4
script: track;
```
*   This is the entry point, the top-level rule. It says: "A valid `script` consists of exactly one `track`."

#### `track`
```antlr4
track: 'START_TRACK' IDENTIFIER state+ 'END_TRACK'?;
```
*   This rule defines a `track`. It must be a precise sequence:
    1.  `'START_TRACK'`: The literal text `START_TRACK`. These are implicit tokens defined by the literal text in quotes.
    2.  `IDENTIFIER`: A token for the track's name (e.g., `WelcomeTrack`).
    3.  `state+`: One or more (`+`) instances of the `state` rule. This is why a track must have at least one state.
    4.  `'END_TRACK'?`: The literal text `END_TRACK`. The question mark (`?`) means this part is **optional** (it can appear zero or one time).

#### `state`
```antlr4
state: IDENTIFIER '.' IDENTIFIER action+;
```
*   This rule defines a `state`. It's a sequence of:
    1.  `IDENTIFIER`: The state's ID (e.g., `S1`).
    2.  `'.'`: A literal dot character.
    3.  `IDENTIFIER`: The state's type (e.g., `START`).
    4.  `action+`: One or more (`+`) instances of the `action` rule. A state is not valid unless it has at least one action.

#### `action`
```antlr4
action:
    'CALL_FUNCTION_SWITCH' IDENTIFIER IDENTIFIER '->' IDENTIFIER branch+
    | 'SEND_TEMPLATE' IDENTIFIER
    | 'GOTO' IDENTIFIER;
```
*   This rule defines an `action`. The pipe character (`|`) means **OR**. An action can be one of three possible patterns:
    1.  **Pattern 1 (SWITCH):** The literal text `'CALL_FUNCTION_SWITCH'`, followed by four `IDENTIFIER`s (e.g., `customerUtils`, `findCustomerType`, `->`, `@customerType`), followed by one or more `branch`es.
    2.  **Pattern 2 (SEND):** The literal text `'SEND_TEMPLATE'`, followed by one `IDENTIFIER` (e.g., `vipGreeting`).
    3.  **Pattern 3 (GOTO):** The literal text `'GOTO'`, followed by one `IDENTIFIER` (e.g., `S3`).

#### `branch`
```antlr4
branch: IDENTIFIER ':' IDENTIFIER;
```
*   This is the smallest building block. It defines a `branch` inside a SWITCH action. It is simply:
    1.  `IDENTIFIER`: The case label (e.g., `VIP`).
    2.  `':'`: A literal colon character.
    3.  `IDENTIFIER`: The target state ID (e.g., `R1`).

### Summary: How It All Works Together

When you give the generated parser your script:
1.  The **Lexer** scans the text `S1. START SEND_TEMPLATE vipGreeting`. It ignores the whitespace and produces a list of tokens: `[IDENTIFIER('S1'), '.', IDENTIFIER('START'), 'SEND_TEMPLATE', IDENTIFIER('vipGreeting')]`.
2.  The **Parser** takes this token list. It tries to match the `script` rule. To do that, it needs to match a `track`, which needs to match a `state`.
3.  The Parser sees `IDENTIFIER`, `.`, `IDENTIFIER` which matches the first part of the `state` rule.
4.  It then looks for an `action`. It sees `'SEND_TEMPLATE'` followed by `IDENTIFIER`. It checks the `action` rule and finds that this perfectly matches the second pattern (`'SEND_TEMPLATE' IDENTIFIER`).
5.  Because all the tokens fit the grammar rules, the parser succeeds and builds a Parse Tree, which you then walk in your controller to build your custom data structure (the AST).