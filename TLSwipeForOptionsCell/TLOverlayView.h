//
//  TLOverlayView.h
//  https://github.com/daria-kopaliani/DAContextMenuTableViewController
//
//  Created by Daria Kopaliani on 7/25/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLOverlayView;

///----------------
/// @name Delegate
///----------------

/**
 The delegate of a `TLOverlayView` object must adopt the `TLOverlayViewDelegate` protocol.
 */
@protocol TLOverlayViewDelegate <NSObject>

/**
 Asks the delegate for the view that should receive the touch `point`.
 
 @param view The overlay view that received the touch.
 @param point A point specified in the receiver’s local coordinate system (bounds).
 @param event The event that warranted a call to this method. If you are calling this method from outside your event-handling code, you may specify `nil`.
 */
- (UIView *)overlayView:(TLOverlayView *)view didHitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end

///-------------
/// @name Class
///-------------

/**
 The `TLOverlayView` class defines a rectangular area on the screen whose touches should be received from.
 */
@interface TLOverlayView : UIView

///------------------
/// @name Properties
///------------------

/**
 The object that acts as the delegate of the receiving overlay view.
 
 @discussion The delegate must adopt the `TLOverlayViewDelegate` protocol.
 */
@property (weak, nonatomic) id<TLOverlayViewDelegate> delegate;

@end
