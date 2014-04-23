//
//  RAVTableControllerSectionModel.h
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAVTableControllerSectionModel : NSObject <NSCopying>

@property (nonatomic, strong) id headerViewModel;
@property (nonatomic, strong) id footerViewModel;
@property (nonatomic, strong, readonly) NSMutableArray* models;//some objects for draw

@end
