//
//  RAVPetPresenter.m
//  TableController
//
//  Created by Andrew Romanov on 25.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVPetPresenter.h"
#import "RAVPetCell.h"



@implementation RAVPetPresenter

- (void)registerCells
{
	[[self tableView] registerNib:[RAVPetCell nib] forCellReuseIdentifier:[RAVPetCell cellId]];
}


- (UITableViewCell*)cellForModel:(id)model
{
	RAVPetCell* cell = [self.tableView dequeueReusableCellWithIdentifier:[RAVPetCell cellId]];
	cell.petModel = model;
	
	return cell;
}


- (BOOL)canPresent:(id)model
{
	BOOL can = [model class] == [RAVPetModel class];
	return can;
}


#pragma mark RAVCellActionsDelegateP
- (CGFloat)ravTableController:(RAVTableController*)sender rowHeightForModel:(id)model
{
	return 35.0;
}


- (void)ravTableController:(RAVTableController*)sender didSelectModel:(id)model needsDeselect:(inout BOOL*)needsDeselect animated:(inout BOOL*)animated
{
	*needsDeselect = YES;
	*animated = YES;
	
	[self.delegate ravPetPresenter:self selectedPet:model];
}


@end
