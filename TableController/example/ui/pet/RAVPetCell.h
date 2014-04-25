//
//  RAVPetCell.h
//  TableController
//
//  Created by Andrew Romanov on 25.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVCellBase.h"
#import "RAVPetModel.h"


@interface RAVPetCell : RAVCellBase

@property (nonatomic, strong) RAVPetModel* petModel;

@end
