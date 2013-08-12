//
//  TLMasterViewController.h
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLTableViewController;

@protocol TLTableViewControllerDelegate <NSObject>

-(void)tableViewController:(TLTableViewController *)viewController didChangeEditing:(BOOL)editing;
-(void)presentActionSheet:(UIActionSheet *)actionSheet fromViewController:(TLTableViewController *)viewController;

@end

@interface TLTableViewController : UITableViewController

@property (nonatomic, weak) id<TLTableViewControllerDelegate> delegate;

- (void)insertNewObject:(id)sender;
- (void)deleteSelectedCells;

@end
