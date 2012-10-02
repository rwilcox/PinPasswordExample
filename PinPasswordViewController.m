//
//  PinPasswordViewController.m
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 6/27/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import "PinPasswordViewController.h"
#import "FilteringTextField.h"
#import "DKButtonCell.h"

@interface PinPasswordViewController ()

@end

@implementation PinPasswordViewController
@synthesize fieldOne;
@synthesize fieldTwo;
@synthesize fieldThree;
@synthesize fieldFour;
@synthesize passwordHideBtn;
@synthesize delegate;
@synthesize hidePasswordHideBtn;
@synthesize labelText;

@synthesize previousPasswordControl;
@synthesize nextPasswordControl;

NSString* getStringAtCharacterPosition(NSString* originalString, int index);

NSString* getStringAtCharacterPosition(NSString* originalString, int index) {
    NSRange range;
    range.location = index;
    range.length = 1;
    
    return [originalString substringWithRange: range];
}

+(PinPasswordViewController*) pinPasswordViewController {
    PinPasswordViewController* output = [[PinPasswordViewController alloc] 
                                         initWithNibName: @"PinPasswordViewController" bundle: nil];
    
    return output;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isInSecureMode = YES;
        self.hidePasswordHideBtn = NO;
        self.labelText = @"4 Digit Code";
    }
    
    return self;
}

- (void) awakeFromNib {
    [fieldOne setMaximumLength: 1];
    [fieldOne setAcceptableCharacterSet: [NSCharacterSet decimalDigitCharacterSet]];
    fieldOne.lengthDelegate =  self; // using the normal delegate I guess sets up a Weak reference, which isn't allowed here? WD-rpw 06-27-2012
    
    [fieldTwo setMaximumLength: 1];
    [fieldTwo setAcceptableCharacterSet: [NSCharacterSet decimalDigitCharacterSet]];
    fieldTwo.lengthDelegate = self;
    
    [fieldThree setMaximumLength: 1];
    [fieldThree setAcceptableCharacterSet: [NSCharacterSet decimalDigitCharacterSet]];
    fieldThree.lengthDelegate = self;
    
    [fieldFour setMaximumLength: 1];
    [fieldFour setAcceptableCharacterSet: [NSCharacterSet decimalDigitCharacterSet]];
    fieldFour.lengthDelegate = self;
    
    [passwordHideBtn setHoverImage: [NSImage imageNamed:@"eyetoggle-btn-hover.png"]];
    
    // Create the previous and next password control dictionaries
    // Yes, I know about nextKeyView and previousKeyView but they seem to not work
    // in all use cases for some reason
    
    self.previousPasswordControl = [[NSDictionary alloc] initWithObjectsAndKeys:
            fieldOne, [NSValue valueWithNonretainedObject: fieldTwo],
            fieldTwo, [NSValue valueWithNonretainedObject: fieldThree],
            fieldThree, [NSValue valueWithNonretainedObject: fieldFour],
            nil];
    
    self.nextPasswordControl= [[NSDictionary alloc] initWithObjectsAndKeys:
            fieldTwo, [NSValue valueWithNonretainedObject:fieldOne],
            fieldThree, [NSValue valueWithNonretainedObject:fieldTwo],
            fieldFour, [NSValue valueWithNonretainedObject:fieldThree],
            nil];

    //[self.view.window makeFirstResponder: fieldOne];

}

- (void) didHitMaxCharactersOf: (FilteringTextField*) currentField {
    //NSLog(@"did hit the max characters");
    //NSLog(@"nextKeyView = %@", [currentField nextKeyView] );
    //NSLog(@"next password field for %@", [self _nextFieldFor: currentField]);
    [[self _nextFieldFor: currentField] becomeFirstResponder]; // see comment above where we construct previousPasswordControl and nextPasswordControl. WD-rpw 09-26-2012
    
    if ([self _nextFieldFor: currentField] == nil) {
        [self.delegate pinPasswordDidChange: self];
    }
}

- (IBAction)toggleNumbersShowing:(id)sender {

    NSArray* fieldArrays = [NSArray arrayWithObjects: fieldOne, fieldTwo, fieldThree, fieldFour, nil];
    
    [fieldArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self _toggleFieldLookFor: obj];
    }];
    
    [fieldOne   display];
    [fieldTwo   display];
    [fieldThree display];
    [fieldFour  display];
  
    [fieldOne becomeFirstResponder];
