//
//  CMXDocument.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/8/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMXDocument.h"
#import "ACEView/ACEView.h"
#import "ACEView/ACEModeNames.h"
#import "ACEView/ACEThemeNames.h"

#import "TinyMachine.h"

@interface CMXDocument() <ACEViewDelegate>

@property (weak) IBOutlet ACEView *editor;
@property (weak) IBOutlet NSPopUpButton *theme;
@property (weak) IBOutlet NSPopUpButton *mode;
@property (weak) IBOutlet NSTextField *input;
@property (weak) IBOutlet NSTextField *output;
@property (weak) IBOutlet NSButton *runButton;
@property (weak) IBOutlet NSButton *debugButton;
@property (weak) IBOutlet NSTextField *status;

@property (strong, nonatomic) TinyMachine *tm;
@property int nextLine;
@property BOOL debugging;

@property (strong, nonatomic) NSMutableDictionary *savedData;

@end

@implementation CMXDocument

- (id)init
{
    self = [super init];
    if (self) {
        self.tm = [TinyMachine new];
        self.savedData = [NSMutableDictionary new];
        self.debugging = NO;
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"CMXDocument";
}

- (void)awakeFromNib {
    [self.theme addItemsWithTitles:[ACEThemeNames humanThemeNames]];
    [self.theme selectItemAtIndex:ACEThemeTomorrowNightEighties];
    
    [self.mode addItemWithTitle:@"TM Inst"];
    [self.mode selectItemAtIndex:0];
    [self.editor setDelegate:self];
    [self.editor setMode:ACEModeCPP];
    [self.editor setTheme:ACEThemeTomorrowNightEighties];
    [self.editor setShowPrintMargin:NO];
    [self.editor setShowInvisibles:YES];
    
    if ([self.savedData objectForKey:@"editorContent"]) {
        [self.editor setString:[self.savedData objectForKey:@"editorContent"]];
    }
    
    if ([self.savedData objectForKey:@"inputContent"]) {
        [self.input setStringValue:[self.savedData objectForKey:@"inputContent"]];
    }
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    NSMutableData *data = [NSMutableData new];
    NSKeyedArchiver *ka = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [ka encodeObject:self.editor.string forKey:@"editorContent"];
    [ka encodeObject:self.input.stringValue forKey:@"inputContent"];
    [ka finishEncoding];
    return data;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    NSKeyedUnarchiver *unka = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [self.savedData setObject:[unka decodeObjectForKey:@"editorContent"] forKey:@"editorContent"];
    [self.savedData setObject:[unka decodeObjectForKey:@"inputContent"] forKey:@"inputContent"];
    [unka finishDecoding];
    return YES;
}

#pragma mark - Actions

- (IBAction)themeChanged:(id)sender {
    [self.editor setTheme:[self.theme indexOfSelectedItem]];
}

- (IBAction)run:(id)sender {
    self.tm.input = [[self.input stringValue] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]];
    if (!self.debugging) {
        [self.tm fillInstMemWithString:self.editor.string];
        TMStepResult *result = [self.tm run];
        if (result.type == srHALT) {
            [self.output setStringValue:[self.tm.output componentsJoinedByString:@", "]];
        }
        else {
            [self.output setStringValue:@"Error"];
        }
        [self.status setStringValue:[NSString stringWithFormat:@"Status: %@", result]];
    }
    else {
        if (self.nextLine > 0 && self.nextLine <= [self.tm lineCount]) {
            TMStepResult *result;
            while (self.nextLine > 0 && [self.tm thisInst].lineNo == self.nextLine) {
                result = [self.tm step];
                self.status.stringValue = [NSString stringWithFormat:@"[%d] Debugging: %@", self.nextLine, result];
                if (result.type == srHALT) {
                    break;
                }
            }
            if (result.type != srHALT) {
                self.nextLine = [self.tm thisInst].lineNo;
                [self.output setStringValue:[self.tm.output componentsJoinedByString:@", "]];
            }
            else {
                self.nextLine = 0;
                [self.status setStringValue:@"Debug done."];
            }
        }
        else {
            [self.tm clean];
            self.nextLine = 1;
            self.output.stringValue = @"";
            self.status.stringValue = @"[0] Debugging:";
        }
    }
}

- (IBAction)toggleDebug:(id)sender {
    if (!self.debugging) {
        self.debugging = YES;
        self.nextLine = 1;
        [self.tm fillInstMemWithString:self.editor.string];
        [self.runButton setTitle:@"Step"];
        [self.debugButton setTitle:@"Quit"];
        self.output.stringValue = @"";
        self.status.stringValue = @"[0] Debugging:";
    }
    else {
        self.debugging = NO;
        [self.runButton setTitle:@"Run"];
        [self.debugButton setTitle:@"Debug"];
        [self.status setStringValue:@"Status:"];
    }
}

#pragma mark - ACEViewDelegate

- (void) textDidChange:(NSNotification *)notification {
    // nothing
}

@end
