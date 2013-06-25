//
//  CMScannerTest.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMScannerTest.h"
#import "CMScanner.h"

@implementation CMScannerTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testScanner {
    NSString *input = [NSString stringWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"gcd" ofType:@"cm"] encoding:NSASCIIStringEncoding error:nil];
    NSArray *result = [CMScanner scan:input];
    NSString *input2 = [NSString stringWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"sort" ofType:@"cm"] encoding:NSASCIIStringEncoding error:nil];
    NSArray *result2 = [CMScanner scan:input];
    CMToken *firstToken = [CMToken tokenWithType:TokenInt lineno:1 andInfo:nil];
    STAssertEqualObjects([result objectAtIndex:0], firstToken, @"no match first token");
}

@end
