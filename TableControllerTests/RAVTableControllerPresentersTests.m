//
//  RAVTableControllerPresentersTests.m
//  TableController
//
//  Created by Andrew Romanov on 02.07.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RAVTableController.h"
#import "RAVTableController_Subclassing.h"

#import "TCTPresenter.h"
#import "TCTViewPresenter.h"

#import "TCTCellModel.h"
#import "TCTViewModel.h"

@interface RAVTableControllerPresentersTests : XCTestCase

@property (nonatomic, strong) RAVTableController* tableController;

@property (nonatomic, strong) TCTPresenter* cellPresenter;
@property (nonatomic, strong) TCTViewPresenter* headerViewPresenter;
@property (nonatomic, strong) TCTViewPresenter* footerViewPresenter;

@end

@implementation RAVTableControllerPresentersTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	
	_tableController = [[RAVTableController alloc] init];
	_cellPresenter = [[TCTPresenter alloc] init];
	[_tableController registerCellPresenter:_cellPresenter];
	_headerViewPresenter = [[TCTViewPresenter alloc] init];
	[_tableController registerSectionHeaderPresenter:_headerViewPresenter];
	_footerViewPresenter = [[TCTViewPresenter alloc] init];
	[_tableController registerSectionFooterPresenter:_footerViewPresenter];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCellPresenters
{
	XCTAssertTrue([_tableController rav_cellPresenterForDataModel:[TCTCellModel new]] == _cellPresenter, @"shold be equal");
}


- (void)testHeaderPresenter
{
	XCTAssertTrue([_tableController rav_sectionHeaderPresenterForSectionDataModel:[TCTViewModel new]] == _headerViewPresenter, @"should be equal");
}


- (void)testFooterPresenter
{
	XCTAssertTrue([_tableController rav_sectionFooterPresenterForSectionDataModel:[TCTViewModel new]] == _footerViewPresenter, @"should be equal");
}

@end
