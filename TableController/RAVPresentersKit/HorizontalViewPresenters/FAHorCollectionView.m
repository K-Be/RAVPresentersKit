//
//  FAHorCollectionView.m
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 10.11.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "FAHorCollectionView.h"


@interface FAHorCollectionView (FA_Pri)

- (void)fa_commonInitialization;

@end


@implementation FAHorCollectionView

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self fa_commonInitialization];
	}
	
	return self;
}


- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self fa_commonInitialization];
	}
	
	return self;
}


- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
	if (self = [super initWithFrame:frame collectionViewLayout:layout])
	{
		[self fa_commonInitialization];
	}
	
	return self;
}


- (id)init
{
	if (self = [super init])
	{
		[self fa_commonInitialization];
	}
	
	return self;
}


- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
	return YES;
}

@end


#pragma mark -
@implementation FAHorCollectionView (FA_Pri)

- (void)fa_commonInitialization
{
	self.delaysContentTouches = NO;
}

@end
