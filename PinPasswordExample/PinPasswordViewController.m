//
//  PinPasswordViewController.m
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 6/27/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import "PinPasswordViewController.h"
#import "FilteringTextField.h"

@interface PinPasswordViewController ()

@end

@implementation PinPasswordViewController
@synthesize fieldOne;
@synthesize fieldTwo;
@synthesize fieldThree;
@synthesize fieldFour;

+(PinPasswordViewController*) pinPasswordViewController {
    PinPasswordViewController* output = [[PinPasswordViewController alloc] 
                                         initWithNibName: @"PinPasswordViewController" bundle: nil];
    
    return output;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isInSecureMode = NO;
        // Initialization code here.
        
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
    
    isInSecureMode = !isInSecureMode;
}

- (NSString*) value {
    NSString* output = [NSString stringWithFormat:@"%@%@%@%@", 
                        [fieldOne stringValue],
                        [fieldTwo stringValue],
                        [fieldThree stringValue],
                        [fieldFour stringValue]];
    
    return output;
}

- (NSResponder*) preferedFirstResponder {
    return fieldOne;
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
    
    textField.cell = newCell;
    [textField needsDisplay];    
}
@end
