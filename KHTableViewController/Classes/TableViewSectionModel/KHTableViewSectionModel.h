//
//  TableViewSectionModel.h
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 2/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KHTableViewSectionModel <NSObject>

@optional
- (NSString *)title;

@required
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)count;

@end
