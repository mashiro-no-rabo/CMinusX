//
//  CMParser.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMParser.h"
#import "CMXSyntaxTree.h"
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
    STProgramNode *prog = [STProgramNode new];
    prog.decls = [NSMutableArray new];
    while (self.tkpos < [self.tokens count]) {
        STDeclarationNode *node = [self matchDecl];
        if (node == nil) {
            prog = nil;
        }
        [prog.decls addObject:node];
    }
    return prog;
}


- (STDeclarationNode *)matchDecl {
    STDeclarationNode *decl = [STDeclarationNode new];
    decl.info = [NSMutableDictionary new];
    int oripos = self.tkpos;
    CMToken *tk = self.tokens[self.tkpos];
    if (tk.type == TokenInt) {
        CMToken *idtk = [self nextToken];
        if (idtk.type == TokenID) {
            CMToken *typtk = [self nextToken];
            if (typtk.type == TokenStmtEnd) {
                // int variable
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"int"}];
                decl.type = STDeclVar;
                decl.info = [@{@"id": [idtk.info objectForKey:@"id"], @"type": @"int"} mutableCopy];
            }
            else if (typtk.type == TokenArrayLeft) {
                // array variable
                CMToken *sizetk = [self nextToken];
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"array", @"size": [sizetk.info objectForKey:@"value"]}];
                decl.type = STDeclVar;
                decl.info = [@{@"id": [idtk.info objectForKey:@"id"], @"type": @"int", @"size": [sizetk.info objectForKey:@"value"]} mutableCopy];
            }
            else if (typtk.type == TokenArgsLeft) {
                // function return int
                
                [self.symtab pushLevel];
                NSMutableArray *args = [NSMutableArray new];
                STArgumentNode *arg = [self matchArg];
                [args addObject:arg];
                while ([self nextToken].type == TokenComma) {
                    arg = [self matchArg];
                    [args addObject:arg];
                }
                [self.symtab popLevel];
                decl.type = STDeclFunc;
            }
        }
        else {
            return nil;
        }
    }
    else if (tk.type == TokenVoid) {
        CMToken *idtk = [self nextToken];
    }
    else {
        self.tkpos = oripos;
        return nil;
    }
}

- (STArgumentNode *)matchArg {
    
}

- (CMToken *)nextToken {
    self.tkpos += 1;
    return self.tokens[self.tkpos];
}

@end
