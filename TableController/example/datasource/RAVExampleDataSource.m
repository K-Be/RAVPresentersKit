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

@property (nonatomic, strong) RAVTableControllerListModelMemory * list;
@property (nonatomic, strong) RAVDataLoader* dataLoader;

@end


@interface RAVExampleDataSource (Private)

- (RAVTableControllerSectionModelMemory *)loadPersonSection;
- (RAVTableControllerSectionModelMemory *)loadPetsSection;

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
	self.list = [[RAVTableControllerListModelMemory alloc] init];
	[self.list.sectionModels addObject:[self loadPersonSection]];
	[self.list.sectionModels addObject:[self loadPetsSection]];
}


- (RAVTableControllerListModelMemory *)getListModel
{
	if (!_list)
	{
		[self reloadModel];
	}
	return _list;
}


#pragma mark RAVEditDelegateP
- (BOOL)ravTableController:(RAVTableController*)sender canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
	return YES;
}


- (BOOL)ravTableController:(RAVTableController*)sender canMoveRowAtIndexPath:(NSIndexPath*)indexPath
{
	return YES;
}


- (void)ravTableController:(RAVTableController*)sender moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	[self.list moveModelAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}


- (UITableViewCellEditingStyle)ravTableController:(RAVTableController*)sender editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}


- (void)ravTableController:(RAVTableController*)sender commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
	
}

@end


#pragma mark -
@implementation RAVExampleDataSource (Private)

- (RAVTableControllerSectionModelMemory *)loadPersonSection
{
	NSArray* persons = [self.dataLoader loadHumans];
	RAVTableControllerSectionModelMemory * sectionModel = [[RAVTableControllerSectionModelMemory alloc] init];
	[sectionModel.models addObjectsFromArray:persons];
	return sectionModel;
}


- (RAVTableControllerSectionModelMemory *)loadPetsSection
{
	NSArray* pets = [self.dataLoader loadPets];
	RAVTableControllerSectionModelMemory * sectionModel = [[RAVTableControllerSectionModelMemory alloc] init];
	[sectionModel.models addObjectsFromArray:pets];
	return sectionModel;
}

@end

