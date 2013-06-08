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

@property (strong, nonatomic) TinyMachine *tm;

@end

@implementation CMXDocument

- (id)init
{
    self = [super init];
    if (self) {
        self.tm = [TinyMachine new];
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
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

#pragma mark - Actions

- (IBAction)themeChanged:(id)sender {
    [self.editor setTheme:[self.theme indexOfSelectedItem]];
}

- (IBAction)run:(id)sender {
    self.tm.input = [[self.input stringValue] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]];
    [self.tm fillInstMemWithString:self.editor.string];
    [self.tm run];
    [self.output setStringValue:[self.tm.output componentsJoinedByString:@", "]];
}

#pragma mark - ACEViewDelegate

- (void) textDidChange:(NSNotification *)notification {
    // nothing
}

@end
