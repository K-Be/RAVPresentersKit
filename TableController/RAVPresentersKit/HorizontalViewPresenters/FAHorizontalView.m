//
//  FAHorizontalView.m
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 28.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "FAHorizontalView.h"
#import "FACollectionViewFlowHorizontalLayout.h"
#import "FAHorCollectionView.h"
#import "TB_CGAdditions.h"


@interface FAHorizontalView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout* flowLayout;

@end


@interface FAHorizontalView (Private)

- (NSIndexPath*)_indexPathFromCollumnIndex:(NSUInteger)collumnIndex;
- (NSUInteger)_collumnIndexFromIndexPath:(NSIndexPath*)indexPath;
- (UICollectionViewScrollPosition)_collectionViewScrollPostionFromHorizontalViewScrollPosition:(FAHorizontalViewScrollPosition)horScrollPosition;

@end


@implementation FAHorizontalView

- (void)fa_commonInitialization
{
	[super fa_commonInitialization];
	
	_flowLayout = [[FACollectionViewFlowHorizontalLayout alloc] init];
	_flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	_collectionView = [[FAHorCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
	_collectionView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	_collectionView.backgroundColor = [UIColor clearColor];
	UIView* collectionViewBackground = [[UIView alloc] initWithFrame:CGRectZero];
	collectionViewBackground.backgroundColor = [UIColor clearColor];
	collectionViewBackground.userInteractionEnabled = NO;
	_collectionView.backgroundView = collectionViewBackground;
	
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	self.collectionView.scrollsToTop = NO;
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.showsVerticalScrollIndicator = NO;
	//self.collectionView.panGestureRecognizer.delaysTouchesBegan = YES;
	self.collectionView.delaysContentTouches = NO;
	
	[self addSubview:_collectionView];
	
	self.collumnsPadding = 0.0;
}


- (void)setContentOffset:(CGPoint)contentOffset
{
	if (self.collectionView.contentSize.width > self.collectionView.bounds.size.width)
	{
		self.collectionView.contentOffset = contentOffset;
	}
}


- (CGPoint)contentOffset
{
	return self.collectionView.contentOffset;
}


- (void)setShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator
{
	self.collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
}


- (BOOL)showsHorizontalScrollIndicator
{
	return self.collectionView.showsHorizontalScrollIndicator;
}


- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator
{
	self.collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
}


- (BOOL)showsVerticalScrollIndicator
{
	return self.collectionView.showsVerticalScrollIndicator;
}


- (void)setClipsToBounds:(BOOL)clipsToBounds
{
	self.collectionView.clipsToBounds = clipsToBounds;
}


- (BOOL)clipsToBounds
{
	return self.collectionView.clipsToBounds;
}


- (void)setCollumnsPadding:(CGFloat)collumnsPadding
{
	_collumnsPadding = collumnsPadding;
	
	_flowLayout.minimumInteritemSpacing = collumnsPadding;
}


- (void)registerNib:(UINib*)nib forCellReuseIdentifier:(NSString *)identifier
{
	[_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}


- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
	[_collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}


- (void)setContentInset:(UIEdgeInsets)contentInset
{
	_contentInset = contentInset;
	
	self.collectionView.contentInset = contentInset;
}


- (id)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forCollumnIndex:(NSUInteger)index
{
	id cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[self _indexPathFromCollumnIndex:index]];
	return cell;
}


- (void)reloadData
{
	[self.collectionView reloadData];
}


- (void)willMoveToWindow:(UIWindow *)newWindow
{
	[super willMoveToWindow:newWindow];
	
	if (newWindow && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
	{
		[self.collectionView reloadData];
	}
}


//cells
- (NSIndexSet*)indexesForSelectedCollumns
{
	NSArray* indexPaths = [self.collectionView indexPathsForSelectedItems];
	NSMutableIndexSet* indexes = [[NSMutableIndexSet alloc] init];
	[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath* indexPath, NSUInteger idx, BOOL *stop) {
		NSUInteger index = [self _collumnIndexFromIndexPath:indexPath];
		[indexes addIndex:index];
	}];
	
	return indexes;
}


- (NSIndexSet*)indexesForVisibleCollumns
{
	NSArray* indexPaths = [self.collectionView indexPathsForVisibleItems];
	NSMutableIndexSet* indexes = [[NSMutableIndexSet alloc] init];
	[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath* indexPath, NSUInteger idx, BOOL *stop) {
		NSUInteger index = [self _collumnIndexFromIndexPath:indexPath];
		[indexes addIndex:index];
	}];
	
	return indexes;
}


- (UICollectionViewCell*)cellForCollumnAtIndex:(NSUInteger)collumnIndex
{
	NSIndexPath* indexPath = [self _indexPathFromCollumnIndex:collumnIndex];
	UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
	
	return cell;
}


- (void)selectCollumnAtIndex:(NSUInteger)collumnIndex animated:(BOOL)animated scrollPostion:(FAHorizontalViewScrollPosition)position
{
	NSIndexPath* indexPath = [self _indexPathFromCollumnIndex:collumnIndex];
	UICollectionViewScrollPosition scrollPosition = [self _collectionViewScrollPostionFromHorizontalViewScrollPosition:position];
	[self.collectionView selectItemAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
}


- (void)deselectCollumnAtIndex:(NSUInteger)collumnIndex animated:(BOOL)animated
{
	NSIndexPath* indexPath = [self _indexPathFromCollumnIndex:collumnIndex];
	[self.collectionView deselectItemAtIndexPath:indexPath animated:animated];
}


- (void)scrollToCollumnAtIndex:(NSUInteger)collumnIndex scrollPosition:(FAHorizontalViewScrollPosition)position animated:(BOOL)animated
{
	NSIndexPath* indexPath = [self _indexPathFromCollumnIndex:collumnIndex];
	UICollectionViewScrollPosition scrollPosition = [self _collectionViewScrollPostionFromHorizontalViewScrollPosition:position];
	[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}


- (void)scrollToVisibleCollumnAtIndex:(NSUInteger)collumnIndex scrollPosition:(FAHorizontalViewScrollPosition)position animated:(BOOL)animated
{
	/*
	 Метод скролирует только если столбец частично или полность не виден, до "if" идёт вычисление видимой рамки.
	*/
	NSIndexPath* indexPath = [self _indexPathFromCollumnIndex:collumnIndex];
	UICollectionViewLayoutAttributes* collumnAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
	CGRect collumnRect = collumnAttributes.frame;
	CGRect intersect = CGRectIntersection(self.collectionView.bounds, collumnRect);
	if (!CGSizeEqualToSize(intersect.size, collumnRect.size))
	{
		[self scrollToCollumnAtIndex:collumnIndex scrollPosition:position animated:animated];
	}
}


- (CGSize)contentSize
{
	return self.collectionView.contentSize;
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	NSInteger number = 0;
	if (self.dataSource)
	{
		number = [self.dataSource faHorizontalViewCountCollumns:self];
	}
	
	return number;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell* cell = [self.dataSource faHorizontalView:self viewForCollumn:[self _collumnIndexFromIndexPath:indexPath]];
	return cell;
}


#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[self.delegate faHorizontalView:self selectedCollumn:[self _collumnIndexFromIndexPath:indexPath]];
}


#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat width = [self.dataSource faHorizontalView:self widthForCollumn:[self _collumnIndexFromIndexPath:indexPath]];
	CGSize size = CGSizeMake(width, self.bounds.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom);
	return size;
}


- (void)dealloc
{
	_collectionView.delegate = nil;
	_collectionView.dataSource = nil;
}

@end


#pragma mark -
@implementation FAHorizontalView (Private)

- (NSIndexPath*)_indexPathFromCollumnIndex:(NSUInteger)collumnIndex
{
	NSIndexPath* indexPath = [NSIndexPath indexPathForItem:collumnIndex inSection:0];
	return indexPath;
}


- (NSUInteger)_collumnIndexFromIndexPath:(NSIndexPath*)indexPath
{
	return indexPath.item;
}


- (UICollectionViewScrollPosition)_collectionViewScrollPostionFromHorizontalViewScrollPosition:(FAHorizontalViewScrollPosition)horScrollPosition
{
	UICollectionViewScrollPosition scrollPosition = UICollectionViewScrollPositionNone;
	switch (horScrollPosition)
	{
  case FAHorizontalViewScrollPositionNone:
			scrollPosition = UICollectionViewScrollPositionNone;
			break;
		case FAHorizontalViewScrollPositionCenteredHorizontally:
			scrollPosition = UICollectionViewScrollPositionCenteredHorizontally;
			break;
		case FAHorizontalViewScrollPositionLeft:
			scrollPosition = UICollectionViewScrollPositionLeft;
			break;
		case FAHorizontalViewScrollPositionRight:
			scrollPosition = UICollectionViewScrollPositionRight;
			break;
		default:
		{
			NSAssert(NO, @"Unknown position");
		}
			break;
	}
	
	return scrollPosition;
}

@end
