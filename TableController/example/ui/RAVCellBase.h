//
//  RAVCellBase.h
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAVCellBase : UITableViewCell

+ (UINib*)nib;
+ (NSString*)cellId;

@end
