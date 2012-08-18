//
//  AppDelegate.h
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 6/27/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PinPasswordViewControllerDelegate.h"

@class PinPasswordViewController;

@interface AppDelegate : NSObject <NSApplicationDelegate, PinPasswordViewControllerDelegate> {
    PinPasswordViewController* pinPasswordViewController;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *pinPasswordDestinationView;

- (IBAction)doButtonPress:(id)sender;

@end
