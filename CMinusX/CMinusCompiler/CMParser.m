//
//  CMParser.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMParser.h"
#import "STDeclarationNode.h"
#import "STStatementNode.h"

@interface CMParser()

@property int tkpos;
@property (strong, nonatomic) NSArray *tokens;

@end

@implementation CMParser

- (id)initWithTokens:(NSArray *)tokens {
    self = [super init];
    
    if (self) {
        self.tkpos = 0;
        self.tokens = tokens;
    }
    
    return self;
}

- (STProgramNode *)parse {
    STProgramNode *root = [STProgramNode new];
    while (self.tkpos < [self.tokens count]) {
        STDeclarationNode *node;
        node = [self matchVarDecl];
        if (node == nil) {
            node = [self matchFuncDecl];
        }
    }
    return root;
}

- (STDeclarationNode *)matchVarDecl {
    ;
}

- (STDeclarationNode *)matchFuncDecl {
    ;
}



@end
