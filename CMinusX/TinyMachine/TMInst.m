//
//  TMInst.m
//  CMinX
//
//  Created by AquarHEAD L. on 6/7/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "TMInst.h"

@implementation TMInst

- (id)initWithString:(NSString *)inst {
    NSString *instCode = [inst componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]][0];
    
    /* LRR Inst */
    if ([instCode isEqualToString:@"HALT"]) {
        self.opClass = opclLRR;
        self.opCode = opHALT;
    }
    else if ([instCode isEqualToString:@"IN"]) {
        self.opClass = opclLRR;
        self.opCode = opIN;
    }
    else if ([instCode isEqualToString:@"OUT"]) {
        self.opClass = opclLRR;
        self.opCode = opOUT;
    }
    else if ([instCode isEqualToString:@"ADD"]) {
        self.opClass = opclLRR;
        self.opCode = opADD;
    }
    else if ([instCode isEqualToString:@"SUB"]) {
        self.opClass = opclLRR;
        self.opCode = opSUB;
    }
    else if ([instCode isEqualToString:@"MUL"]) {
        self.opClass = opclLRR;
        self.opCode = opMUL;
    }
    else if ([instCode isEqualToString:@"DIV"]) {
        self.opClass = opclLRR;
        self.opCode = opDIV;
    }
    /* LRM Inst */
    else if ([instCode isEqualToString:@"LD"]) {
        self.opClass = opclLRM;
        self.opCode = opLD;
    }
    else if ([instCode isEqualToString:@"ST"]) {
        self.opClass = opclLRM;
        self.opCode = opST;
    }
    /* LRI Inst */
    else if ([instCode isEqualToString:@"LDA"]) {
        self.opClass = opclLRI;
        self.opCode = opLDA;
    }
    else if ([instCode isEqualToString:@"LDC"]) {
        self.opClass = opclLRI;
        self.opCode = opLDC;
    }
    else if ([instCode isEqualToString:@"JLT"]) {
        self.opClass = opclLRI;
        self.opCode = opJLT;
    }
    else if ([instCode isEqualToString:@"JLE"]) {
        self.opClass = opclLRI;
        self.opCode = opJLE;
    }
    else if ([instCode isEqualToString:@"JGT"]) {
        self.opClass = opclLRI;
        self.opCode = opJGT;
    }
    else if ([instCode isEqualToString:@"JGE"]) {
        self.opClass = opclLRI;
        self.opCode = opJGE;
    }
    else if ([instCode isEqualToString:@"JEQ"]) {
        self.opClass = opclLRI;
        self.opCode = opJEQ;
    }
    else if ([instCode isEqualToString:@"JNE"]) {
        self.opClass = opclLRI;
        self.opCode = opJNE;
    }
    
    NSArray *argsPart = [[inst substringFromIndex:[instCode length]] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", ()"]];
    self.arg_R = [argsPart[0] intValue];
    
    if (self.opClass == opclLRR) {
        self.arg_S = [argsPart[1] intValue];
        self.arg_T = [argsPart[2] intValue];
    }
    else {
        self.arg_S = [argsPart[2] intValue];
        self.arg_T = [argsPart[1] intValue];
    }
    
    return self;
}

@end
