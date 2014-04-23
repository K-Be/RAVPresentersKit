//
//  RAVTableController.h
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAVCellPresenter.h"
#import "RAVSectionHeaderViewPresenter.h"
#import "RAVSectionFooterViewPresenter.h"
#import "RAVTableControllerListModel.h"
#import "RAVScrollViewDelegateP.h"
#import "RAVEditDelegateP.h"
#import "RAVSectionIndexesDelegateP.h"


@interface RAVTableController : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) RAVTableControllerListModel* model;

@property (nonatomic, weak) id<RAVScrollViewDelegateP> scrollViewDelegate;
@property (nonatomic, weak) id<RAVEditDelegateP> editDelegate;
@property (nonatomic, weak) id<RAVSectionIndexesDelegateP> sectionIndexesDelegate;

- (void)reloadData;

- (void)registerCellPresenter:(RAVCellPresenter*)cellPresenter;
- (void)registerSectionHeaderPresenter:(RAVSectionHeaderViewPresenter*)sectionHeaderPresenter;
- (void)registerSectionFooterPreseter:(RAVSectionFooterViewPresenter*)sectionFooterPresenter;

@end
