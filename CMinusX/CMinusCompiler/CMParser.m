//
//  CMParser.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMParser.h"
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
            return nil;
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
                if ([self nextToken].type != TokenStmtEnd) {
                    self.tkpos = oripos;
                    return nil;
                }
            }
            else if (typtk.type == TokenArgsLeft) {
                // function return int
                [self.symtab pushLevel];
                NSMutableArray *args = [NSMutableArray new];
                STArgumentNode *arg = [self matchDeclArg];
                if (![[arg.info objectForKey:@"type"] isEqual: @"void"]) {
                    [args addObject:arg];
                    while (((CMToken *)[self.tokens objectAtIndex:self.tkpos]).type == TokenComma) {
                        arg = [self matchDeclArg];
                        [args addObject:arg];
                    }
                }
                if ([self nextToken].type != TokenFuncLeft) {
                    self.tkpos = oripos;
                    return nil;
                }
                NSMutableArray *stmts = [NSMutableArray new];
                STStatementNode *stmt = [self matchStmt];
                [stmts addObject:stmt];
                while ([self nextToken].type != TokenFuncRight) {
                    self.tkpos -= 1;
                    stmt = [self matchStmt];
                    [stmts addObject:stmt];
                }
                [self.symtab popLevel];
                decl.type = STDeclFunc;
                [decl.info setObject:@"int" forKey:@"return"];
                [decl.info setObject:[args copy] forKey:@"args"];
                [decl.info setObject:[stmts copy] forKey:@"stmts"];
            }
        }
        else {
            self.tkpos = oripos;
            return nil;
        }
    }
    else if (tk.type == TokenVoid) {
        // function return void
        CMToken *idtk = [self nextToken];
        if (idtk.type == TokenID) {
            CMToken *typtk = [self nextToken];
            if (typtk.type == TokenArgsLeft) {
                [self.symtab pushLevel];
                NSMutableArray *args = [NSMutableArray new];
                STArgumentNode *arg = [self matchDeclArg];
                if (![[arg.info objectForKey:@"type"] isEqual: @"void"]) {
                    [args addObject:arg];
                    while (((CMToken *)[self.tokens objectAtIndex:self.tkpos]).type == TokenComma) {
                        arg = [self matchDeclArg];
                        [args addObject:arg];
                    }
                }
                if ([self nextToken].type != TokenFuncLeft) {
                    self.tkpos = oripos;
                    return nil;
                }
                NSMutableArray *stmts = [NSMutableArray new];
                STStatementNode *stmt = [self matchStmt];
                [stmts addObject:stmt];
                while ([self nextToken].type != TokenFuncRight) {
                    self.tkpos -= 1;
                    stmt = [self matchStmt];
                    [stmts addObject:stmt];
                }
                [self.symtab popLevel];
                decl.type = STDeclFunc;
                [decl.info setObject:@"void" forKey:@"return"];
                [decl.info setObject:[args copy] forKey:@"args"];
                [decl.info setObject:[stmts copy] forKey:@"stmts"];
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
    }
    else {
        self.tkpos = oripos;
        return nil;
    }
    self.tkpos += 1;
    return decl;
}

- (STArgumentNode *)matchDeclArg {
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
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"int"}];
            }
            else if (typtk.type == TokenArrayLeft) {
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
                [arg.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
                [arg.info setObject:@"array" forKey:@"type"];
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"array"}];
                CMToken *argEnd = [self nextToken];
                if ((argEnd.type != TokenComma) && (argEnd.type != TokenArgsRight)) {
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
    else if (tk.type == TokenVoid) {
        [arg.info setObject:@"void" forKey:@"type"];
        if ([self nextToken].type != TokenArgsRight) {
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

- (STStatementNode *)matchStmt {
    STStatementNode *stmt = [STStatementNode new];
    stmt.info = [NSMutableDictionary new];
    int oripos = self.tkpos;
    CMToken *tk = [self nextToken];
    if (tk.type == TokenInt) {
        // local variable declaration
        CMToken *idtk = [self nextToken];
        if (idtk.type == TokenID) {
            CMToken *typtk = [self nextToken];
            if (typtk.type == TokenStmtEnd) {
                // int variable
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"int"}];
                stmt.type = STStmtLocalDecl;
                [stmt.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
                [stmt.info setObject:@"int" forKey:@"type"];
            }
            else if (typtk.type == TokenArrayLeft) {
                // array variable
                CMToken *sizetk = [self nextToken];
                if (sizetk.type != TokenNUM) {
                    self.tkpos = oripos;
                    return nil;
                }
                [self.symtab insertSymbolName:[idtk.info objectForKey:@"id"] withInfo:@{@"type": @"array", @"size": [sizetk.info objectForKey:@"value"]}];
                stmt.type = STStmtLocalDecl;
                [stmt.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
                [stmt.info setObject:@"array" forKey:@"type"];
                [stmt.info setObject:[sizetk.info objectForKey:@"value"] forKey:@"size"];
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
                if ([self nextToken].type != TokenStmtEnd) {
                    self.tkpos = oripos;
                    return nil;
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
    }
    else if (tk.type == TokenID) {
        // assignment or call
        CMToken *typtk = [self nextToken];
        if (typtk.type == TokenAssign) {
            // assignment
            stmt.type = STStmtAssign;
            [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
            [stmt.info setObject:@"var" forKey:@"type"];
            [stmt.info setObject:[self matchExp] forKey:@"exp"];
            if ([self nextToken].type != TokenStmtEnd) {
                self.tkpos = oripos;
                return nil;
            }
        }
        else if (typtk.type == TokenArrayLeft) {
            // array element assignment
            CMToken *subtk = [self nextToken];
            if (subtk.type == TokenNUM) {
                // array ref const
                stmt.type = STStmtVar;
                [stmt.info setObject:@"elementConst" forKey:@"type"];
                [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
                [stmt.info setObject:[subtk.info objectForKey:@"value"] forKey:@"sub"];
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
            }
            else if (subtk.type == TokenID) {
                // array ref id
                stmt.type = STStmtVar;
                [stmt.info setObject:@"elementVar" forKey:@"type"];
                [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
                [stmt.info setObject:[subtk.info objectForKey:@"id"] forKey:@"subvar"];
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
            }
            else {
                self.tkpos = oripos;
                return nil;
            }
            if ([self nextToken].type != TokenAssign) {
                self.tkpos = oripos;
                return nil;
            }
            stmt.type = STStmtAssign;
            [stmt.info setObject:[self matchExp] forKey:@"exp"];
            if ([self nextToken].type != TokenStmtEnd) {
                self.tkpos = oripos;
                return nil;
            }
        }
        else if (typtk.type == TokenArgsLeft) {
            // function call
            NSArray *args = [self matchCallArgs];
            if (args == nil)
            {
                self.tkpos = oripos;
                return nil;
            }
            stmt.type = STStmtCall;
            [stmt.info setObject:args forKey:@"args"];
            [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
            if ([self nextToken].type != TokenStmtEnd) {
                self.tkpos = oripos;
                return nil;
            }
        }
    }
    else if (tk.type == TokenIf) {
        // if statement
        stmt.type = STStmtIf;
        if ([self nextToken].type != TokenArgsLeft) {
            self.tkpos = oripos;
            return nil;
        }
        [stmt.info setObject:[self matchExp] forKey:@"left"];
        [stmt.info setObject:[self nextToken] forKey:@"op"];
        [stmt.info setObject:[self matchExp] forKey:@"right"];
        if ([self nextToken].type != TokenArgsRight) {
            self.tkpos = oripos;
            return nil;
        }
        BOOL has_else_branch = NO;
        CMToken *bracetk = [self nextToken];
        if (bracetk.type == TokenFuncLeft) {
            // multiple exp
            [self.symtab pushLevel];
            NSMutableArray *stmts = [NSMutableArray new];
            STStatementNode *sub_stmt = [self matchStmt];
            [stmts addObject:sub_stmt];
            while ([self nextToken].type != TokenFuncRight) {
                self.tkpos -= 1;
                sub_stmt = [self matchStmt];
                [stmts addObject:sub_stmt];
            }
            [stmt.info setObject:[stmts copy] forKey:@"stmts"];
            [self.symtab pushLevel];
        }
        else {
            // single exp
            self.tkpos -= 1;
            [stmt.info setObject:[self matchExp] forKey:@"stmts"];
        }
        if ([self nextToken].type == TokenElse) {
            has_else_branch = YES;
        }
        else {
            self.tkpos -= 1;
        }
        if (has_else_branch) {
            CMToken *else_bracetk = [self nextToken];
            if (else_bracetk.type == TokenFuncLeft) {
                // multiple exp
                [self.symtab pushLevel];
                NSMutableArray *else_stmts = [NSMutableArray new];
                STStatementNode *else_sub_stmt = [self matchStmt];
                [else_stmts addObject:else_sub_stmt];
                while ([self nextToken].type != TokenFuncRight) {
                    self.tkpos -= 1;
                    else_sub_stmt = [self matchStmt];
                    [else_stmts addObject:else_sub_stmt];
                }
                [stmt.info setObject:[else_stmts copy] forKey:@"else_stmts"];
                [self.symtab pushLevel];
            }
            else {
                // single exp
                self.tkpos -= 1;
                [stmt.info setObject:[self matchExp] forKey:@"else_stmts"];
            }
        }
    }
    else if (tk.type == TokenWhile) {
        // while statement
        stmt.type = STStmtWhile;
        if ([self nextToken].type != TokenArgsLeft) {
            self.tkpos = oripos;
            return nil;
        }
        [stmt.info setObject:[self matchExp] forKey:@"left"];
        [stmt.info setObject:[self nextToken] forKey:@"op"];
        [stmt.info setObject:[self matchExp] forKey:@"right"];
        if ([self nextToken].type != TokenArgsRight) {
            self.tkpos = oripos;
            return nil;
        }
        CMToken *bracetk = [self nextToken];
        if (bracetk.type == TokenFuncLeft) {
            // multiple exp
            [self.symtab pushLevel];
            NSMutableArray *stmts = [NSMutableArray new];
            STStatementNode *sub_stmt = [self matchStmt];
            [stmts addObject:sub_stmt];
            while ([self nextToken].type != TokenFuncRight) {
                self.tkpos -= 1;
                sub_stmt = [self matchStmt];
                [stmts addObject:sub_stmt];
            }
            [stmt.info setObject:[stmts copy] forKey:@"stmts"];
            [self.symtab pushLevel];
        }
        else {
            // single exp
            self.tkpos -= 1;
            [stmt.info setObject:[self matchExp] forKey:@"stmts"];
        }
    }
    else if (tk.type == TokenReturn) {
        // return statement
        stmt.type = STStmtReturn;
        CMToken *typtk = [self nextToken];
        if (typtk.type == TokenStmtEnd) {
            // return nothing
        }
        else {
            // return exp
            self.tkpos -= 1;
            [stmt.info setObject:[self matchExp] forKey:@"exp"];
            if ([self nextToken].type != TokenStmtEnd) {
                self.tkpos = oripos;
                return nil;
            }
        }
    }
    else {
        self.tkpos = oripos;
        return nil;
    }
    return stmt;
}

/*
 
 Exp -> Term { addop Term }
 Term -> Factor { mulop Factor }
 Factor -> ( Exp ) | ID | ID[sub] | ID(args) | NUM
 
 args -> Exp { , Exp }
 
*/

- (STStatementNode *)matchExp {
    STStatementNode *stmt = [STStatementNode new];
    stmt.info = [NSMutableDictionary new];
    STStatementNode *left = [self matchTerm];
    if (left == nil) {
        return nil;
    }
    int oripos = self.tkpos;
    CMToken *optk = [self nextToken];
    if ((optk.type == TokenOpCalcAdd) || (optk.type == TokenOpCalcSub)) {
        STStatementNode *right = [self matchFactor];
        if (right == nil) {
            self.tkpos = oripos;
            return nil;
        }
        stmt.type = STStmtOpCalc;
        [stmt.info setObject:left forKey:@"left"];
        [stmt.info setObject:optk forKey:@"op"];
        [stmt.info setObject:right forKey:@"right"];
    }
    else {
        stmt = left;
        self.tkpos = oripos;
    }
    return stmt;
}

- (STStatementNode *)matchTerm {
    STStatementNode *stmt = [STStatementNode new];
    stmt.info = [NSMutableDictionary new];
    STStatementNode *left = [self matchFactor];
    if (left == nil) {
        return nil;
    }
    int oripos = self.tkpos;
    CMToken *optk = [self nextToken];
    if ((optk.type == TokenOpCalcMul) || (optk.type == TokenOpCalcDiv)) {
        STStatementNode *right = [self matchFactor];
        if (right == nil) {
            self.tkpos = oripos;
            return nil;
        }
        stmt.type = STStmtOpCalc;
        [stmt.info setObject:left forKey:@"left"];
        [stmt.info setObject:optk forKey:@"op"];
        [stmt.info setObject:right forKey:@"right"];
    }
    else {
        stmt = left;
        self.tkpos = oripos;
    }
    return stmt;
}

- (STStatementNode *)matchFactor {
    STStatementNode *stmt = [STStatementNode new];
    stmt.info = [NSMutableDictionary new];
    int oripos = self.tkpos;
    CMToken *tk = [self nextToken];
    if (tk.type == TokenArgsLeft) {
        // ( Exp )
        stmt = [self matchExp];
        if ([self nextToken].type != TokenArgsRight) {
            self.tkpos = oripos;
            return nil;
        }
    }
    else if (tk.type == TokenID) {
        CMToken *typtk = [self nextToken];
        if (typtk.type == TokenArrayLeft) {
            // array reference
            CMToken *subtk = [self nextToken];
            if (subtk.type == TokenNUM) {
                // array ref const
                stmt.type = STStmtVar;
                [stmt.info setObject:@"elementConst" forKey:@"type"];
                [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
                [stmt.info setObject:[subtk.info objectForKey:@"value"] forKey:@"sub"];
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
            }
            else if (subtk.type == TokenID) {
                // array ref id
                stmt.type = STStmtVar;
                [stmt.info setObject:@"elementVar" forKey:@"type"];
                [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
                [stmt.info setObject:[subtk.info objectForKey:@"id"] forKey:@"subvar"];
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
            }
            else {
                self.tkpos = oripos;
                return nil;
            }
        }
        else if (typtk.type == TokenArgsLeft) {
            // function call
            NSArray *args = [self matchCallArgs];
            if (args == nil)
            {
                self.tkpos = oripos;
                return nil;
            }
            stmt.type = STStmtCall;
            [stmt.info setObject:args forKey:@"args"];
            [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
        }
        else {
            stmt.type = STStmtVar;
            [stmt.info setObject:@"int" forKey:@"type"];
            [stmt.info setObject:[tk.info objectForKey:@"id"] forKey:@"id"];
            self.tkpos -= 1;
        }
        
    }
    else if (tk.type == TokenNUM) {
        stmt.type = STStmtConst;
        [stmt.info setObject:[tk.info objectForKey:@"value"] forKey:@"value"];
    }
    else if (tk.type == TokenReturn) {
        // return statement
        stmt.type = STStmtReturn;
        CMToken *typtk = [self nextToken];
        if (typtk.type == TokenStmtEnd) {
            // return nothing
        }
        else {
            // return exp
            self.tkpos -= 1;
            [stmt.info setObject:[self matchExp] forKey:@"exp"];
            if ([self nextToken].type != TokenStmtEnd) {
                self.tkpos = oripos;
                return nil;
            }
        }
    }
    else {
        self.tkpos = oripos;
        return nil;
    }
    
    return stmt;
}

/*
- (NSArray *)matchCallArgs {
    NSMutableArray *args = [NSMutableArray new];
    int oripos = self.tkpos;
    CMToken *idtk = [self nextToken];
    if (idtk.type == TokenArgsRight) {
        return args;
    }
    while ((idtk.type == TokenID) || (idtk.type == TokenNUM)) {
        STArgumentNode *arg = [STArgumentNode new];
        arg.info = [NSMutableDictionary new];
        if (idtk.type == TokenID) {
            // variable arg
            [arg.info setObject:[idtk.info objectForKey:@"id"] forKey:@"id"];
            idtk = [self nextToken];
            if (idtk.type == TokenArrayLeft) {
                // array element
                CMToken *subtk = [self nextToken];
                if (subtk.type == TokenNUM) {
                    // array ref const
                    [arg.info setObject:@"elementConst" forKey:@"type"];
                    [arg.info setObject:[subtk.info objectForKey:@"value"] forKey:@"sub"];
                }
                else if (subtk.type == TokenID) {
                    // array ref id
                    [arg.info setObject:@"elementVar" forKey:@"type"];
                    [arg.info setObject:[subtk.info objectForKey:@"id"] forKey:@"subvar"];
                    
                }
                else {
                    self.tkpos = oripos;
                    return nil;
                }
                if ([self nextToken].type != TokenArrayRight) {
                    self.tkpos = oripos;
                    return nil;
                }
                idtk = [self nextToken];
                idtk = [self nextToken];
            }
            else if (idtk.type == TokenArgsLeft) {
                // function call
                [arg.info setObject:@"func" forKey:@"type"];
                [arg.info setObject:[self matchExp] forKey:@"exp"];
                idtk = [self nextToken];
                idtk = [self nextToken];
            }
            else if ((idtk.type == TokenComma) || (idtk.type == TokenArgsRight)) {
                // int variable
                [arg.info setObject:@"int" forKey:@"type"];
                idtk = [self nextToken];
            }
            else {
                self.tkpos = oripos;
                return nil;
            }
        }
        else {
            // const arg
            [arg.info setObject:@"const" forKey:@"type"];
            [arg.info setObject:[idtk.info objectForKey:@"value"] forKey:@"value"];
            idtk = [self nextToken];
            idtk = [self nextToken];
        }
        [args addObject:arg];
    }
    self.tkpos -= 1;
    return [args copy];
}
 */

- (NSArray *)matchCallArgs {
    NSMutableArray *args = [NSMutableArray new];
    CMToken *idtk = [self nextToken];
    if (idtk.type == TokenArgsRight) {
        return args;
    }
    while ((idtk.type == TokenID) || (idtk.type == TokenNUM)) {
        self.tkpos -= 1;
        [args addObject:[self matchExp]];
        idtk = [self nextToken];
        idtk = [self nextToken];
    }
    self.tkpos -= 1;
    return [args copy];
}

- (CMToken *)nextToken {
    self.tkpos += 1;
    return self.tokens[self.tkpos];
}

@end
