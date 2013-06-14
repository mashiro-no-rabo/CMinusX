//
//  STStatementNode.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/15/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    STStmtIf = 0,
    STStmtWhile,
    STStmtAssign,
    STStmtCalc,
    STStmtRel,
    STStmtCall
} STStmtType;

@interface STStatementNode : NSObject

@property STStmtType type;

@end
