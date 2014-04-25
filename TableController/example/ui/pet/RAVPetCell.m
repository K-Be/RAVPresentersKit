//
//  RAVPetCell.m
//  TableController
//
//  Created by Andrew Romanov on 25.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVPetCell.h"


@interface RAVPetCell ()

@end


@implementation RAVPetCell

- (void)setPetModel:(RAVPetModel *)petModel
{
	_petModel = petModel;
	
	self.textLabel.text = petModel.name;
}

@end
