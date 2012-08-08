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
    
    //[self.view.window makeFirstResponder: fieldOne];

}

- (void) didHitMaxCharactersOf: (FilteringTextField*) currentField {
    [[currentField nextKeyView] becomeFirstResponder];
//    [[currentField nextResponder] resignFirstResponder];
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
    
    if (control == fieldFour)
        [self.delegate pinPasswordDidChange: self];
    
    return YES;
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
@end
