//
//  RAVPersonPresenter.m
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVPersonPresenter.h"
#import "RAVPersonCell.h"


@implementation RAVPersonPresenter


- (BOOL)canPresent:(id)model
{
	return [model class] == [RAVPersonModel class];
}


- (void)registerCells
{
	[self.tableView registerNib:[RAVPersonCell nib] forCellReuseIdentifier:[RAVPersonCell cellId]];
}


- (UITableViewCell*)cellForModel:(id)model
{
	RAVPersonCell* cell = [self.tableView dequeueReusableCellWithIdentifier:[RAVPersonCell cellId]];
	cell.person = model;
	
	return cell;
}


#pragma mark RAVCellActionsDelegateP
- (CGFloat)ravTableController:(RAVTableController*)sender rowHeightForModel:(id)model
{
	return 50.0;
}


- (void)ravTableController:(RAVTableController*)sender didSelectModel:(id)model needsDeselect:(inout BOOL*)needsDeselect animated:(inout BOOL*)animated
{
	*needsDeselect = YES;
	*animated = YES;
	
	[self.delegate ravCellActions:self didSelectedModel:model];
}

@end
