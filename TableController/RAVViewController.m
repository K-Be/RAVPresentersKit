//
//  RAVViewController.m
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVViewController.h"
#import "RAVTableController.h"
#import "RAVPetPresenter.h"
#import "RAVPersonPresenter.h"
#import "RAVExampleDataSource.h"


@interface RAVViewController ()

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* reloadButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* startEditButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* endEditButton;
@property (nonatomic, strong) RAVExampleDataSource* dataSource;
@property (nonatomic, strong) RAVTableController* tableController;

- (IBAction)reloadAction:(id)action;
- (IBAction)startEditAction:(id)sender;
- (IBAction)endEditAction:(id)sender;

@end


@interface RAVViewController (Private)

- (void)updateRightNavButtons;
- (NSArray*)navButtons;

@end


@implementation RAVViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		self.tableController = [[RAVTableController alloc] init];
		
		[self.tableController registerCellPresenter:[[RAVPetPresenter alloc] init]];
		[self.tableController registerCellPresenter:[[RAVPersonPresenter alloc] init]];
		
		self.dataSource = [[RAVExampleDataSource alloc] init];
		self.tableController.editDelegate = self.dataSource;
	}
	
	return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self updateRightNavButtons];
	
	self.tableController.tableView = self.tableView;
	self.tableController.model = [[self dataSource] getListModel];
}



#pragma mark Actions
- (void)reloadAction:(id)action
{
	[[self dataSource] reloadModel];
	self.tableController.model = [[self dataSource] getListModel];
}


- (IBAction)startEditAction:(id)sender
{
	[self.tableView setEditing:YES animated:YES];
	[self updateRightNavButtons];
}


- (IBAction)endEditAction:(id)sender
{
	[self.tableView setEditing:NO animated:YES];
	[self updateRightNavButtons];
}

@end


#pragma mark -
@implementation RAVViewController (Private)

- (void)updateRightNavButtons
{
	self.navigationItem.rightBarButtonItems = [self navButtons];
}


- (NSArray*)navButtons
{
	NSArray* items = nil;
	if (self.tableView.isEditing)
	{
		items = @[self.endEditButton];
	}
	else
	{
		items = @[self.reloadButton, self.startEditButton];
	}
	
	return items;
}

@end
