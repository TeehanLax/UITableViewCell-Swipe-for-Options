//
//  TLSwipeForOptionsCell.m
//  UITableViewCell-Swipe-for-Options
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLSwipeForOptionsCell.h"

NSString *const TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification = @"TLSwipeForOptionsCellEnclosingTableViewDidScrollNotification";

#define kCatchWidth 180

@interface TLSwipeForOptionsCell () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *scrollViewContentView;      //The cell content (like the label) goes in this view.
@property (nonatomic, weak) UIView *scrollViewButtonView;       //Contains our two buttons

@property (nonatomic, weak) UILabel *scrollViewLabel;

@end

@implementation TLSwipeForOptionsCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    // Set up our contentView hierarchy
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + kCatchWidth, CGRectGetHeight(self.bounds));
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.contentView addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *scrollViewButtonView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - kCatchWidth, 0, kCatchWidth, CGRectGetHeight(self.bounds))];
    self.scrollViewButtonView = scrollViewButtonView;
    [self.scrollView addSubview:scrollViewButtonView];
    
    // Set up our two buttons
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.backgroundColor = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0f];
    moreButton.frame = CGRectMake(0, 0, kCatchWidth / 2.0f, CGRectGetHeight(self.bounds));
    [moreButton setTitle:@"More" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(userPressedMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewButtonView addSubview:moreButton];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0f];
    deleteButton.frame = CGRectMake(kCatchWidth / 2.0f, 0, kCatchWidth / 2.0f, CGRectGetHeight(self.bounds));
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(userPressedDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewButtonView addSubview:deleteButton];
    
    UIView *scrollViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    scrollViewContentView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:scrollViewContentView];
    self.scrollViewContentView = scrollViewContentView;
    
    UILabel *scrollViewLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.scrollViewContentView.bounds, 10, 0)];
    self.scrollViewLabel = scrollViewLabel;
    [self.scrollViewContentView addSubview:scrollViewLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enclosingTableViewDidScroll) name:TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification  object:nil];
}

-(void)enclosingTableViewDidScroll {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Private Methods 

-(void)userPressedDeleteButton:(id)sender {
    [self.delegate cellDidSelectDelete:self];
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

-(void)userPressedMoreButton:(id)sender {
    [self.delegate cellDidSelectMore:self];
}

#pragma mark - Overridden Methods

-(void)layoutSubviews {
    [super layoutSubviews];

    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + kCatchWidth, CGRectGetHeight(self.bounds));
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    self.scrollViewButtonView.frame = CGRectMake(CGRectGetWidth(self.bounds) - kCatchWidth, 0, kCatchWidth, CGRectGetHeight(self.bounds));
    self.scrollViewContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

-(void)prepareForReuse {
    [super prepareForReuse];
    
    [self.scrollView setContentOffset:CGPointZero animated:NO];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    self.scrollView.scrollEnabled = !self.editing;
    
    // Corrects effect of showing the button labels while selected on editing mode (comment line, build, run, add new items to table, enter edit mode and select an entry)
    self.scrollViewButtonView.hidden = editing;
    
    NSLog(@"%d", editing);
}

-(UILabel *)textLabel {
    // Kind of a cheat to reduce our external dependencies
    return self.scrollViewLabel;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (scrollView.contentOffset.x > kCatchWidth) {
        targetContentOffset->x = kCatchWidth;
    }
    else {
        *targetContentOffset = CGPointZero;
        
        // Need to call this subsequently to remove flickering. Strange. 
        dispatch_async(dispatch_get_main_queue(), ^{
            [scrollView setContentOffset:CGPointZero animated:YES];
        });
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < 0) {
        scrollView.contentOffset = CGPointZero;
    }
    
    self.scrollViewButtonView.frame = CGRectMake(scrollView.contentOffset.x + (CGRectGetWidth(self.bounds) - kCatchWidth), 0.0f, kCatchWidth, CGRectGetHeight(self.bounds));
}

@end

#undef kCatchWidth
