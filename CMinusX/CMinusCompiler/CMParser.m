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
                [decl.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
                [decl.info setObject:@"int" forKey:@"type"];
            }
            else if (typtk.type == TokenArrayLeft) {
                // array variable
                CMToken *sizetk = [self nextToken];
                if (sizetk.type != TokenNUM) {
                    self.tkpos = oripos;
                    return nil;
                }
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"array", @"size": [sizetk.info objectForKey:@"value"]}];
                decl.type = STDeclVar;
                [decl.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
                [decl.info setObject:@"array" forKey:@"type"];
                [decl.info setObject:[sizetk.info objectForKey:@"value"] forKey:@"size"];
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
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
            self.tkpos = oripos;
            return nil;
        }
    }
    else if (tk.type == TokenVoid) {
        CMToken *idtk = [self nextToken];
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
    else {
        self.tkpos = oripos;
        return nil;
    }
    self.tkpos += 1;
    return decl;
}

- (STArgumentNode *)matchArg {
    STArgumentNode *arg = [STArgumentNode new];
    arg.info = [NSMutableDictionary new];
    int oripos = self.tkpos;
    CMToken *tk = [self nextToken];
    if (tk.type == TokenInt) {
        CMToken *idtk = [self nextToken];
        if (idtk.type == TokenID) {
            CMToken *typtk = [self nextToken];
            if ((typtk.type == TokenComma) || (typtk.type == TokenArgsRight)) {
                [arg.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
                [arg.info setObject:@"int" forKey:@"type"];
            }
            else if (typtk.type == TokenArrayLeft) {
                CMToken *sizetk = [self nextToken];
                if (sizetk.type != TokenNUM) {
                    self.tkpos = oripos;
                    return nil;
                }
                [arg.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
                [arg.info setObject:@"array" forKey:@"type"];
                [arg.info setObject:[sizetk.info objectForKey:@"value"] forKey:@"size"];
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
            }
        }
        else {
            self.tkpos = oripos;
            return nil;
        }
    }
    else {
        self.tkpos = oripos;
        return nil;
    }
    return arg;
}

- (CMToken *)nextToken {
    self.tkpos += 1;
    return self.tokens[self.tkpos];
}

@end
