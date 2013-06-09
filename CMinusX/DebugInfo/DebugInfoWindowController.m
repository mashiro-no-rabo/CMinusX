//
//  DebugInfoWindowController.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/9/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "DebugInfoWindowController.h"

@interface DebugInfoWindowController ()

@end

@implementation DebugInfoWindowController

- (id)init {
    self = [super initWithWindowNibName:@"DebugInfo"];
    
    return self;
}

- (IBAction)showDataMem:(id)sender {
    self.dataMemResult.stringValue = [NSString stringWithFormat:@"%lld", [[self.dataMem objectForKey:[NSNumber numberWithLongLong:[self.dataMemQuery.stringValue longLongValue]]] longLongValue]];
}

@end
