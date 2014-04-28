//
//  RAVTableControllerSectionModel.m
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableControllerSectionModel.h"

@implementation RAVTableControllerSectionModel

- (id)init
{
	if (self = [super init])
	{
		_models = [[NSMutableArray alloc] init];
	}
	
	return self;
}


- (id)copyWithZone:(NSZone *)zone
{
	typeof(self) copy = [[[self class] alloc] init];
	[copy.models addObjectsFromArray:self.models];
	copy.headerViewModel = self.headerViewModel;
	copy.footerViewModel = self.footerViewModel;
	
	return copy;
}


- (id)getModelAtIndex:(NSInteger)index
{
	id model = [self.models objectAtIndex:index];
	return model;
}


- (void)removeModelAtIndex:(NSInteger)index
{
	[self.models removeObjectAtIndex:index];
}


- (void)insertModel:(id)model atIndex:(NSInteger)index
{
	[self.models insertObject:model atIndex:index];
}


- (void)exchangeModelAtIndex:(NSInteger)firstModelIndex withModelatIndex:(NSInteger)secondModelIndex
{
	[self.models exchangeObjectAtIndex:firstModelIndex withObjectAtIndex:secondModelIndex];
}

@end
