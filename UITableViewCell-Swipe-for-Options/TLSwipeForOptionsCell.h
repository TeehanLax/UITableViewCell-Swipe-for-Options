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

- (void)cell:(TLSwipeForOptionsCell*)cell didSelectButtonAtIndex:(NSUInteger)index withInfoDictionary:(NSDictionary*)info;

@end

extern NSString *const TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification;

extern NSString *const TLSwipeForOptionsCellTitleOptionKey;
extern NSString *const TLSwipeForOptionsCellBackgroundColorOptionKey;
extern NSString *const TLSwipeForOptionsCellForegroundColorOptionKey;

@interface TLSwipeForOptionsCell : UITableViewCell

- (void)addButtonWithOptions:(NSDictionary*)options;
- (void)resetButtons;

@property (nonatomic, strong) NSMutableArray* buttons;
@property (nonatomic, weak) id<TLSwipeForOptionsCellDelegate> delegate;

@end
