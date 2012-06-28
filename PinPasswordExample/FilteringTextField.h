//
//  FilteringTextField.h
//  FilteringFieldTest
//
//  Created by Scott Gruby on 3/28/08.
//  Copyright 2008 GGT Enterprises, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FilteringTextField : NSTextField
{
	NSCharacterSet *filterCharacterSet;
	int				maxLength;
	int				maxValue;
}

- (void) setAcceptableCharacterSet:(NSCharacterSet *) inCharacterSet;
- (void) setMaximumLength:(int) inLength;
- (void) setMaximumValue:(int) inValue;
@property (strong) NSObject* lengthDelegate;

@end
