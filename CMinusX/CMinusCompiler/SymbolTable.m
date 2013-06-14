//
//  SymbolTable.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/14/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "SymbolTable.h"

@interface SymbolTable()

@property (strong, nonatomic) NSMutableDictionary *table;

@end

@implementation SymbolTable

- (id)init {
    self = [super init];
    if (self) {
        self.table = [NSMutableDictionary new];
    }
    return self;
}

- (void)insertSymbolName:(NSString *)name withInfo:(id)info {
    NSMutableArray *list = [self.table objectForKey:name];
    if (!list) {
        list = [NSMutableArray new];
        [list addObject:info];
    }
    else {
        [list insertObject:info atIndex:0];
    }
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
    [list removeObjectAtIndex:0];
}

@end
