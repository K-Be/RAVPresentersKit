//
//  RAVPersonCell.h
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAVCellBase.h"
#import "RAVPersonModel.h"


@interface RAVPersonCell : RAVCellBase

@property (nonatomic, strong) RAVPersonModel* person;

@end
