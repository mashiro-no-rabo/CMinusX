//
//  SymbolTableTest.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/14/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "SymbolTableTest.h"
#import "SymbolTable.h"

SymbolTable *tab;

@implementation SymbolTableTest

- (void)setUp
{
    [super setUp];
    tab = [SymbolTable new];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testEmptyLookup {
    STAssertNil([tab lookupSymbolName:@"test"], @"Empty lookup fail");
}

- (void)testInsert {
    [tab insertSymbolName:@"test" withInfo:@{@"type": @"int"}];
    STAssertEqualObjects(@{@"type": @"int"}, [tab lookupSymbolName:@"test"], @"Insert Fail");
}

@end
