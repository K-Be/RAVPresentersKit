//
//  RAVExampleDataSource.m
//  TableController
//
//  Created by Andrew Romanov on 25.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVExampleDataSource.h"
#import "RAVDataLoader.h"


@interface RAVExampleDataSource ()

@property (nonatomic, strong) RAVTableControllerListModel* list;
@property (nonatomic, strong) RAVDataLoader* dataLoader;

@end


@interface RAVExampleDataSource (Private)

- (RAVTableControllerSectionModel*)loadPersonSection;
- (RAVTableControllerSectionModel*)loadPetsSection;

@end


@implementation RAVExampleDataSource

- (id)init
{
	if (self = [super init])
	{
		self.dataLoader = [[RAVDataLoader alloc] init];
	}
	
	return self;
}


- (void)reloadModel
{
	self.list = [[RAVTableControllerListModel alloc] init];
	[self.list.sectionModels addObject:[self loadPersonSection]];
	[self.list.sectionModels addObject:[self loadPetsSection]];
}


- (RAVTableControllerListModel*)getListModel
{
	return _list;
}

@end


#pragma mark -
@implementation RAVExampleDataSource (Private)

- (RAVTableControllerSectionModel*)loadPersonSection
{
	NSArray* persons = [self.dataLoader loadHumans];
	RAVTableControllerSectionModel* sectionModel = [[RAVTableControllerSectionModel alloc] init];
	[sectionModel.models addObjectsFromArray:persons];
	return sectionModel;
}


- (RAVTableControllerSectionModel*)loadPetsSection
{
	NSArray* pets = [self.dataLoader loadPets];
	RAVTableControllerSectionModel* sectionModel = [[RAVTableControllerSectionModel alloc] init];
	[sectionModel.models addObjectsFromArray:pets];
	return sectionModel;
}

@end

