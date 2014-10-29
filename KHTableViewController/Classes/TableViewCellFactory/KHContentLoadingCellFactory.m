//
//  WSContentLoadingCellFactory.m
//  OrangeFashion
//
//  Created by Triệu Khang on 15/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHContentLoadingCellFactory.h"
#import "KHLoadingContentTableViewCell.h"

@implementation KHContentLoadingCellFactory

- (CGFloat)tableView:(UITableView*)tableView heightForItemAtIndexpath:(NSIndexPath *)indexpaht model:(id<KHTableViewModel>)model {
    return tableView.frame.size.height;
}

- (UITableViewCell<KHCellProtocol> *)cellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView model:(id<KHTableViewModel>)model {
    UITableViewCell<KHCellProtocol> *cell = [self _getReusableCellWithClass:[KHLoadingContentTableViewCell class] tableView:tableView];
    return cell;
}

@end
