//
//  STStatementNode.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/15/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STBaseNode.h"

typedef enum {
    STStmtIf = 0,
    STStmtWhile,
    STStmtAssign,
    STStmtOpCalc,
    STStmtOpRel,
    STStmtCall,
    STStmtReturn
} STStmtType;

@interface STStatementNode : STBaseNode

@property STStmtType type;

/*
 If:
    cond:
    true_stmts:
    false_stmts:
 
*/


@end
