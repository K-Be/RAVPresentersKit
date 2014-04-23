//
//  RAVTableController.m
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "RAVTableController.h"


@interface RAVTableController ()

@property (nonatomic, strong) NSMutableArray* cellsPresenters;
@property (nonatomic, strong) NSMutableArray* sectionHeadersPresenters;
@property (nonatomic, strong) NSMutableArray* sectionFooterPresenters;

@end


@interface RAVTableController (rav_private)

- (RAVCellPresenter*)rav_cellPresenterForDataModel:(id)dataModel;

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


- (void)registerCellPresenter:(RAVCellPresenter*)cellPresenter
{
	[self.cellsPresenters addObject:cellPresenter];
	cellPresenter.tableView = self.tableView;
}


- (void)registerSectionHeaderPresenter:(RAVSectionHeaderViewPresenter*)sectionHeaderPresenter
{
	[self.sectionHeadersPresenters addObject:sectionHeaderPresenter];
	sectionHeaderPresenter.tableView = self.tableView;
}


- (void)registerSectionFooterPreseter:(RAVSectionFooterViewPresenter*)sectionFooterPresenter
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
	id dataModel = [self.model getModelForIndexPath:indexPath];
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

@end


#pragma mark -
@implementation RAVTableController (rav_private)

- (RAVCellPresenter*)rav_cellPresenterForDataModel:(id)dataModel
{
	NSInteger presenterIndex = [self.cellsPresenters indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		id<RAVPresenterP> presenter = obj;
		BOOL requiredObject = [presenter canPresent:dataModel];
		return requiredObject;
	}];
	
	RAVCellPresenter* presenter = nil;
	if (presenterIndex != NSNotFound)
	{
		presenter = [self.cellsPresenters objectAtIndex:presenterIndex];
	}
	NSAssert(presenter != nil, @"can't find presenter for model: %@", dataModel);
	
	return presenter;
}

@end
