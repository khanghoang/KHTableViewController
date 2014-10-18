//
//  KHLoadMoreSection.m
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 5/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHLoadMoreSection.h"

@implementation KHLoadMoreSection

- (NSString *)title {
    return @"";
}

- (NSUInteger)count {
    return 1;
}

- (id)objectAtIndex:(NSUInteger)index {
    return @"Load more";
}

@end
