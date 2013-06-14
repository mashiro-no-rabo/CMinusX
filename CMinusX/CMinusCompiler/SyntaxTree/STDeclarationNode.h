//
//  STDeclarationNode.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/15/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    STDeclVar = 0,
    STDeclFunc
} STDeclType;

@interface STDeclarationNode : NSObject

@property STDeclType type;
@property (strong, nonatomic) NSMutableDictionary *info;

/*
 Variable:
    type:
    size:
    id:
 
 Function:
    args:
    return:
    id:
    statements:
 */

@end
