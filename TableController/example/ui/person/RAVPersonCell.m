//
//  RAVPersonCell.m
//  TableController
//
//  Created by Andrew Romanov on 24.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVPersonCell.h"


@interface RAVPersonCell ()

@property (nonatomic, strong) IBOutlet UILabel* firstNameLabel;
@property (nonatomic, strong) IBOutlet UILabel* secondNameLabel;
@property (nonatomic, strong) IBOutlet UILabel* ageLabel;

@end


@implementation RAVPersonCell


- (void)setPerson:(RAVPersonModel *)person
{
	_person = person;
	
	self.firstNameLabel.text = person.name;
	self.secondNameLabel.text = person.secondName;
	self.ageLabel.text = [person.age description];
}

@end
