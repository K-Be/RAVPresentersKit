//
//  RAVTableControllerSectionModelMemory+FAAppCategory.h
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 01.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableControllerSectionModelMemory.h"

@interface RAVTableControllerSectionModelMemory (FAAppCategory)

+ (instancetype)fa_sectionModelWithOneCellModel:(id)cellModel;
+ (instancetype)fa_sectionModelWithCellsModels:(NSArray*)cellsModels;

@end
