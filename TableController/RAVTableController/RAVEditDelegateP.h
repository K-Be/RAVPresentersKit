//
//  RAVEditDelegateP.h
//  TableController
//
//  Created by Andrew Romanov on 23.04.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RAVTableController;
@protocol RAVEditDelegateP <NSObject>

- (BOOL)ravTableController:(RAVTableController*)sender canEditRowAtIndexPath:(NSIndexPath*)indexPath;
- (BOOL)ravTableController:(RAVTableController*)sender canMoveRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)ravTableController:(RAVTableController*)sender commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)ravTableController:(RAVTableController*)sender moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end
