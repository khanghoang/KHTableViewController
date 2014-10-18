//
//  KHCellProtocol.h
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 3/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KHCellProtocol <NSObject>

@required
- (void)configWithData:(id)data;

@end
