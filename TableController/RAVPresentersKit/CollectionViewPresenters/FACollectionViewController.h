//
//  FACollectionViewController.h
//  RAVPresentersKit
//
//  Created by Andrew Romanov on 30.10.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FACollectionViewPresenter.h"
#import "RAVTableControllerListModelP.h"


@interface FACollectionViewController : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readonly) UICollectionView* collectionView;
@property (nonatomic, strong, readonly) UICollectionViewFlowLayout* flowLayout;

@property (nonatomic, strong) id<RAVTableControllerListModelP> model;

- (void)setCollectionView:(UICollectionView *)collectionView flowLayout:(UICollectionViewFlowLayout*)flowLayout;
- (void)registerPresenter:(FACollectionViewPresenter*)presenter;

@end
