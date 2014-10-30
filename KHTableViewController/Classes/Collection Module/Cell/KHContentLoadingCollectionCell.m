//
//  KHContentLoadingCollectionCell.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHContentLoadingCollectionCell.h"

@interface KHContentLoadingCollectionCell ()

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation KHContentLoadingCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[indicator startAnimating];
		self.indicator = indicator;
		[self.contentView addSubview:indicator];

		self.indicator.translatesAutoresizingMaskIntoConstraints = NO;

		NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
		NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];

		[self.contentView addConstraints:@[centerY, centerX]];

		[self.contentView setNeedsUpdateConstraints];
		[self.contentView layoutIfNeeded];
	}

	return self;
}

@end
