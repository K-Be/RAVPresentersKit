//
//  RAVTableControllerListModelMemory+FAAppCategory.m
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 01.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableControllerListModelMemory+FAAppCategory.h"
#import "RAVTableControllerSectionModelMemory+FAAppCategory.h"


@implementation RAVTableControllerListModelMemory (FAAppCategory)

+ (instancetype)fa_tableModelWithOneCellModel:(id)model
{
	RAVTableControllerSectionModelMemory* sectionModel = [RAVTableControllerSectionModelMemory fa_sectionModelWithOneCellModel:model];
	RAVTableControllerListModelMemory* listModel = [self fa_tableModelWithSectionModel:sectionModel];

	return listModel;
}


+ (instancetype)fa_tableModelWithSectionCellsModels:(NSArray*)cellsModels
{
	RAVTableControllerSectionModelMemory* sectionModel = [RAVTableControllerSectionModelMemory fa_sectionModelWithCellsModels:cellsModels];
	RAVTableControllerListModelMemory* listModel = [RAVTableControllerListModelMemory fa_tableModelWithSectionModel:sectionModel];
	return listModel;
}


+ (instancetype)fa_tableModelWithSectionModel:(RAVTableControllerSectionModelMemory*)oneSectionModel
{
	RAVTableControllerListModelMemory* listModel = [[RAVTableControllerListModelMemory alloc] init];
	if (oneSectionModel)
	{
		NSAssert([oneSectionModel isKindOfClass:[RAVTableControllerSectionModelMemory class]], @"must be RAVTableControllerSectionModelMemory");
		[listModel.sectionModels addObject:oneSectionModel];
	}
	else
	{
		NSAssert(NO, @"section model must not be nil");
		[listModel.sectionModels addObject:[RAVTableControllerSectionModelMemory fa_sectionModelWithOneCellModel:nil]];
	}
	
	return listModel;
}


+ (instancetype)fa_tableModelWithSections:(NSArray*)sectionsModels
{
	RAVTableControllerListModelMemory* listModel = [[RAVTableControllerListModelMemory alloc] init];
	if (sectionsModels && [sectionsModels count] != 0)
	{
		NSAssert([[[NSSet setWithArray:sectionsModels] anyObject] isKindOfClass:[RAVTableControllerSectionModelMemory class]], @"objects must be RAVTableControllerSectionModelMemory");
		[listModel.sectionModels addObjectsFromArray:sectionsModels];
	}
	else
	{
		NSAssert(NO, @"sectionModels must not be nil");
		[listModel.sectionModels addObject:[RAVTableControllerSectionModelMemory fa_sectionModelWithOneCellModel:nil]];
	}
	
	return listModel;
}

@end
