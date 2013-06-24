//
//  CMParser.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STProgramNode.h"
#import "SymbolTable.h"

@interface CMParser : NSObject

@property (strong, nonatomic) SymbolTable *symtab;

- (id)initWithTokens:(NSArray *)tokens;
- (STProgramNode *)parse;

@end
