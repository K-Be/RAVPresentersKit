//
//  RAVSectionViewDelegateP.h
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RAVTableController;
@protocol RAVSectionModelPresenterP <NSObject>

@optional
- (CGFloat)ravTableController:(RAVTableController*)sender sectionViewHeightForModel:(id)sectionViewModel;
- (UIView*)ravTableController:(RAVTableController*)sender sectionViewForModel:(id)sectionViewModel;

@end
