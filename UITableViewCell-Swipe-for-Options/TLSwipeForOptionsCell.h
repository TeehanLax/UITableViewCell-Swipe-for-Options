//
//  TLSwipeForOptionsCell.h
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLSwipeForOptionsCell;

@protocol TLSwipeForOptionsCellDelegate <NSObject>

-(void)cellDidSelectDelete:(TLSwipeForOptionsCell *)cell;
-(void)cellDidSelectMore:(TLSwipeForOptionsCell *)cell;

@end

extern NSString *const TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification;

@interface TLSwipeForOptionsCell : UITableViewCell

@property (nonatomic, weak) id<TLSwipeForOptionsCellDelegate> delegate;

@end
