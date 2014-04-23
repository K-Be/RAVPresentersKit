//
//  RAVCellPresenter.h
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAVPresenterP.h"


@interface RAVCellPresenter : NSObject <RAVPresenterP>


@end


@interface RAVCellPresenter (Protected)

- (void)registerCells;
- (UITableViewCell*)cellForModel:(id)model;

@end

