//
//  RAVExampleDataSource.h
//  TableController
//
//  Created by Andrew Romanov on 25.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAVTableControllerListModelMemory.h"
#import "RAVEditDelegateP.h"


@protocol RAVExampleDataSourceDelegate;
@interface RAVExampleDataSource : NSObject <RAVEditDelegateP>

@property (nonatomic, weak) id<RAVExampleDataSourceDelegate> delegate;

- (void)reloadModel;
- (RAVTableControllerListModelMemory *)getListModel;

@end


@protocol RAVExampleDataSourceDelegate <NSObject>


@end

