//
//  PinPasswordViewController.h
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 6/27/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FilteringTextField;

@interface PinPasswordViewController : NSViewController

+(PinPasswordViewController*) pinPasswordViewController;

@property (strong) IBOutlet FilteringTextField *fieldOne;
@property (strong) IBOutlet FilteringTextField *fieldTwo;
@property (strong) IBOutlet FilteringTextField *fieldThree;


- (void) didHitMaxCharactersOf: (FilteringTextField*) maxChars;

@end
