//
//  KHImageTableViewCell.m
//  KHAwesomePicture
//
//  Created by Triệu Khang on 7/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHImageTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface KHImageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;

@end

@implementation KHImageTableViewCell

- (void)awakeFromNib {
	// Initialization code
	[self.imgView setImage:nil];
}

- (void)prepareForReuse {
    self.lblIndex.text = @"";
    [self.imgView setImage:nil];
}

- (void)configWithData:(id)data {
	if ([data isEqual:[NSNull null]]) {
		return;
	}

	if ([data isKindOfClass:[NSNumber class]]) {
		self.lblIndex.text = [data stringValue];
		return;
	}

    NSString *strURL = [data[@"image_url"] firstObject];
    [self.imgView setImageWithURL:[NSURL URLWithString:strURL]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end
