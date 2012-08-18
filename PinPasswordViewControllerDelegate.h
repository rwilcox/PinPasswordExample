//
//  PinPasswordViewControllerDelegate.h
//  PinPasswordExample
//
//  Created by Ryan Wilcox on 7/5/12.
//  Copyright (c) 2012 Wilcox Development Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PinPasswordViewController;

@protocol PinPasswordViewControllerDelegate <NSObject>

- (void) pinPasswordDidChange: (PinPasswordViewController*) pinController;

@end
