//
//  SymbolTable.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/14/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "SymbolTable.h"
#import "Symbol.h"

@interface SymbolTable()

@property (strong, nonatomic) NSMutableDictionary *table;
@property int level;

@end

@implementation SymbolTable

- (id)init {
    self = [super init];
    if (self) {
        self.table = [NSMutableDictionary new];
        self.level = 0;
    }
    return self;
}

- (void)insertSymbolName:(NSString *)name withInfo:(NSDictionary *)info{
    Symbol *sym = [Symbol new];
    sym.name = name;
    sym.info = info;
    sym.level = self.level;
    
    NSMutableArray *list = [self.table objectForKey:name];
    if (!list) {
        list = [NSMutableArray new];
    }
    [list addObject:sym];
    [self.table setObject:list forKey:name];
}

- (id)lookupSymbolName:(NSString *)name {
    if ([[self.table objectForKey:name] count] > 0) {
        return [[self.table objectForKey:name] objectAtIndex:0];
    }
    else {
        return nil;
    }
}

- (void)deleteSymbolName:(NSString *)name {
    NSMutableArray *list = [self.table objectForKey:name];
    for (int i=0; i<[list count]; i++) {
        Symbol *sym = [list objectAtIndex:i];
        if (sym.level == self.level) {
            [list removeObjectAtIndex:i];
            return;
        }
    }
}

- (void)pushLevel {
    self.level += 1;
}

- (void)popLevel {
    for (NSString *key in self.table) {
        [self deleteSymbolName:key];
    }
    self.level -= 1;
}

@end
