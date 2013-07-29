//
//  TLMasterViewController.m
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLMasterViewController.h"

#import "TLSwipeForOptionsCell.h"

@interface TLMasterViewController () <TLSwipeForOptionsCellDelegate, UIActionSheetDelegate> {
    NSMutableArray *_objects;
}

@property (nonatomic, weak) UITableViewCell *mostRecentlySelectedMoreCell;

@end

@implementation TLMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Some other action", nil];
    [actionSheet showInView:self.view];
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
        NSLog(@"Perform some other action.");
    }
}

@end
