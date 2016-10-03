//
//  FAHorizontalView.h
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 28.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "FAViewBase.h"


typedef NS_OPTIONS(NSUInteger, FAHorizontalViewScrollPosition) {
	FAHorizontalViewScrollPositionNone                 = 0,
	
	// Likewise, the horizontal positions are mutually exclusive to each other.
	FAHorizontalViewScrollPositionLeft                 = 1 << 3,
	FAHorizontalViewScrollPositionCenteredHorizontally = 1 << 4,
	FAHorizontalViewScrollPositionRight 					= 1 << 5
};


@protocol FAHorizontalViewDataSource;
@protocol FAHorizontalViewDelegate;
@interface FAHorizontalView : FAViewBase

@property (nonatomic, weak) id<FAHorizontalViewDataSource> dataSource;
@property (nonatomic, weak) id<FAHorizontalViewDelegate> delegate;
@property (nonatomic) CGFloat collumnsPadding;
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic) CGPoint contentOffset;
@property (nonatomic) BOOL showsHorizontalScrollIndicator;
@property (nonatomic) BOOL showsVerticalScrollIndicator;
@property (nonatomic) BOOL clipsToBounds;


- (void)registerNib:(UINib*)nib forCellReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

- (id)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forCollumnIndex:(NSUInteger)index;
- (void)reloadData;

- (NSIndexSet*)indexesForSelectedCollumns;
- (NSIndexSet*)indexesForVisibleCollumns;
- (UICollectionViewCell*)cellForCollumnAtIndex:(NSUInteger)collumnIndex;
- (void)selectCollumnAtIndex:(NSUInteger)collumnIndex animated:(BOOL)animated scrollPostion:(FAHorizontalViewScrollPosition)position;
- (void)deselectCollumnAtIndex:(NSUInteger)collumnIndex animated:(BOOL)animated;

- (void)scrollToCollumnAtIndex:(NSUInteger)collumnIndex scrollPosition:(FAHorizontalViewScrollPosition)position animated:(BOOL)animated;
- (void)scrollToVisibleCollumnAtIndex:(NSUInteger)collumnIndex scrollPosition:(FAHorizontalViewScrollPosition)position animated:(BOOL)animated;

- (CGSize)contentSize;

@end


@protocol FAHorizontalViewDataSource <NSObject>

- (NSUInteger)faHorizontalViewCountCollumns:(FAHorizontalView*)sender;
- (UICollectionViewCell*)faHorizontalView:(FAHorizontalView*)sender viewForCollumn:(NSUInteger)collumnIndex;

- (CGFloat)faHorizontalView:(FAHorizontalView*)sender widthForCollumn:(NSUInteger)collumnIndex;

@end


@protocol FAHorizontalViewDelegate <NSObject>

- (void)faHorizontalView:(FAHorizontalView*)sender selectedCollumn:(NSUInteger)collumnIndex;

@end

