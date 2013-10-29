//
//  TLSwipeForOptionsScrollView.m
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-10-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLSwipeForOptionsScrollView.h"

@implementation TLSwipeForOptionsScrollView

- (void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
    if (self.tableViewCell)
        [self.tableViewCell touchesBegan: touches withEvent: event];
}
- (void) touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{
    if (self.tableViewCell)
        [self.tableViewCell touchesEnded:touches withEvent: event];
}

@end
