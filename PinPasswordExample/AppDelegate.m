//
//  AppDelegate.m
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 6/27/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "PinPasswordViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize pinPasswordDestinationView = _pinPasswordDestinationView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void) awakeFromNib {
    [self.pinPasswordDestinationView addSubview: [PinPasswordViewController pinPasswordViewController].view];
     
}

@end
