//
//  FAHorizontalViewPresenter.m
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 28.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "FAHorizontalViewPresenter.h"

@implementation FAHorizontalViewPresenter


- (void)setHorizontalView:(FAHorizontalView *)horizontalView
{
	_horizontalView = horizontalView;
	
	[self _registerCells];
}



- (BOOL)canPresent:(id)model
{
	return NO;
}


- (UICollectionViewCell*)collectionCellForModel:(id)model atCollumn:(NSUInteger)collumn
{
	return nil;
}


- (CGFloat)widthForModel:(id)model
{
	return 40.0;
}


- (void)selectedModel:(id)model needsDeselect:(out BOOL*)needsDeselect animated:(out BOOL*)animated
{
	
}

@end


#pragma mark -
@implementation FAHorizontalViewPresenter (Override)

- (void)_registerCells
{
	
}

@end

