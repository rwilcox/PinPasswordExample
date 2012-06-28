//
//  FilteringTextField.m
//  FilteringFieldTest
//
//  Created by Scott Gruby on 3/28/08.
//  Copyright 2008 GGT Enterprises, LLC. All rights reserved.
//

#import "FilteringTextField.h"

@implementation FilteringTextField
@synthesize lengthDelegate;

- (void) dealloc
{
//	[filterCharacterSet release];
//	[super dealloc];
}

- (BOOL) becomeFirstResponder
{
	BOOL value = [super becomeFirstResponder];
	[ [self currentEditor] setDelegate:self];
	return value;
}

- (BOOL) resignFirstResponder
{
	BOOL value = [super resignFirstResponder];
	if (value)
	{
		[ [self currentEditor] setDelegate:nil];
	}
	return value;
}

- (BOOL)textView:(NSTextView *)aTextView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString
{
	if (filterCharacterSet != nil)
	{
		int i = 0;
		int len = [replacementString length];
		for (i = 0; i < len; i++)
		{
			if (![filterCharacterSet characterIsMember:[replacementString characterAtIndex:i]])
			{
				return NO;
			}
		}
	}
	
	if (maxLength)
	{
		int strLen = [[self stringValue] length];
		int addLength = [replacementString length] -  affectedCharRange.length;
		if (strLen + addLength >= maxLength)
		{
            [(NSObject*)(self.delegate) performSelectorOnMainThread: @selector(didHitMaxCharactersOf:)
                                            withObject: self
                                         waitUntilDone: NO];

            if (strLen + addLength > maxLength)
                return NO;
		}
	}
	
	if (maxValue)
	{
		NSMutableString *newString = [[self stringValue] mutableCopy];
		[newString replaceCharactersInRange:affectedCharRange withString:replacementString];
		if ([newString intValue] >= maxValue)
		{
            [(NSObject*)(self.delegate) performSelectorOnMainThread: @selector(didHitMaxCharactersOf:)
                                                         withObject: self
                                                      waitUntilDone: NO];
            
            if ([newString intValue] > maxValue)
                return NO;
		}
	}
	
	return YES;
}

- (void) setAcceptableCharacterSet:(NSCharacterSet *) inCharacterSet
{
//	[inCharacterSet retain];
//	[filterCharacterSet release];
	filterCharacterSet = inCharacterSet;
}

- (void) setMaximumLength:(int) inLength
{
	maxLength = inLength;
}

- (void) setMaximumValue:(int) inValue
{
	maxValue = inValue;
}

@end
