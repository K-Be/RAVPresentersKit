//
//  RAVTableController.m
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableController.h"
#import "RAVTableController_Subclassing.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


typedef id RAVCellModel;
typedef id RAVSectionHeaderViewModel;
typedef id RAVSectionFooterViewModel;


@interface RAVTableController ()

@property (nonatomic, strong) NSMutableArray* cellsPresenters;
@property (nonatomic, strong) NSMutableArray* sectionHeadersPresenters;
@property (nonatomic, strong) NSMutableArray* sectionFooterPresenters;

@end


@interface RAVTableController (rav_protected)

- (RavCellPresenterType*)rav_cellPresenterForDataModel:(RAVCellModel)dataModel;
- (RAVSectionFooterViewPresenterType*)rav_sectionFooterPresenterForSectionDataModel:(RAVSectionFooterViewModel)dataModel;
- (RAVSectionHeaderViewPresenterType*)rav_sectionHeaderPresenterForSectionDataModel:(RAVSectionHeaderViewModel)dataModel;

@end


@interface RAVTableController (rav_private)

- (id<RAVPresenterP>)rav_findPresenterForModel:(id)model inList:(NSArray*)presentersList;
- (RAVSectionHeaderViewModel)rav_getHeaderSectionViewModelForSection:(NSInteger)section;
- (RAVSectionFooterViewModel)rav_getFooterSectionViewModelForSection:(NSInteger)section;
- (RAVCellModel)rav_getCellModelForIndexPath:(NSIndexPath*)indexPath;

- (UIView*)rav_emptySectionView;

@end


@implementation RAVTableController

- (id)init
{
	if (self = [super init])
	{
		self.cellsPresenters = [[NSMutableArray alloc] init];
		self.sectionHeadersPresenters = [[NSMutableArray alloc] init];
		self.sectionFooterPresenters = [[NSMutableArray alloc] init];
	}
	
	return self;
}


- (void)reloadData
{
	if (self.tableView != nil && self.tableView.dataSource == self)
	{
		[self.tableView reloadData];
	}
}


- (void)registerCellPresenter:(RAVCellPresenter*)cellPresenter
{
	[self.cellsPresenters addObject:cellPresenter];
	cellPresenter.tableView = self.tableView;
}


- (void)registerSectionHeaderPresenter:(RAVSectionHeaderViewPresenterType*)sectionHeaderPresenter
{
	[self.sectionHeadersPresenters addObject:sectionHeaderPresenter];
	sectionHeaderPresenter.tableView = self.tableView;
}


- (void)registerSectionFooterPreseter:(RAVSectionFooterViewPresenterType*)sectionFooterPresenter
{
	[self.sectionFooterPresenters addObject:sectionFooterPresenter];
	sectionFooterPresenter.tableView = self.tableView;
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	RAVTableControllerSectionModel* sectionModel = [self.model sectionModelForSectionIndex:section];
	NSInteger count = [sectionModel.models count];
	return count;
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	RAVCellModel dataModel = [self rav_getCellModelForIndexPath:indexPath];
	RAVCellPresenter* cellPresenter = [self rav_cellPresenterForDataModel:dataModel];
	UITableViewCell* cell = [cellPresenter cellForModel:dataModel];
	if (!cell)
	{
		NSAssert(NO, @"can't create cell for model %@ , presenter: %@", dataModel, cellPresenter);
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rav_stubCell"];
	}
	
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger count = 1;
	if ([self.model.sectionModels count] > 0)
	{
		count = [self.model.sectionModels count];
	}
	
	return count;
}


// Editing
// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL can = NO;
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:canEditRowAtIndexPath:)])
	{
		can = [self.editDelegate ravTableController:self canEditRowAtIndexPath:indexPath];
	}
	
	return can;
}


// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL can = NO;
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:canMoveRowAtIndexPath:)])
	{
		can = [self.editDelegate ravTableController:self canMoveRowAtIndexPath:indexPath];
	}
	
	return can;
}

// Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
{
	NSArray* indexes = nil;
	
	if ([self.sectionIndexesDelegate respondsToSelector:@selector(ravTableControllerSectionIndexTitles:)])
	{
		indexes = [self.sectionIndexesDelegate ravTableControllerSectionIndexTitles:self];
	}
	
	return indexes;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index  // tell table which section corresponds to section title/index (e.g. "B",1))
{
	NSInteger sectionIndex = index;
	if ([self.sectionIndexesDelegate respondsToSelector:@selector(ravTableController:sectionForSectionIndexTitle:atIndex:)])
	{
		sectionIndex = [self.sectionIndexesDelegate ravTableController:self sectionForSectionIndexTitle:title atIndex:index];
	}
	
	return sectionIndex;
}


// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:commitEditingStyle:forRowAtIndexPath:)])
	{
		[self.editDelegate ravTableController:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
	}
}

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:moveRowAtIndexPath:toIndexPath:)])
	{
		[self.editDelegate ravTableController:self moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
	}
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	RAVCellModel cellModel = [self rav_getCellModelForIndexPath:indexPath];
	RavCellPresenterType* presenter = [self rav_cellPresenterForDataModel:cellModel];
	if ([presenter respondsToSelector:@selector(ravTableController:willDisplayModel:withIndexPath:)])
	{
		[presenter ravTableController:self willDisplayModel:cellModel withIndexPath:indexPath];
	}
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = self.tableView.rowHeight;
	
	RAVCellModel cellModel = [self rav_getCellModelForIndexPath:indexPath];
	RavCellPresenterType* presenter = [self rav_cellPresenterForDataModel:cellModel];
	if ([presenter respondsToSelector:@selector(ravTableController:rowHeightForModel:)])
	{
		height = [presenter ravTableController:self rowHeightForModel:cellModel];
	}
	
	return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	CGFloat height = self.tableView.sectionHeaderHeight;
	RAVSectionHeaderViewModel model = [self rav_getHeaderSectionViewModelForSection:section];
	RAVSectionHeaderViewPresenter* presenter = [self rav_sectionHeaderPresenterForSectionDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:sectionViewHeightForModel:)])
	{
		height = [presenter ravTableController:self sectionViewHeightForModel:model];
	}
	
	return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	CGFloat height = self.tableView.sectionFooterHeight;
	RAVSectionFooterViewModel model = [self rav_getFooterSectionViewModelForSection:section];
	RAVSectionFooterViewPresenter* presenter = [self rav_sectionFooterPresenterForSectionDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:sectionViewHeightForModel:)])
	{
		height = [presenter ravTableController:self sectionViewHeightForModel:model];
	}
	
	return height;
}


// Section header & footer information. Views are preferred over title should you decide to provide both
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	RAVSectionHeaderViewModel model = [self rav_getHeaderSectionViewModelForSection:section];
	UIView* view = nil;
	RAVSectionHeaderViewPresenterType* presenter = [self rav_sectionHeaderPresenterForSectionDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:sectionViewForModel:)])
	{
		view = [presenter ravTableController:self sectionViewForModel:model];
	}
	if (!view)
	{
		view = [self rav_emptySectionView];
	}
	
	return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	RAVSectionFooterViewModel model = [self rav_getFooterSectionViewModelForSection:section];
	UIView* view = nil;
	RAVSectionFooterViewPresenter* presenter = [self rav_sectionFooterPresenterForSectionDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:sectionViewForModel:)])
	{
		view = [presenter ravTableController:self sectionViewForModel:model];
	}
	
	return view;
}


// Accessories (disclosures).
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	RAVCellModel model = [self rav_getCellModelForIndexPath:indexPath];
	RavCellPresenterType* presenter = [self rav_cellPresenterForDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:accessoryButtonPressedForModel:)])
	{
		[presenter ravTableController:self accessoryButtonPressedForModel:model];
	}
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RAVCellModel model = [self rav_getCellModelForIndexPath:indexPath];
	RAVCellPresenter* presenter = [self rav_cellPresenterForDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:didSelectModel:needsDeselect:animated:)])
	{
		BOOL shouldDeselect = NO;
		BOOL animated = NO;
		[presenter ravTableController:self didSelectModel:model needsDeselect:&shouldDeselect animated:&animated];
		if (shouldDeselect)
		{
			[self.tableView deselectRowAtIndexPath:indexPath animated:animated];
		}
	}
}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellEditingStyle editStyle = UITableViewCellEditingStyleDelete;
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:editingStyleForRowAtIndexPath:)])
	{
		editStyle = [self.editDelegate ravTableController:self editingStyleForRowAtIndexPath:indexPath];
	}
	
	return editStyle;
}


// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL intend = YES;
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:shouldIndentWhileEditingRowAtIndexPath:)])
	{
		intend = [self.editDelegate ravTableController:self shouldIndentWhileEditingRowAtIndexPath:indexPath];
	}
	
	return intend;
}


// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:willBeginEditingRowAtIndexPath:)])
	{
		[self.editDelegate ravTableController:self willBeginEditingRowAtIndexPath:indexPath];
	}
}


- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:didEndEditingRowAtIndexPath:)])
	{
		[self.editDelegate ravTableController:self didEndEditingRowAtIndexPath:indexPath];
	}
}



// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	NSIndexPath* result = proposedDestinationIndexPath;
	if ([self.editDelegate respondsToSelector:@selector(ravTableController:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)])
	{
		result = [self.editDelegate ravTableController:self targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
	}
	
	return result;
}


// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL should = NO;
	RAVCellModel model = [self rav_getCellModelForIndexPath:indexPath];
	RavCellPresenterType* presenter = [self rav_cellPresenterForDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:shouldShowMenuForModel:)])
	{
		should = [presenter ravTableController:self shouldShowMenuForModel:model];
	}
	
	return should;
}


- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	BOOL can = NO;
	RAVCellModel model = [self rav_getCellModelForIndexPath:indexPath];
	RavCellPresenterType* presenter = [self rav_cellPresenterForDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:canPerformAction:forModel:withActionSender:)])
	{
		can = [presenter ravTableController:self canPerformAction:action forModel:model withActionSender:sender];
	}
	
	return can;
}


- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	RAVCellModel model = [self rav_getCellModelForIndexPath:indexPath];
	RavCellPresenterType* presenter = [self rav_cellPresenterForDataModel:model];
	if ([presenter respondsToSelector:@selector(ravTableController:performAction:forModel:withActionSender:)])
	{
		[presenter ravTableController:self performAction:action forModel:model withActionSender:sender];
	}
	else
	{
		NSAssert(NO, @"presenter %@, should implement method %@", [presenter description], NSStringFromSelector(@selector(ravTableController:performAction:forModel:withActionSender:)));
	}
}


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewDidScroll:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewDidScroll:self];
	}
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewDidZoom:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewDidZoom:self];
	}
}


// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewWillBeginDragging:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewWillBeginDragging:self];
	}
}


// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewWillEndDragging:withVelocity:targetContentOffset:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewWillEndDragging:self withVelocity:velocity targetContentOffset:targetContentOffset];
	}
}


// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewDidEndDragging:willDecelerate:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewDidEndDragging:self willDecelerate:decelerate];
	}
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewWillBeginDecelerating:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewWillBeginDecelerating:self];
	}
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewDidEndDecelerating:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewDidEndDecelerating:self];
	}
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewDidEndScrollingAnimation:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewDidEndScrollingAnimation:self];
	}
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	UIView* view = nil;
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerViewForZoomingInScrollView:)])
	{
		view = [self.scrollViewDelegate ravTableControllerViewForZoomingInScrollView:self];
	}
	
	return view;
}


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewWillBeginZooming:withView:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewWillBeginZooming:self withView:view];
	}
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewDidEndZooming:withView:atScale:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewDidEndZooming:self withView:view atScale:scale];
	}
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	BOOL should = [scrollView scrollsToTop];
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewShouldScrollToTop:)])
	{
		should = [self.scrollViewDelegate ravTableControllerScrollViewShouldScrollToTop:self];
	}
	
	return should;
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
	if ([self.scrollViewDelegate respondsToSelector:@selector(ravTableControllerScrollViewDidScrollToTop:)])
	{
		[self.scrollViewDelegate ravTableControllerScrollViewDidScrollToTop:self];
	}
}


- (void)dealloc
{
	if (self.tableView.delegate == self)
	{
		self.tableView.delegate = nil;
	}
	if (self.tableView.dataSource == self)
	{
		self.tableView.dataSource = nil;
	}
}

@end


#pragma mark -
@implementation RAVTableController (rav_protected)

- (RavCellPresenterType*)rav_cellPresenterForDataModel:(RAVCellModel)dataModel
{
	RavCellPresenterType* presenter = (RavCellPresenterType*)[self rav_findPresenterForModel:dataModel inList:self.cellsPresenters];
	return presenter;
}


- (RAVSectionFooterViewPresenterType*)rav_sectionFooterPresenterForSectionDataModel:(RAVSectionFooterViewModel)dataModel
{
	RAVSectionFooterViewPresenterType* presenter = (RAVSectionFooterViewPresenterType*)[self rav_findPresenterForModel:dataModel inList:self.sectionFooterPresenters];
	return presenter;
}


- (RAVSectionHeaderViewPresenterType*)rav_sectionHeaderPresenterForSectionDataModel:(RAVSectionHeaderViewModel)dataModel
{
	RAVSectionHeaderViewPresenterType* presenter = (RAVSectionHeaderViewPresenterType*)[self rav_findPresenterForModel:dataModel inList:self.sectionHeadersPresenters];
	return presenter;
}

@end


#pragma mark -
@implementation RAVTableController (rav_private)

- (id<RAVPresenterP>)rav_findPresenterForModel:(id)model inList:(NSArray*)presentersList
{
	id<RAVPresenterP> presenter = nil;
	
	if (model)
	{
		NSInteger presenterIndex = [self.cellsPresenters indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
			id<RAVPresenterP> presenter = obj;
			BOOL requiredObject = [presenter canPresent:model];
			return requiredObject;
		}];
		
		if (presenterIndex != NSNotFound)
		{
			presenter = [self.cellsPresenters objectAtIndex:presenterIndex];
		}
		NSAssert(presenter != nil, @"can't find presenter for model: %@", model);
	}
	
	return presenter;
}


- (RAVSectionHeaderViewModel)rav_getHeaderSectionViewModelForSection:(NSInteger)section
{
	RAVTableControllerSectionModel* sectionModel = [self.model sectionModelForSectionIndex:section];
	return sectionModel.headerViewModel;
}


- (RAVSectionFooterViewModel)rav_getFooterSectionViewModelForSection:(NSInteger)section
{
	RAVTableControllerSectionModel* sectionModel = [self.model sectionModelForSectionIndex:section];
	return sectionModel.footerViewModel;
}


- (RAVCellModel)rav_getCellModelForIndexPath:(NSIndexPath*)indexPath
{
	RAVCellModel model = [self.model getModelForIndexPath:indexPath];
	return model;
}


- (UIView*)rav_emptySectionView
{
	UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
	view.userInteractionEnabled = NO;
	view.backgroundColor = [UIColor clearColor];
	
	return view;
}

@end
