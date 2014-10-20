//
//  KHBasicSectionModel.m
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 2/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicSectionModel.h"

@implementation KHBasicSectionModel

- (NSString *)title {
    return @"title";
}

- (NSUInteger)count {
    return [self items].count;
}

- (id)itemAtIndex:(NSUInteger)index {
    return [[self items] objectAtIndex:index];
}

- (NSArray *)items {
    return @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i"];
}

@end
