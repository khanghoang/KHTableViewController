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

#pragma mark - Private methods

- (UITableViewCell <KHCellProtocol> *)_getReusableCellWithClass:(Class)cellClass tableView:(UITableView *)tableView {
	[self _registerTheClass:cellClass toTableView:tableView];
	return [self _dequeueReuseableCellWithClass:cellClass ofTableView:tableView];
}

- (void)_registerTheClass:(Class)cellClass toTableView:(UITableView *)tableView {
	UINib *cellNib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
	[tableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (UITableViewCell <KHCellProtocol> *)_dequeueReuseableCellWithClass:(Class)cellClass ofTableView:(UITableView *)tableView {
	UITableViewCell <KHCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
	return cell;
}

@end
