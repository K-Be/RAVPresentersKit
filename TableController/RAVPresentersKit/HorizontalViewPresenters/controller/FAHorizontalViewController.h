//
//  FAHorizontalViewController.h
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 28.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAHorizontalViewPresenter.h"


@interface FAHorizontalViewController : NSObject <FAHorizontalViewDataSource, FAHorizontalViewDelegate>

@property (nonatomic, strong) FAHorizontalView* horizontalView;
@property (nonatomic, strong) NSArray* models;

- (void)registerPresenter:(FAHorizontalViewPresenter*)presenter;

- (void)scrollToModel:(id)model scrollPosition:(FAHorizontalViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToVisibleModel:(id)model scrollPosition:(FAHorizontalViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end
