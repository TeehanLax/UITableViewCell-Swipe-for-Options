//
//  TLMasterViewController.m
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLTableViewController.h"

#import "TLSwipeForOptionsCell.h"
#import "TLContainerViewController.h"

@interface TLTableViewController () <TLSwipeForOptionsCellDelegate, UIActionSheetDelegate> {
    NSMutableArray *_objects;
}

// We need to keep track of the most recently selected cell for the action sheet.
@property (nonatomic, weak) UITableViewCell *mostRecentlySelectedMoreCell;

@end

@implementation TLTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    // Need to do this to keep the view in a consistent state (layoutSubviews in the cell expects itself to be "closed")
    [[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification object:self.tableView];
}

#pragma mark - Public Methods

// Method to delete the cells that are currently selected.
- (void)deleteSelectedCells {
    NSArray *indexPathsOfSelectedCells = [self.tableView indexPathsForSelectedRows];

    // MUST be enumerated in reverse order otherwise the _objects indices become invalid.
    [indexPathsOfSelectedCells enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL *stop) {
        [_objects removeObjectAtIndex:obj.row];
    }];
    
    [self.tableView deleteRowsAtIndexPaths:indexPathsOfSelectedCells withRowAnimation:UITableViewRowAnimationAutomatic];
}

// Inserts a new object into the _objects array.
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // Need to call this whenever we scroll our table view programmatically
    [[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification object:self.tableView];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSwipeForOptionsCell *cell = (TLSwipeForOptionsCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    cell.delegate = self;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.delegate tableViewController:self didChangeEditing:editing];
}

#pragma UIScrollViewDelegate Methods 

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification object:scrollView];
}

#pragma mark - TLSwipeForOptionsCellDelegate Methods 

-(void)cellDidSelectDelete:(TLSwipeForOptionsCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    [_objects removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)cellDidSelectMore:(TLSwipeForOptionsCell *)cell {
    self.mostRecentlySelectedMoreCell = cell;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Flag", @"Mark as Unread", @"Move to Junk", @"Move Messages...", nil];
    [self.delegate presentActionSheet:actionSheet fromViewController:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        //nop
    }
    else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:self.mostRecentlySelectedMoreCell];
        
        [_objects removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification object:self.tableView];
    }
}

@end
