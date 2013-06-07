//
//  TinyMachine.m
//  CMinX
//
//  Created by AquarHEAD L. on 6/6/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "TinyMachine.h"

@interface TinyMachine()

@end

@implementation TinyMachine

- (id)init {
    self = [super init];
    
    if (self) {
        self.instMem = [NSMutableArray new];
        self.dataMem = [NSMutableArray new];
        for (int i=0; i<REGS_SIZE; i++) {
            regs[i] = 0;
        }
    }
    
    return self;
}


- (TMStepResult *)step {
    
    int pc = regs[PC_REG];
    if (pc < 0) {
        TMStepResult *result = [TMStepResult new];
        result.type = srIMEM_ERR;
        return result;
    }
    regs[PC_REG] += 1;
    
    TMInst *thisInst = [self.instMem objectAtIndex:pc];
    int r = thisInst.arg_R;
    int s = thisInst.arg_S;
    int t = thisInst.arg_T;
    int d = thisInst.arg_T;
    int a = regs[s] + d;
    
    if (thisInst.opCode == opHALT) {
        return [TMStepResult resultHALT];
    }
    else if (thisInst.opCode == opIN) {
#warning need implement INPUT
    }
    else if (thisInst.opCode == opOUT) {
        NSLog(@"%d", regs[thisInst.arg_R]);
    }
    else if (thisInst.opCode == opADD) {
        regs[r] = regs[s] + regs[t];
    }
    else if (thisInst.opCode == opSUB) {
        regs[r] = regs[s] - regs[t];
    }
    else if (thisInst.opCode == opMUL) {
        regs[r] = regs[s] * regs[t];
    }
    else if (thisInst.opCode == opDIV) {
        if (regs[t] == 0) {
            TMStepResult *result = [TMStepResult new];
            result.type = srZERODIVIDE;
            return result;
        }
        regs[r] = regs[s] / regs[t];
    }
    else if (thisInst.opCode == opLD) {
        regs[r] = [(NSNumber*)[self.dataMem objectAtIndex:a] intValue];
    }
    else if (thisInst.opCode == opST) {
        [self.dataMem replaceObjectAtIndex:a withObject:[NSNumber numberWithInt:regs[r]]];
    }
    else if (thisInst.opCode == opLDA) {
        regs[r] = a;
    }
    else if (thisInst.opCode == opLDC) {
        regs[r] = d;
    }
    else if (thisInst.opCode == opJLT) {
        if (regs[r] < 0) {
            regs[PC_REG] = a;
        }
    }
    else if (thisInst.opCode == opJLE) {
        if (regs[r] <= 0) {
            regs[PC_REG] = a;
        }
    }
    else if (thisInst.opCode == opJGT) {
        if (regs[r] > 0) {
            regs[PC_REG] = a;
        }
    }
    else if (thisInst.opCode == opJGE) {
        if (regs[r] >= 0) {
            regs[PC_REG] = a;
        }
    }
    else if (thisInst.opCode == opJEQ) {
        if (regs[r] == 0) {
            regs[PC_REG] = a;
        }
    }
    else if (thisInst.opCode == opJNE) {
        if (regs[r] != 0) {
            regs[PC_REG] = a;
        }
    }
        
    return [TMStepResult resultOKAY];
}

- (TMStepResult *)stepLine {
    return [TMStepResult resultOKAY];
}

@end
