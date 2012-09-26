//
//  PinPasswordViewController.h
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 6/27/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PinPasswordViewControllerDelegate.h"

@class FilteringTextField;
@class DKHoverButtonCell;

@interface PinPasswordViewController : NSViewController {
    BOOL isInSecureMode;
}

+(PinPasswordViewController*) pinPasswordViewController;

@property (strong) NSObject<PinPasswordViewControllerDelegate>* delegate; // TODO: I actually think this shoud be weak, but crashes
@property (strong) IBOutlet FilteringTextField *fieldOne;
@property (strong) IBOutlet FilteringTextField *fieldTwo;
@property (strong) IBOutlet FilteringTextField *fieldThree;
@property (strong) IBOutlet FilteringTextField *fieldFour;
@property (strong) IBOutlet DKHoverButtonCell *passwordHideBtn;
@property (assign) BOOL hidePasswordHideBtn;
@property (strong) NSString* labelText;
@property (strong) NSDictionary* nextPasswordControl;
@property (strong) NSDictionary* previousPasswordControl;

- (void) disablePinInput;
- (void) enablePinInput;

- (NSString*) value;
- (void) setValue:(NSString*) value;

- (void) didHitMaxCharactersOf: (FilteringTextField*) maxChars;
- (IBAction)toggleNumbersShowing:(id)sender;
- (NSResponder*) preferedFirstResponder;

@end
