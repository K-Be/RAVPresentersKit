//
//  NSObject+Runtime.h
//  TagBrandClient
//
//  Created by Andrew Romanov on 18.04.13.
//  Copyright (c) 2013 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

+ (NSString*)className;
- (NSString*)className;

@end
