//
//  CMToken.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMToken.h"

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

@end
