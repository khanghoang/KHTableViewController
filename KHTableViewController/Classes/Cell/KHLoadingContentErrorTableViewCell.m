//
//  KHLoadingContentErrorTableViewCell.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 10/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHLoadingContentErrorTableViewCell.h"

@implementation KHLoadingContentErrorTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *errorLoading = [[UILabel alloc] init];
        errorLoading.text = @"There was an error when loading";
        [self addSubview:errorLoading];
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:errorLoading attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:errorLoading attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [self addConstraints:@[centerX, centerY]];
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }

    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

@end
