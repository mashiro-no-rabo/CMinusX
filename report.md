# CMinusX

A C- IDE for Mac OS X

## Some Notable Features

- A full-featured editor: syntax highlight, auto-complete, themes, etc..
- Can run and debug both C- code and TM instructions
- Step debug, with realtime regs and memory information
- Save project file, for later reuse

## Overall Structure

CMinusX is divided into 2 parts in general:

1. Application
2. Unit Test

The Application part contains the following parts:

1. User Interface (Code editor and Debug info)
2. Tiny Machine emulator
3. C- Compiler

The Unit Test part is used for testing each single part of the application, such as:

1. Tiny Machine
2. CMScanner (C- Scanner)
3. CMParser (C- Parser)

## Tiny Machine

The Tiny Machine is an emulator for executing some simple instructions as described in the textbook.

As in the textbook, our implementation has 8 regs, but we implemented unlimited inst and data memory for code usage.

We also attach line number information with each instruction, providing necessary information for debug usage.

It's completely wrote in Objective-C from ground up.

## C- Compiler

The compiler is divided into mostly 3 parts with some auxilary function:

1. CMScanner
2. CMParser
3. CMCodeGener

### CMScanner

We wrote the scanner using Ragel, a state machine compiler targets many different languages.

The complete code of our ragel input file is:

```
#import "CMScanner.h"

@implementation CMScanner

%%{

    machine CMinusScanner;
    write data;

    number = [0-9]+;
    identifier = [a-zA-Z]+;

    main := |*
    
    '\n' => {
        lineno += 1;
    };
    
    "if" => {
        [result addObject: [CMToken tokenWithType:TokenIf lineno:lineno andInfo:nil]];
    };
    
    "else" => {
        [result addObject: [CMToken tokenWithType:TokenElse lineno:lineno andInfo:nil]];
    };
    
    "int" => {
        [result addObject: [CMToken tokenWithType:TokenInt lineno:lineno andInfo:nil]];
    };
    
    "return" => {
        [result addObject: [CMToken tokenWithType:TokenReturn lineno:lineno andInfo:nil]];
    };
    
    "void" => {
        [result addObject: [CMToken tokenWithType:TokenVoid lineno:lineno andInfo:nil]];
    };
    
    "while" => {
        [result addObject: [CMToken tokenWithType:TokenWhile lineno:lineno andInfo:nil]];
    };
    
    "+" => {
        [result addObject: [CMToken tokenWithType:TokenOpCalcAdd lineno:lineno andInfo:nil]];
    };
    
    "-" => {
        [result addObject: [CMToken tokenWithType:TokenOpCalcSub lineno:lineno andInfo:nil]];
    };
    
    "*" => {
        [result addObject: [CMToken tokenWithType:TokenOpCalcMul lineno:lineno andInfo:nil]];
    };
    
    "/" => {
        [result addObject: [CMToken tokenWithType:TokenOpCalcDiv lineno:lineno andInfo:nil]];
    };
    
    "<" => {
        [result addObject: [CMToken tokenWithType:TokenOpRelLT lineno:lineno andInfo:nil]];
    };
    
    "<=" => {
        [result addObject: [CMToken tokenWithType:TokenOpRelLE lineno:lineno andInfo:nil]];
    };
    
    ">" => {
        [result addObject: [CMToken tokenWithType:TokenOpRelGT lineno:lineno andInfo:nil]];
    };
    
    ">=" => {
        [result addObject: [CMToken tokenWithType:TokenOpRelGE lineno:lineno andInfo:nil]];
    };
    
    "==" => {
        [result addObject: [CMToken tokenWithType:TokenOpRelEQ lineno:lineno andInfo:nil]];
    };
    
    "!=" => {
        [result addObject: [CMToken tokenWithType:TokenOpRelNE lineno:lineno andInfo:nil]];
    };
    
    "=" => {
        [result addObject: [CMToken tokenWithType:TokenAssign lineno:lineno andInfo:nil]];
    };
    
    ";" => {
        [result addObject: [CMToken tokenWithType:TokenStmtEnd lineno:lineno andInfo:nil]];
    };
    
    "," => {
        [result addObject: [CMToken tokenWithType:TokenComma lineno:lineno andInfo:nil]];
    };
    
    "(" => {
        [result addObject: [CMToken tokenWithType:TokenArgsLeft lineno:lineno andInfo:nil]];
    };
    
    ")" => {
        [result addObject: [CMToken tokenWithType:TokenArgsRight lineno:lineno andInfo:nil]];
    };
    
    "[" => {
        [result addObject: [CMToken tokenWithType:TokenArrayLeft lineno:lineno andInfo:nil]];
    };
    
    "]" => {
        [result addObject: [CMToken tokenWithType:TokenArrayRight lineno:lineno andInfo:nil]];
    };
    
    "{" => {
        [result addObject: [CMToken tokenWithType:TokenFuncLeft lineno:lineno andInfo:nil]];
    };
    
    "}" => {
        [result addObject: [CMToken tokenWithType:TokenFuncRight lineno:lineno andInfo:nil]];
    };

    identifier => {
        [result addObject: [CMToken tokenWithType:TokenID lineno:lineno andInfo:@{@"id": [[NSString stringWithCString:ts encoding:NSASCIIStringEncoding] substringToIndex:te-ts]}]];
    };

    number => {
        [result addObject: [CMToken tokenWithType:TokenNUM lineno:lineno andInfo:@{@"value": [NSNumber numberWithInt:[[[NSString stringWithCString:ts encoding:NSASCIIStringEncoding] substringToIndex:te-ts] intValue]]}]];
    };
    
    space - '\n';
    
    *|;

}%%

+ (NSArray *)scan:(NSString *)input {
    NSMutableArray *result = [NSMutableArray new];
    NSUInteger lineno = 1;
    int cs, act;
    const char *ts, *te;
    const char *p = [input cStringUsingEncoding: NSASCIIStringEncoding];
    const char *pe = p + [input length];
    const char *eof = pe;
    %% write init;
    %% write exec;
    return [result copy];
}

@end
```

