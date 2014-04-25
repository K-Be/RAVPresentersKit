//
//  RAVPetPresenter.h
//  TableController
//
//  Created by Andrew Romanov on 25.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVCellPresenter.h"
#import "RAVPetModel.h"



@protocol RAVPetPresenterDelegate;
@interface RAVPetPresenter : RAVCellPresenter

@property (nonatomic, weak) id<RAVPetPresenterDelegate> delegate;

@end


@protocol RAVPetPresenterDelegate <NSObject>

- (void)ravPetPresenter:(RAVPetPresenter*)sender selectedPet:(RAVPetModel*)pet;

@end


