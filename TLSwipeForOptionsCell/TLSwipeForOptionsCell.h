//
//  TLSwipeForOptionsCell.h
//  TLSwipeForOptionsCell
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLSwipeForOptionsCell;

///----------------
/// @name Delegate
///----------------

/**
 The delegate of a `TLSwipeForOptionsCell` object must adopt the `TLSwipeForOptionsCellDelegate` protocol.
 */
@protocol TLSwipeForOptionsCellDelegate <NSObject>

/**
 Tells the delegate that the specified cell’s menu is now shown or hidden.
 
 @param cell The cell whose menu was shown or hidden.
 @param isShowingMenu `YES` if the menu was shown; otherwise, `NO`.
 */
- (void)cell:(TLSwipeForOptionsCell *)cell didShowMenu:(BOOL)isShowingMenu;

/**
 Tells the delegate that the specified cell’s “Delete” button is pressed.
 
 @param cell The cell whose “Delete” button was pressed.
 */
- (void)cellDidSelectDelete:(TLSwipeForOptionsCell *)cell;

/**
 Tells the delegate that the specified cell’s “More” button is pressed.
 
 @param cell The cell whose “More” button was pressed.
 */
- (void)cellDidSelectMore:(TLSwipeForOptionsCell *)cell;

@end

/**
 Notifies cells that their menus should be hidden. Upon hiding its menu, a cell will call its delegate’s `cell:didShowMenu:` method.
 
 @see cell:didShowMenu:
 */
extern NSString *const TLSwipeForOptionsCellShouldHideMenuNotification;

///-------------
/// @name Class
///-------------

/**
 A reproduction of the iOS 7 Mail app’s swipe-to-reveal options.
 */
@interface TLSwipeForOptionsCell : UITableViewCell

///------------------
/// @name Properties
///------------------

/**
 The object that acts as the delegate of the receiving cell.
 
 @discussion The delegate must adopt the `TLSwipeForOptionsCellDelegate` protocol.
 */
@property (nonatomic, weak) id<TLSwipeForOptionsCellDelegate> delegate;

@end