With this ragel code, we can generate our scanner code directly.

The `+scan` function takes a string input which shoule be the code in the editor, and generates an array of `CMToken`, each token can be any of the following type:

```
typedef enum {
    TokenID = 0,
    TokenNUM,
    TokenIf,
    TokenElse,
    TokenInt,
    TokenReturn,
    TokenVoid,
    TokenWhile,
    TokenOpCalcAdd,
    TokenOpCalcSub,
    TokenOpCalcMul,
    TokenOpCalcDiv,
    TokenOpRelLT,
    TokenOpRelLE,
    TokenOpRelGT,
    TokenOpRelGE,
    TokenOpRelEQ,
    TokenOpRelNE,
    TokenAssign,
    TokenStmtEnd,
    TokenComma,
    TokenArgsLeft,
    TokenArgsRight,
    TokenArrayLeft,
    TokenArrayRight,
    TokenFuncLeft,
    TokenFuncRight,
    TokenCommentStart,
    TokenCommentEnd
} TokenType;
```

### CMParser

The parser is a handwritten parser using some recursive-descent method, it uses the token array to generate a syntax tree.

Our designed syntax tree node types are all based on a base type named `STBaseNode` and contains the following:

1. `STProgramNode`
2. `STDeclarationNode`
3. `STStmtNode`
4. `STArgumentNode`

Also, here we need a symbol table for recording IDs, the symbol table has `insert`, `lookup`, `delete` method, and also `pushLevel` and `popLevel` for embedded scope.

The `-parse` method generates a syntax tree rooted with a `STProgramNode`.

First, the parser would call `-matchDecl` to match each declaration in the code, in this method it would recognize whether it's a global variable declaration or a function declaration.

Then, for function declarations, it would call `-matchStmt` to match each statements in the function body, for expressions it would call `-matchExp` to recursive-descently match expressions.

And we rewrite some grammar rules for convinience of match code as follow:

```
Exp -> Term { addop Term }
Term -> Factor { mulop Factor }
Factor -> ( Exp ) | ID | ID[sub] | ID(args) | NUM

args -> Exp { , Exp }
```

### CMCodeGener

This is the final part of the compiler, which reads in the syntax tree, and generate a series of TM instructions based on the tree.

## Editor and Debug functionality

CMinusX has a full-featured editor provided by ACEView (a project based on Ace editor), after written the code, you need also provide the input in the input field.

Choose the correct mode (either `C-` or `TM Inst`) and click `Run`, the result will be displayed in the output textfield.

By clicking `Debug`, you can enter debug mode, which also open a `Debug Info` window showing regs and memory info, in this mode you can step over each TM instruction and see how the regs change, the status line will tell you whether each step gets correctly executed, after the debug done, the status would say `Status: Done`.

## References

1. [Ragel](www.complang.org/ragel): a state machine compiler
2. [ACEView](github.com/faceleg/ACEView): the editor project, we used a [customized version](github.com/AquarHEAD/ACEView)
3. [CocoaPods](cocoapods.org): the dependency manager for XCode projects
