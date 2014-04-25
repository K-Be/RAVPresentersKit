//
//  RAVMappingFactory.m
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVMappingFactory.h"


@interface RAVMappingFactory (Private)

+ (EKObjectMapping*)_mappingForPetModel;
+ (EKObjectMapping*)_mappingForPersonModel;

@end


@implementation RAVMappingFactory

+ (EKObjectMapping*)mappingForClass:(Class)objectClass
{
	EKObjectMapping* mapping = nil;
	if (objectClass == [RAVPetModel class])
	{
		mapping = [self _mappingForPetModel];
	}
	else if (objectClass == [RAVPersonModel class])
	{
		mapping = [self _mappingForPersonModel];
	}
	
	return mapping;
}

@end


#pragma mark -
@implementation RAVMappingFactory (Private)

+ (EKObjectMapping*)_mappingForPetModel
{
	EKObjectMapping* map = [EKObjectMapping mappingForClass:[RAVPetModel class]
																 withBlock:^(EKObjectMapping *mapping) {
																	 NSDictionary* redirection = @{@"Name": @"name"};
																	 [mapping mapFieldsFromDictionary:redirection];
																 }];
	return map;
}


+ (EKObjectMapping*)_mappingForPersonModel
{
	EKObjectMapping* map = [EKObjectMapping mappingForClass:[RAVPersonModel class]
																 withBlock:^(EKObjectMapping *mapping) {
																	 NSDictionary* redirection = @{@"Name": @"name",
																											 @"Second Name": @"secondName",
																											 @"Age": @"age"};
																	 [mapping mapFieldsFromDictionary:redirection];
																 }];
	return map;
}

@end