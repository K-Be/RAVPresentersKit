//
//  TCTPresenter.m
//  TableController
//
//  Created by Andrew Romanov on 02.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "TCTPresenter.h"
#import "TCTCellModel.h"


@implementation TCTPresenter


- (void)registerCells
{
	
}


- (UITableViewCell*)cellForModel:(id)model
{
	NSString* cellId = @"CellId";
	UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
	}
	
	return cell;
}


- (BOOL)canPresent:(id)model
{
	BOOL can = [model isKindOfClass:[TCTCellModel class]];
	return can;
}

@end
