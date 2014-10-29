//
//  KHContentLoadingCollectionCell.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHContentLoadingCollectionCell.h"

@implementation KHContentLoadingCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator startAnimating];
        [self addSubview:indicator];
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [self addConstraints:@[centerX, centerY]];
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }

    return self;
}

@end
