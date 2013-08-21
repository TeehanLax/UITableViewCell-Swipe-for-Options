//
//  TLOverlayView.h
//  https://github.com/daria-kopaliani/DAContextMenuTableViewController
//
//  Created by Daria Kopaliani on 7/25/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TLOverlayView;

@protocol TLOverlayViewDelegate <NSObject>

- (UIView *)overlayView:(TLOverlayView *)view didHitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end


@interface TLOverlayView : UIView

@property (weak, nonatomic) id<TLOverlayViewDelegate> delegate;

@end
