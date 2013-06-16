//
//  CMToken.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface CMToken : NSObject

@property TokenType type;
@property NSUInteger lineno;
@property (strong, nonatomic) NSDictionary *info;

+ (CMToken *)tokenWithType:(TokenType)type lineno:(NSUInteger)lineno andInfo:(NSDictionary *)info;

@end
