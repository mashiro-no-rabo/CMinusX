//
//  CMToken.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMToken.h"

NSString *const _TokenName[TokenCommentEnd+1] = {
    [TokenID] = @"TokenID",
    [TokenNUM] = @"TokenNUM",
    [TokenIf] = @"TokenIf",
    [TokenElse] = @"TokenElse",
    [TokenInt] = @"TokenInt",
    [TokenReturn] = @"TokenReturn",
    [TokenVoid] = @"TokenVoid",
    [TokenWhile] = @"TokenWhile",
    [TokenOpCalcAdd] = @"TokenOpCalcAdd",
    [TokenOpCalcSub] = @"TokenOpCalcSub",
    [TokenOpCalcMul] = @"TokenOpCalcMul",
    [TokenOpCalcDiv] = @"TokenOpCalcDiv",
    [TokenOpRelLT] = @"TokenOpRelLT",
    [TokenOpRelLE] = @"TokenOpRelLE",
    [TokenOpRelGT] = @"TokenOpRelGT",
    [TokenOpRelGE] = @"TokenOpRelGE",
    [TokenOpRelEQ] = @"TokenOpRelEQ",
    [TokenOpRelNE] = @"TokenOpRelNE",
    [TokenAssign] = @"TokenAssign",
    [TokenStmtEnd] = @"TokenStmtEnd",
    [TokenComma] = @"TokenComma",
    [TokenArgsLeft] = @"TokenArgsLeft",
    [TokenArgsRight] = @"TokenArgsRight",
    [TokenArrayLeft] = @"TokenArrayLeft",
    [TokenArrayRight] = @"TokenArrayRight",
    [TokenFuncLeft] = @"TokenFuncLeft",
    [TokenFuncRight] = @"TokenFuncRight",
    [TokenCommentStart] = @"TokenCommentStart",
    [TokenCommentEnd] = @"TokenCommentEnd"
};

@implementation CMToken

+ (CMToken *)tokenWithType:(TokenType)type lineno:(NSUInteger)lineno andInfo:(NSDictionary *)info {
    CMToken *tk = [CMToken new];
    tk.type = type;
    tk.lineno = lineno;
    tk.info = info;
    return tk;
}

- (BOOL)isEqual:(id)object {
    CMToken *other = (CMToken *)object;
    if (self.type != other.type)
        return NO;
    if (self.lineno != other.lineno)
        return NO;
    if (self.info != other.info)
        return NO;
    return YES;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%ld %@ %@", (unsigned long)self.lineno, _TokenName[self.type], self.info];
}

@end