//    [fieldOne setFirstResp
    
    if ( isInSecureMode ) {
        [self setPinVisbleButtons];
        //[self performSelector: @selector(setPinVisbleButtons) withObject:nil afterDelay:0.0];
    } else {
        [self setPinBullettedButtons];
    }
    
    isInSecureMode = !isInSecureMode;
}


- (void) disablePinInput {
    fieldOne.hidden = YES;
    fieldTwo.hidden = YES;
    fieldThree.hidden = YES;
    fieldFour.hidden = YES;
}

- (void) enablePinInput {
    fieldOne.hidden = NO;
    fieldTwo.hidden = NO;
    fieldThree.hidden = NO;
    fieldFour.hidden = NO;
}

- (void) setPinVisbleButtons {
    [passwordHideBtn setImage: [NSImage imageNamed:@"eye-btn.png"] ];			// graphics not included
    [passwordHideBtn setHoverImage: [NSImage imageNamed: @"eye-btn-hover.png"]];
    [passwordHideBtn setAlternateImage: [NSImage imageNamed: @"eye-press.png"]];
    
    [passwordHideBtn invalidateCache];
    //[passwordHideBtn needsDisplay];
}

- (void) setPinBullettedButtons {
    [passwordHideBtn setImage: [NSImage imageNamed:@"eyetoggle-btn.png"] ];
    [passwordHideBtn setHoverImage: [NSImage imageNamed: @"eyetoggle-btn-hover.png"]];
    [passwordHideBtn setAlternateImage: [NSImage imageNamed: @"eyetoggle-btn-press.png"]];
    
    [passwordHideBtn invalidateCache];
    //[passwordHideBtn needsDisplay];
}
- (NSString*) value {
    NSString* output = [NSString stringWithFormat:@"%@%@%@%@", 
                        [fieldOne stringValue],
                        [fieldTwo stringValue],
                        [fieldThree stringValue],
                        [fieldFour stringValue]];
    
    return output;
}

- (void) setValue:(NSString*) value {
    if ([value length] == 4) {
        [fieldOne setStringValue: getStringAtCharacterPosition(value, 0)];
        [fieldTwo setStringValue: getStringAtCharacterPosition(value, 1)];
        [fieldThree setStringValue: getStringAtCharacterPosition(value, 2)];
        [fieldFour setStringValue: getStringAtCharacterPosition(value, 3)];
    } else {
        [fieldOne setStringValue: @""];
        [fieldTwo setStringValue: @""];
        [fieldThree setStringValue: @""];
        [fieldFour setStringValue: @""];
    }
}

- (NSResponder*) preferedFirstResponder {
    return fieldOne;
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
    NSLog(@"textShouldEndEditing");
    if ( (control == fieldFour) && ( [self value].length > 0 ) ) {
        // if we are on field four AND the user has inputted something
        // in the pin control
        [self.delegate pinPasswordDidChange: self];
    }
    
    return YES;
}

// Thanks <http://stackoverflow.com/a/6016504/224334>
- (BOOL)control:(NSControl *)control textView:(NSTextView *)fieldEditor doCommandBySelector:(SEL)commandSelector
{
    BOOL retval = NO;
    
    if (commandSelector == @selector(deleteBackward:)) {
        if (  [ [fieldEditor string] length ] == 0 ) {
            NSView* aPreviousView = [self _previousFieldFor: control];
            [aPreviousView becomeFirstResponder];

            //retval = YES; // causes Apple to NOT fire the default enter action
        }
    }
    
    //NSLog(@"Selector = %@", NSStringFromSelector( commandSelector ) );
    
    return retval;  
}

- (void) _toggleFieldLookFor: (NSTextField*) textField {
    NSTextFieldCell* newCell;
    
    if (isInSecureMode) {
        newCell = [[NSTextFieldCell alloc] init];
    } else {
        newCell = [[NSSecureTextFieldCell alloc] init];
    }
    
    newCell.editable = YES;
    newCell.backgroundColor = [NSColor whiteColor];
    newCell.bezeled = YES;
    [newCell setStringValue: [textField.cell stringValue]];
    newCell.font = [textField.cell font];
    newCell.alignment = [textField.cell alignment];
    newCell.textColor = [textField.cell textColor];
    
    textField.cell = newCell;
    [textField needsDisplay];    
}

- (NSView*) _previousFieldFor: (NSView*) current {
    return [self.previousPasswordControl objectForKey: [NSValue valueWithNonretainedObject: current]];
}

- (NSView*) _nextFieldFor: (NSView*) current {
    return [self.nextPasswordControl objectForKey: [NSValue valueWithNonretainedObject: current]];
}
@end
