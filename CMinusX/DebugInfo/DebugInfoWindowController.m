//
//  DebugInfoWindowController.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/9/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "DebugInfoWindowController.h"

@interface DebugInfoWindowController () <NSTextFieldDelegate>

@end

@implementation DebugInfoWindowController

- (id)init {
    self = [super initWithWindowNibName:@"DebugInfo"];
    
    if (self) {
        [self.dataMemQuery setDelegate:self];
    }
    
    return self;
}

- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor {
    self.dataMemResult.stringValue = [NSString stringWithFormat:@"%@", [self.dataMem objectAtIndex:[self.dataMemQuery.stringValue intValue]]];
    return YES;
}

@end
