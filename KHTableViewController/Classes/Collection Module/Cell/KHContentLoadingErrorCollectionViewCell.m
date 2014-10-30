//
//  KHContentLoadingErrorCollectionViewCell.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHContentLoadingErrorCollectionViewCell.h"

@implementation KHContentLoadingErrorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *errorLoading = [[UILabel alloc] init];
        errorLoading.text = @"There was an error when loading";
        [self addSubview:errorLoading];

		errorLoading.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:errorLoading attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:errorLoading attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [self addConstraints:@[centerX, centerY]];
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }

    return self;
}

@end
