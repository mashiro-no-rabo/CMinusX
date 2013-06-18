//
//  TinyMachine.m
//  CMinX
//
//  Created by AquarHEAD L. on 6/6/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "TinyMachine.h"

@interface TinyMachine() {
    long long regs[REGS_SIZE];
}

@end

@implementation TinyMachine

- (void)clean {
    self.output = [NSMutableArray new];
    self.dataMem = [NSMutableDictionary new];
    for (int i=0; i<REGS_SIZE; i++) {
        regs[i] = 0;
    }
}

- (void)fillInstMemWithString:(NSString *)prog {
    self.instMem = [NSMutableArray new];
    [self clean];
    NSArray *lines = [prog componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    int ln = 0;
    for (NSString *line in lines) {
        ln += 1;
        [self.instMem addObject:[[TMInst alloc] initWithString:line ofLineNo:ln]];
    }
    self.lineCount = ln;
}

- (TMStepResult *)run {
    TMStepResult *r = [self step];
    while (r.type != srHALT) {
        if (r.type != srOKAY) {
            return r;
        }
        r = [self step];
    }
    return r;
}

- (TMStepResult *)step {
    
    long long pc = regs[PC_REG];
    if (pc < 0) {
        TMStepResult *result = [TMStepResult new];
        result.type = srIMEM_ERR;
        result.message = @"PC off range!";
        return result;
    }
    regs[PC_REG] += 1;
    
    TMInst *thisInst = [self.instMem objectAtIndex:pc];
    long long r = thisInst.arg_R;
    long long s = thisInst.arg_S;
    long long t = thisInst.arg_T;
    long long d = thisInst.arg_T;
    long long a = regs[s] + d;
    
    long long inputPos = 0;
    
    if (thisInst.opCode == opHALT) {
        return [TMStepResult resultHALT];
    }
    else if (thisInst.opCode == opIN) {
        regs[r] = [[self.input objectAtIndex:inputPos] intValue];
        inputPos += 1;
    }
    else if (thisInst.opCode == opOUT) {
        [self.output addObject:[NSNumber numberWithLongLong:regs[r]]];
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
            result.message = @"Divide by zero!";
            return result;
        }
        regs[r] = regs[s] / regs[t];
    }
    else if (thisInst.opCode == opLD) {
        if ([self.dataMem objectForKey:[NSNumber numberWithLongLong:a]]) {
            regs[r] = [[self.dataMem objectForKey:[NSNumber numberWithLongLong:a]] longLongValue];
        }
        else {
            regs[r] = 0;
        }
    }
    else if (thisInst.opCode == opST) {
        [self.dataMem setObject:[NSNumber numberWithLongLong:regs[r]] forKey:[NSNumber numberWithLongLong:a]];
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

- (TMInst *)nextInst {
    long long pc = regs[PC_REG];
    long long npc = pc + 1;
    
    TMInst *thisInst = [self.instMem objectAtIndex:pc];
    
    long long r = thisInst.arg_R;
    long long s = thisInst.arg_S;
    long long d = thisInst.arg_T;
    long long a = regs[s] + d;
    
    if (thisInst.opCode == opJLT) {
        if (regs[r] < 0) {
            npc = a;
        }
    }
    else if (thisInst.opCode == opJLE) {
        if (regs[r] <= 0) {
            npc = a;
        }
    }
    else if (thisInst.opCode == opJGT) {
        if (regs[r] > 0) {
            npc = a;
        }
    }
    else if (thisInst.opCode == opJGE) {
        if (regs[r] >= 0) {
            npc = a;
        }
    }
    else if (thisInst.opCode == opJEQ) {
        if (regs[r] == 0) {
            npc = a;
        }
    }
    else if (thisInst.opCode == opJNE) {
        if (regs[r] != 0) {
            npc = a;
        }
    }
    
    TMInst *nextInst = [self.instMem objectAtIndex:npc];
    
    return nextInst;
}

- (TMInst *)thisInst {
    return [self.instMem objectAtIndex:regs[PC_REG]];
}

- (long long)regContent:(int)index {
    return regs[index];
}

@end
