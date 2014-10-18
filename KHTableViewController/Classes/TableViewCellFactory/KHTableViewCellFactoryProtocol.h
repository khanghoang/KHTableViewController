//
//  KHTableViewCellFactory.h
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 2/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewModel.h"
#import "KHCellProtocol.h"

@protocol KHTableViewCellFactoryProtocol <NSObject>

@required
- (CGFloat)tableView:(UITableView*)tableView heightForItemAtIndexpath:(NSIndexPath *)indexpaht model:(id<KHTableViewModel>)model;
- (UITableViewCell<KHCellProtocol> *)cellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView model:(id<KHTableViewModel>)model;

@end
