//
//  KHLoadingFreshTodayOperation.h
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHLoadingFreshTodayOperation.h"
#import "KHLoadingOperationProtocol.h"

@interface KHLoadingFreshTodayOperation : NSBlockOperation
<
    KHLoadingOperationProtocol
>

- (instancetype)initWithPage:(NSUInteger)page;

@end
