//
//  KHLoadMoreTableViewCell.m
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 5/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHLoadMoreTableViewCell.h"

@interface KHLoadMoreTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblLoading;

@end

@implementation KHLoadMoreTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *errorLoading = [[UILabel alloc] init];
        errorLoading.text = @"Loading";
        self.lblLoading = errorLoading;
        [self addSubview:errorLoading];
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:errorLoading attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:errorLoading attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [self addConstraints:@[centerX, centerY]];
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    self.lblLoading.text = @"";
}

- (void)configWithData:(id)data {
    self.lblLoading.text = data;
}

@end
