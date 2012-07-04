//
//  AppDelegate.m
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 6/27/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "PinPasswordViewController.h"
#import "FilteringTextField.h"
@implementation AppDelegate

@synthesize window = _window;
@synthesize pinPasswordDestinationView = _pinPasswordDestinationView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void) awakeFromNib {
    pinPasswordViewController = [PinPasswordViewController pinPasswordViewController];
    [self.pinPasswordDestinationView addSubview: pinPasswordViewController.view];
    
    [self.window performSelector:@selector(makeFirstResponder:) withObject: [pinPasswordViewController preferedFirstResponder] afterDelay:0.0];
    // needed because the system will automagically select the last text field the user has typed into. Which doesn't work for us
    // AND this selection happens sometime after the awakeFromNib cycle, so shove this event onto the run loop and wait until the sys is ready for us.
    // WD-rpw 07-04-2012
     
}

- (IBAction)doButtonPress:(id)sender {
    NSLog(@"the value is %@", [pinPasswordViewController value]);
}
@end
