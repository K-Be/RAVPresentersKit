//
//  RAVPersonPresenter.h
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVCellPresenter.h"
#import "RAVPersonModel.h"


@protocol  RAVPersonPresenterDelegate;
@interface RAVPersonPresenter : RAVCellPresenter

@property (nonatomic, weak) id<RAVPersonPresenterDelegate> delegate;

@end


@protocol  RAVPersonPresenterDelegate <NSObject>

- (void)ravCellActions:(RAVPersonPresenter*)sender didSelectedModel:(RAVPersonModel*)model;

@end
