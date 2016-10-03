//
//  FAHorizontalViewPresenter.h
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 28.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAVPresenterP.h"
#import "FAHorizontalView.h"


@interface FAHorizontalViewPresenter : NSObject <RAVPresenterP>

@property (nonatomic, weak) FAHorizontalView* horizontalView;

- (BOOL)canPresent:(id)model;
- (UICollectionViewCell*)collectionCellForModel:(id)model atCollumn:(NSUInteger)collumn;
- (CGFloat)widthForModel:(id)model;
- (void)selectedModel:(id)model needsDeselect:(out BOOL*)needsDeselect animated:(out BOOL*)animated;

@end


@interface FAHorizontalViewPresenter (Override)

- (void)_registerCells;

@end


