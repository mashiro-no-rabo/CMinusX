//
//  TMInst.h
//  CMinX
//
//  Created by AquarHEAD L. on 6/7/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    opclLRR = 0,
    opclLRM,
    opclLRI
} T_OPCLASS;

typedef enum {
    opHALT = 0,
    opIN,
    opOUT,
    opADD,
    opSUB,
    opMUL,
    opDIV,
    
    opLD,
    opST,
    
    opLDA,
    opLDC,
    opJLT,
    opJLE,
    opJGT,
    opJGE,
    opJEQ,
    opJNE
} T_OPCODE;

@interface TMInst : NSObject

@property T_OPCLASS opClass;
@property T_OPCODE opCode;

@property NSString *rawInst;
@property NSUInteger lineNo; // associated line number

@property int arg_R; // opcode R, S, T
@property int arg_S;
@property int arg_T; // opcode R, T(S)

- (id)initWithString:(NSString *)inst;

@end
