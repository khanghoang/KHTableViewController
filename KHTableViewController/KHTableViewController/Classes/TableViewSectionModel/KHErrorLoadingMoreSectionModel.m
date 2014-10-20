//
//  KHErrorLoadingMoreSectionModel.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 12/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHErrorLoadingMoreSectionModel.h"

@implementation KHErrorLoadingMoreSectionModel

- (NSUInteger)count {
    return 1;
}

- (id)objectAtIndex:(NSUInteger)index {
    return @"There an error that we can't load data";
}

@end
