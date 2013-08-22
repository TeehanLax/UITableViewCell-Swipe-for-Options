//
//  TLContainerViewController.m
//  TLSFOC-Demo
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLContainerViewController.h"
#import "TLTableViewController.h"

@interface TLContainerViewController () <TLTableViewControllerDelegate>

@property (nonatomic, weak) TLTableViewController *tableViewController;

@end

@implementation TLContainerViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.navigationItem.leftBarButtonItem = self.tableViewController.navigationItem.leftBarButtonItem;
	self.navigationItem.rightBarButtonItem = self.tableViewController.navigationItem.rightBarButtonItem;
	
	self.navigationItem.title = @"Table View"; 
	
	[self setAppropriateToolbarItems];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"embed"]) {
		self.tableViewController = segue.destinationViewController;
		self.tableViewController.delegate = self;
	}
}

#pragma mark - Private Methods

// Sets the appropriate UIBarButtonItems for our toolbar depending on the editing property of self.tableViewController.
- (void)setAppropriateToolbarItems {
	NSArray *itemsArray;
	
	if (self.tableViewController.editing) {
		itemsArray = @[[[UIBarButtonItem alloc] initWithTitle:@"Trash" style:UIBarButtonItemStylePlain target:self action:@selector(userDidPressTrashButton:)],
					   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
					   [[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStylePlain target:self action:@selector(userDidPressMoveButton:)],
					   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
					   [[UIBarButtonItem alloc] initWithTitle:@"Mark" style:UIBarButtonItemStylePlain target:self action:@selector(userDidPressMarkButton:)]];
	} else {
		itemsArray = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
					   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(userDidPressAddButton:)]];
	}
	
	[self.toolbar setItems:itemsArray animated:NO];
}

#pragma mark - User Interface Methods

/*
 These are all configurable to do whatever you want with them. We only really use the userDidPressTrashButton: method.
 */

- (void)userDidPressAddButton:(id)sender {
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

- (void)tableViewController:(TLTableViewController *)viewController didChangeEditing:(BOOL)editing {
	[self setAppropriateToolbarItems];
}

- (void)presentActionSheet:(UIActionSheet *)actionSheet fromViewController:(TLTableViewController *)viewController {
	[actionSheet showFromToolbar:self.toolbar];
}

@end
