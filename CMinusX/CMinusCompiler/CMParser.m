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
#import "CMToken.h"

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
        self.symtab = [SymbolTable new];
    }
    
    return self;
}

- (STProgramNode *)parse {
    STProgramNode *root = [STProgramNode new];
    while (self.tkpos < [self.tokens count]) {
        STDeclarationNode *node;
        node = [self matchDecl];
    }
    return root;
}

- (STDeclarationNode *)matchDecl {
    STDeclarationNode *decl = [STDeclarationNode new];
    int oripos = self.tkpos;
    CMToken *tk = self.tokens[self.tkpos];
    if (tk.type == TokenInt) {
        CMToken *idtk = [self nextToken];
        if (idtk.type == TokenID) {
            if ([self nextToken].type == TokenStmtEnd) {
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"int"}];
            }
            else if ([self nextToken].type == TokenArrayLeft) {
                
            }
            else if (self.tokens[tmppos+1])
        }
        else {
            return nil;
        }
    }
    else if (tk.type == TokenVoid) {
        
    }
    else {
        return nil;
    }
}

- (CMToken *)nextToken {
    self.tkpos += 1;
    return self.tokens[self.tkpos];
}

@end
