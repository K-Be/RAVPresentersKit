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


- (NSInteger)countSections
{
	return [self.sectionModels count];
}


- (id<RAVTableControllerSectionModelP>)getSectionModelForSection:(NSInteger)section
{
	return [self.sectionModels objectAtIndex:section];
}


- (id)getModelForIndexPath:(NSIndexPath*)indexPath
{
	RAVTableControllerSectionModel* sectionModel = [self sectionModelForSectionIndex:indexPath.section];
	id model = [sectionModel modelForRow:indexPath.row];
	return model;
}


- (void)moveModelAtIndexPath:(NSIndexPath*)indexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
	RAVTableControllerSectionModel* sectionModel = [self sectionModelForSectionIndex:indexPath.section];
	id model = [sectionModel modelForRow:indexPath.row];
	[sectionModel removeModelAtIndex:indexPath.row];
		
	RAVTableControllerSectionModel* destinationSectionModel = [self sectionModelForSectionIndex:destinationIndexPath.section];
	[destinationSectionModel insertModel:model atIndex:destinationIndexPath.row];
}


- (id)removeModelAtIndexPath:(NSIndexPath*)indexPath
{
	RAVTableControllerSectionModel* sectionModel = [self sectionModelForSectionIndex:indexPath.section];
	id model = [sectionModel modelForRow:indexPath.row];
	[sectionModel removeModelAtIndex:indexPath.row];
	return model;
}


- (void)insertCellModel:(id)model toIndexPath:(NSIndexPath*)indexPath
{
	RAVTableControllerSectionModel* sourceSectionModel = [self sectionModelForSectionIndex:indexPath.section];
	[sourceSectionModel insertModel:model atIndex:indexPath.row];
}


- (RAVTableControllerSectionModel*)sectionModelForSectionIndex:(NSInteger)index
{
	RAVTableControllerSectionModel* sectionModel = [self.sectionModels objectAtIndex:index];
	return sectionModel;
}


- (NSIndexPath*)indexPathForCellModelPassingTest:(BOOL (^)(id obj, NSIndexPath* modelIndexPath, BOOL *userPredicateStop))predicate
{
	__block NSInteger modelIndexInSection = NSNotFound;
	NSInteger sectionIndex = [self.sectionModels indexOfObjectPassingTest:^BOOL(id obj, NSUInteger sectionIdx, BOOL *sectionsStop) {
		RAVTableControllerSectionModel* sectionModel = obj;
		__block BOOL needsStop = NO;
		
		NSInteger neededModelIndex = [sectionModel.models indexOfObjectPassingTest:^BOOL(id obj, NSUInteger modelIdx, BOOL *stop) {
			BOOL needsStopByUser = NO;
			BOOL goodModel = predicate(obj, [NSIndexPath indexPathForRow:modelIdx inSection:sectionIdx], &needsStopByUser);
			if (needsStopByUser)
			{
				needsStop = YES;
				*stop = needsStop;
			}
			return goodModel;
		}];
		
		if (needsStop)
		{
			*sectionsStop = YES;
		}
		
		BOOL neededSection = NO;
		if (neededModelIndex != NSNotFound)
		{
			neededSection = YES;
			modelIndexInSection = neededModelIndex;
		}
		return neededSection;
	}];
	
	NSIndexPath* indexPath = nil;
	if (sectionIndex != NSNotFound && modelIndexInSection != NSNotFound)
	{
		indexPath = [NSIndexPath indexPathForRow:modelIndexInSection inSection:sectionIndex];
	}
	
	return indexPath;
}

@end
