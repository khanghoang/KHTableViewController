//
//  KHImageCollectionViewCell.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHImageCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface KHImageCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation KHImageCollectionViewCell

- (void)awakeFromNib {
	// Initialization code
    NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *constraintBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *constraintLeading = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *constraintTrailing = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];

    [self addConstraints:@[constraintTop, constraintBottom, constraintLeading, constraintTrailing]];

    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)prepareForReuse {
    [self.imgView setImage:nil];
}

- (void)configWithData:(id)data {
	if ([data isEqual:[NSNull null]]) {
		return;
	}

    NSString *strURL = [data[@"image_url"] firstObject];
    [self.imgView setImageWithURL:[NSURL URLWithString:strURL]];
}

@end
