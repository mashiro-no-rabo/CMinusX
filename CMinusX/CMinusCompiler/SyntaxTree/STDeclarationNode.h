//
//  STDeclarationNode.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/15/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STBaseNode.h"

typedef enum {
    STDeclVar = 0,
    STDeclFunc
} STDeclType;

@interface STDeclarationNode : STBaseNode

@property STDeclType type;

/*
 Variable:
    type:
    size:
    id:
 
 Function:
    args:
    return:
    statements:
    id:
 */

@end
