//
//  FACollectionViewPresenter.m
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 30.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "FACollectionViewPresenter.h"

@implementation FACollectionViewPresenter


- (void)setCollectionView:(UICollectionView *)collectionView
{
	_collectionView = collectionView;
	
	[self _registerViews];
}


- (BOOL)canPresent:(id)model
{
	return NO;
}


- (UICollectionViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath
{
	return nil;
}


- (void)selectedModel:(id)model deselect:(out BOOL*)deselect animated:(out BOOL*)animated
{
	
}


- (CGSize)sizeForModel:(id)model forIndexPath:(NSIndexPath*)indexPath
{
	return CGSizeMake(10.0, 10.0);
}


@end


@implementation FACollectionViewPresenter (Override)

- (void)_registerViews
{
	
}

@end

