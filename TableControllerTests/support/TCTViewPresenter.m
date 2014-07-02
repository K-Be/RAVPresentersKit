//
//  TCTViewPresenter.m
//  TableController
//
//  Created by Andrew Romanov on 02.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "TCTViewPresenter.h"
#import "TCTViewModel.h"


@implementation TCTViewPresenter

@synthesize tableView = _tableView;

- (BOOL)canPresent:(id)model
{
	return [model isKindOfClass:[TCTViewModel class]];
}


- (CGFloat)ravTableController:(RAVTableController*)sender sectionViewHeightForModel:(id)sectionViewModel
{
	return 40.0;
}


- (UIView*)ravTableController:(RAVTableController*)sender sectionViewForModel:(id)sectionViewModel
{
	return [[UIView alloc] initWithFrame:CGRectZero];
}

@end
