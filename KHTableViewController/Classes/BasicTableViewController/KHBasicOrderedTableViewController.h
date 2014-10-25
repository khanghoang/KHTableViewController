//
//  KHBasicOrderedTableViewController.h
//  KHTableViewController
//
//  Created by Triệu Khang on 20/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewCellFactoryProtocol.h"

@interface KHBasicOrderedTableViewController : UIViewController

@property (strong, nonatomic) id <KHTableViewCellFactoryProtocol> cellFactory;

@end
