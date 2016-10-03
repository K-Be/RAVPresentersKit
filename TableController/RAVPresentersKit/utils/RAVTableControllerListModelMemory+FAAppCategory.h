//
//  RAVTableControllerListModelMemory+FAAppCategory.h
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 01.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableControllerListModelMemory.h"

@interface RAVTableControllerListModelMemory (FAAppCategory)

+ (instancetype)fa_tableModelWithOneCellModel:(id)model;
+ (instancetype)fa_tableModelWithSectionCellsModels:(NSArray*)cellsModels;
+ (instancetype)fa_tableModelWithSectionModel:(RAVTableControllerSectionModelMemory*)oneSectionModel;
+ (instancetype)fa_tableModelWithSections:(NSArray*)sectionsModels;

@end
