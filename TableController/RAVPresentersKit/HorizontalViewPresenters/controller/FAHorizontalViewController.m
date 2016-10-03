//
//  FAHorizontalViewController.m
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 28.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "FAHorizontalViewController.h"
#import "RAVPresentersStore.h"


@interface FAHorizontalViewController ()

@property (nonatomic, strong) RAVPresentersStore* cellsPresenters;

@end


@interface FAHorizontalViewController (Private)

- (id)_modelForIndex:(NSUInteger)index;

@end


@implementation FAHorizontalViewController


- (id)init
{
	if (self = [super init])
	{
		_cellsPresenters = [[RAVPresentersStore alloc] init];
	}
	
	return self;
}


- (void)setHorizontalView:(FAHorizontalView *)horizontalView
{
	_horizontalView = horizontalView;
	
	[self.cellsPresenters makeObjectsPerformSelector:@selector(setHorizontalView:) withObject:_horizontalView];
	
	_horizontalView.delegate = self;
	_horizontalView.dataSource = self;
	
	[_horizontalView reloadData];
}


- (void)setModels:(NSArray *)models
{
	_models = models;
	
	[self.horizontalView reloadData];
}


- (void)registerPresenter:(FAHorizontalViewPresenter*)presenter
{
	[_cellsPresenters registerPresenter:presenter];
}


- (void)scrollToModel:(id)model scrollPosition:(FAHorizontalViewScrollPosition)scrollPosition animated:(BOOL)animated
{
	NSInteger index = [self.models indexOfObjectIdenticalTo:model];
	if (index != NSNotFound)
	{
		[self.horizontalView scrollToCollumnAtIndex:index scrollPosition:scrollPosition animated:animated];
	}
	NSParameterAssert(index != NSNotFound);
}


- (void)scrollToVisibleModel:(id)model scrollPosition:(FAHorizontalViewScrollPosition)scrollPosition animated:(BOOL)animated
{
	NSInteger index = [self.models indexOfObjectIdenticalTo:model];
	if (index != NSNotFound)
	{
		[self.horizontalView scrollToVisibleCollumnAtIndex:index scrollPosition:scrollPosition animated:animated];
	}
	NSParameterAssert(index != NSNotFound);
}


#pragma mark FAHorizontalViewDataSource
- (NSUInteger)faHorizontalViewCountCollumns:(FAHorizontalView*)sender
{
	return [self.models count];
}


- (UICollectionViewCell*)faHorizontalView:(FAHorizontalView*)sender viewForCollumn:(NSUInteger)collumnIndex
{
	id model = [self _modelForIndex:collumnIndex];
	FAHorizontalViewPresenter* presenter = [self.cellsPresenters presenterForModel:model];
	UICollectionViewCell* cell = [presenter collectionCellForModel:model atCollumn:collumnIndex];
	
	return cell;
}


- (CGFloat)faHorizontalView:(FAHorizontalView*)sender widthForCollumn:(NSUInteger)collumnIndex
{
	id model = [self _modelForIndex:collumnIndex];
	FAHorizontalViewPresenter* presenter = [self.cellsPresenters presenterForModel:model];
	CGFloat width = [presenter widthForModel:model];
	return width;
}


#pragma mark FAHorizontalViewDelegate
- (void)faHorizontalView:(FAHorizontalView*)sender selectedCollumn:(NSUInteger)collumnIndex
{
	id model = [self _modelForIndex:collumnIndex];
	FAHorizontalViewPresenter* presenter = [self.cellsPresenters presenterForModel:model];
	
	BOOL needsDeselect = NO;
	BOOL animated = NO;
	[presenter selectedModel:model needsDeselect:&needsDeselect animated:&animated];
	if (needsDeselect)
	{
		[self.horizontalView deselectCollumnAtIndex:collumnIndex animated:animated];
	}
}


- (void)dealloc
{
	self.horizontalView.delegate = nil;
	self.horizontalView.dataSource = nil;
}

@end


#pragma mark -
@implementation FAHorizontalViewController (Private)

- (id)_modelForIndex:(NSUInteger)index
{
	id model = [self.models objectAtIndex:index];
	return model;
}

@end
