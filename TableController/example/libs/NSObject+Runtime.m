//
//  NSObject+Runtime.m
//  TagBrandClient
//
//  Created by Andrew Romanov on 18.04.13.
//  Copyright (c) 2013 Andrew Romanov. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (NSString*)className
{
	const char* className = class_getName([self class]);
	NSString* string = [NSString stringWithCString:className encoding:NSUTF8StringEncoding];
	return string;
}


- (NSString*)className
{
	Class class = [self class];
	NSString* className = [class className];
	return className;
}

@end
