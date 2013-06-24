//
//  CMScanner.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

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