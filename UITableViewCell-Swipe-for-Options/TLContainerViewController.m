//
//  TLContainerViewController.m
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLContainerViewController.h"

#import "TLTableViewController.h"

@interface TLContainerViewController () <TLTableViewControllerDelegate>

@property (nonatomic, weak) TLTableViewController *tableViewController;
@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;

@end

@implementation TLContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.tableViewController.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.tableViewController.navigationItem.rightBarButtonItem;
    self.navigationItem.title = self.tableViewController.navigationItem.title;
    
    [self setAppropriateToolbarItems];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embed"]) {
        self.tableViewController = segue.destinationViewController;
        self.tableViewController.delegate = self;
    }
}

#pragma mark - Private Methods

-(void)setAppropriateToolbarItems {
    NSArray *itemsArray;
    
    if (self.tableViewController.editing) {
        itemsArray = @[[[UIBarButtonItem alloc] initWithTitle:@"Trash" style:UIBarButtonItemStylePlain target:self action:@selector(userDidPressTrashButton:)],
                       [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                       [[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStylePlain target:self action:@selector(userDidPressMoveButton:)],
                       [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                       [[UIBarButtonItem alloc] initWithTitle:@"Mark" style:UIBarButtonItemStylePlain target:self action:@selector(userDidPressMarkButton:)]];
    }
    else {
        itemsArray = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                       [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(suerDidPressAddButton:)]];
    }
    
    [self.toolbar setItems:itemsArray animated:NO];
}

#pragma mark - User Interface Methods

- (void)suerDidPressAddButton:(id)sender {
    [self.tableViewController insertNewObject:nil];
}

- (void)userDidPressTrashButton:(id)sender {
    [self.tableViewController deleteSelectedCells];
    [self.tableViewController setEditing:NO animated:YES];
}

- (void)userDidPressMoveButton:(id)sender {
    [self.tableViewController setEditing:NO animated:YES];
}

- (void)userDidPressMarkButton:(id)sender {
    [self.tableViewController setEditing:NO animated:YES];
}

#pragma mark - TLTableViewControllerDelegate Methods

-(void)tableViewController:(TLTableViewController *)viewController didChangeEditing:(BOOL)editing {
    [self setAppropriateToolbarItems];
}

@end
