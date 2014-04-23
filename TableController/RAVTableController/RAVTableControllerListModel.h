//
//  RAVTableControllerListModel.h
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAVTableControllerSectionModel.h"


@interface RAVTableControllerListModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray* sectionModels; //list of RAVTableControllerSectionModel;

- (id)getModelForIndexPath:(NSIndexPath*)indexPath;
- (void)moveModelAtIndexPath:(NSIndexPath*)indexPath toIndexPath:(NSIndexPath*)destinationIndexPath;
- (id)removeModelAtIndexPath:(NSIndexPath*)indexPath;//return removed model

- (RAVTableControllerSectionModel*)sectionModelForSectionIndex:(NSInteger)index;

@end
