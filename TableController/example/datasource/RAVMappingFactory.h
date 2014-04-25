//
//  RAVMappingFactory.h
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyMapping.h"
#import "RAVPetModel.h"
#import "RAVPersonModel.h"


@interface RAVMappingFactory : NSObject

+ (EKObjectMapping*)mappingForClass:(Class)objectClass;

@end
