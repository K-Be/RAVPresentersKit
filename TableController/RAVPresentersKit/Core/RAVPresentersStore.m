//
//  RAVPresentersStore.m
//  TableController
//
//  Created by Andrew Romanov on 02.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVPresentersStore.h"


@interface RAVPresentersStore ()

@property (nonatomic, strong) NSMutableArray* rav_presenters;

@end


@implementation RAVPresentersStore

- (id)init
{
	if (self = [super init])
	{
		self.rav_presenters = [[NSMutableArray alloc] init];
	}
	
	return self;
}


- (void)registerPresenter:(id<RAVPresenterP>)presenter
{
	[self.rav_presenters addObject:presenter];
}


- (id<RAVPresenterP>)presenterForModel:(id)model
{
	id<RAVPresenterP> presenter = nil;
	
	if (model)
	{
		NSInteger presenterIndex = [self.rav_presenters indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
			id<RAVPresenterP> presenterCandidate = obj;
			BOOL requiredObject = [presenterCandidate canPresent:model];
			return requiredObject;
		}];
		
		if (presenterIndex != NSNotFound)
		{
			presenter = [self.rav_presenters objectAtIndex:(NSUInteger)presenterIndex];
		}
		NSAssert(presenter != nil, @"can't find presenter for model: %@", model);
	}
	
	return presenter;
}


- (void)makeObjectsPerformSelector:(SEL)selector withObject:(id)object
{
	[self.rav_presenters makeObjectsPerformSelector:selector withObject:object];
}


- (void)makeObjectsPerformSelector:(SEL)selector
{
	[self.rav_presenters makeObjectsPerformSelector:selector];
}

@end
