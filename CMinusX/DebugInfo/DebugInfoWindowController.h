//
//  DebugInfoWindowController.h
//  CMinusX
//
//  Created by AquarHEAD L. on 6/9/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DebugInfoWindowController : NSWindowController

@property (weak) IBOutlet NSTextField *reg0;
@property (weak) IBOutlet NSTextField *reg1;
@property (weak) IBOutlet NSTextField *reg2;
@property (weak) IBOutlet NSTextField *reg3;

@property (weak) IBOutlet NSTextField *reg4;
@property (weak) IBOutlet NSTextField *reg5;
@property (weak) IBOutlet NSTextField *reg6;
@property (weak) IBOutlet NSTextField *reg7;

@property (weak) IBOutlet NSTextField *dataMemQuery;
@property (weak) IBOutlet NSTextField *dataMemResult;

@property (strong, nonatomic) NSArray *dataMem;

@end
