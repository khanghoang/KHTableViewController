//
//  KHSuperTableViewCellFactory.h
//  KHTableViewController
//
//  Created by Triệu Khang on 29/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KHCellProtocol.h"

@interface KHSuperTableViewCellFactory : NSObject

- (UITableViewCell <KHCellProtocol> *)_getReusableCellWithClass:(Class)cellClass tableView:(UITableView *)tableView;

@end
