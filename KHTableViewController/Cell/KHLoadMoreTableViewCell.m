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

- (void)awakeFromNib {
    // Initialization code
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
