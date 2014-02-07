//
//  TLSwipeForOptionsScrollView.m
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-10-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLSwipeForOptionsScrollView.h"

@implementation TLSwipeForOptionsScrollView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview touchesBegan: touches withEvent: event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview touchesEnded:touches withEvent: event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesMoved:touches withEvent:event];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesCancelled:touches withEvent:event];
}

@end
