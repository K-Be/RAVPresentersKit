//
//  RAVTableControllerSectionModelMemory+FAAppCategory.m
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 01.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableControllerSectionModelMemory+FAAppCategory.h"

@implementation RAVTableControllerSectionModelMemory (FAAppCategory)

+ (instancetype)fa_sectionModelWithOneCellModel:(id)cellModel
{
	RAVTableControllerSectionModelMemory* sectionModel = [[RAVTableControllerSectionModelMemory alloc] init];
	if (cellModel)
	{
		[sectionModel.models addObject:cellModel];
	}
	
	return sectionModel;
}


+ (instancetype)fa_sectionModelWithCellsModels:(NSArray*)cellsModels
{
	RAVTableControllerSectionModelMemory* sectionModel = [[RAVTableControllerSectionModelMemory alloc] init];
	if (cellsModels)
	{
		[sectionModel.models addObjectsFromArray:cellsModels];
	}
	
	return sectionModel;
}

@end
