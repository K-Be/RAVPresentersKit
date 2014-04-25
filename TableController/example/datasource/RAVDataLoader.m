//
//  RAVDataLoader.m
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVDataLoader.h"
#import "RAVMappingFactory.h"

#import "RAVPetModel.h"
#import "RAVPersonModel.h"


@interface RAVDataLoader (Private)

- (NSArray*)loadRepresentationListFromList:(NSString*)plistName andKey:(NSString*)key;
- (NSArray*)dataModelsWithRepresentation:(NSArray*)representation mapping:(EKObjectMapping*)mapping;

@end


@implementation RAVDataLoader

- (NSArray*)loadPets
{
	NSArray* representations = [self loadRepresentationListFromList:@"Pets" andKey:@"Pets"];
	NSArray* models = [self dataModelsWithRepresentation:representations mapping:[RAVMappingFactory mappingForClass:[RAVPetModel class]]];
	return models;
}


- (NSArray*)loadHumans
{
	NSArray* representations = [self loadRepresentationListFromList:@"Persons" andKey:@"Persons"];
	NSArray* models = [self dataModelsWithRepresentation:representations mapping:[RAVMappingFactory mappingForClass:[RAVPersonModel class]]];
	return models;
}

@end


#pragma mark -
@implementation RAVDataLoader (Private)

- (NSArray*)loadRepresentationListFromList:(NSString*)plistName andKey:(NSString*)key
{
	NSString* path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
	NSInputStream* stream = [NSInputStream inputStreamWithFileAtPath:path];
	[stream open];
	NSDictionary* plist = [NSPropertyListSerialization propertyListWithStream:stream
																							options:0
																							 format:NULL
																							  error:NULL];
	NSArray* representations = [plist objectForKey:key];
	return representations;
}


- (NSArray*)dataModelsWithRepresentation:(NSArray*)representation mapping:(EKObjectMapping*)mapping
{
	NSArray* objects = [EKMapper arrayOfObjectsFromExternalRepresentation:representation withMapping:mapping];
	return objects;
}

@end
