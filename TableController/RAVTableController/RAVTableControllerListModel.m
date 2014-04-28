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


- (id)getModelForIndexPath:(NSIndexPath*)indexPath
{
	RAVTableControllerSectionModel* sectionModel = [self sectionModelForSectionIndex:indexPath.section];
	id model = [sectionModel getModelAtIndex:indexPath.row];
	return model;
}


- (void)moveModelAtIndexPath:(NSIndexPath*)indexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
	RAVTableControllerSectionModel* sourceSectionModel = [self sectionModelForSectionIndex:indexPath.section];
	id model = [sourceSectionModel getModelAtIndex:indexPath.row];
	[sourceSectionModel removeModelAtIndex:indexPath.row];
		
	RAVTableControllerSectionModel* destinationSectionModel = [self sectionModelForSectionIndex:destinationIndexPath.section];
	[destinationSectionModel insertModel:model atIndex:destinationIndexPath.row];
}


- (id)removeModelAtIndexPath:(NSIndexPath*)indexPath
{
	RAVTableControllerSectionModel* sectionModel = [self sectionModelForSectionIndex:indexPath.section];
	id model = [sectionModel getModelAtIndex:indexPath.row];
	[sectionModel removeModelAtIndex:indexPath.row];
	return model;
}


- (RAVTableControllerSectionModel*)sectionModelForSectionIndex:(NSInteger)index
{
	RAVTableControllerSectionModel* sectionModel = [self.sectionModels objectAtIndex:index];
	return sectionModel;
}

@end
