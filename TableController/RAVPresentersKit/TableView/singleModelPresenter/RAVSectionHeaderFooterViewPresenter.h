//
//  RAVSectionHeaderFooterViewPresenter.h
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAVPresenterP.h"
#import "RAVSectionModelPresenterP.h"


@interface RAVSectionHeaderFooterViewPresenter : NSObject <RAVPresenterP, RAVSectionModelPresenterP>

@property (nonatomic, weak) UITableView* tableView;

@end


@interface RAVSectionHeaderFooterViewPresenter (Override)

- (void)registerView;

@end
