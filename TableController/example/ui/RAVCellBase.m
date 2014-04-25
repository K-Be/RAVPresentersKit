//
//  RAVCellBase.m
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVCellBase.h"
#import "NSObject+Runtime.h"


@implementation RAVCellBase

+ (UINib*)nib
{
	UINib* nib = [UINib nibWithNibName:[self className] bundle:[NSBundle mainBundle]];
	return nib;
}


+ (NSString*)cellId
{
	NSString* cellId = [self className];
	return cellId;
}

@end
