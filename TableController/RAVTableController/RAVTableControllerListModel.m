//
//  RAVTableControllerListModel.m
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableControllerListModel.h"

@implementation RAVTableControllerListModel

- (id)init
{
	if (self = [super init])
	{
		_sectionModels = [[NSMutableArray alloc] init];
	}
	
	return self;
}

@end
