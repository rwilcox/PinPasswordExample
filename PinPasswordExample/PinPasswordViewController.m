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

+(PinPasswordViewController*) pinPasswordViewController {
    PinPasswordViewController* output = [[PinPasswordViewController alloc] 
                                         initWithNibName: @"PinPasswordViewController" bundle: nil];
    
    return output;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
}

- (void) didHitMaxCharactersOf: (FilteringTextField*) currentField {
    [[currentField nextKeyView] becomeFirstResponder];
//    [[currentField nextResponder] resignFirstResponder];
}
@end
