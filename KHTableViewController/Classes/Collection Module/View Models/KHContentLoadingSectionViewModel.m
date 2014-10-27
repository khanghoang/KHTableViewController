//
//  KHContentLoadingSectionViewModel.m
//  KHTableViewController
//
//  Created by Triệu Khang on 27/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHContentLoadingSectionViewModel.h"

@implementation KHContentLoadingSectionViewModel

- (NSUInteger)count {
    return 1;
}

- (NSString *)title {
    return @"";
}

- (id)objectAtIndex:(NSUInteger)index {
    return @"Content is being loaded";
}

@end
