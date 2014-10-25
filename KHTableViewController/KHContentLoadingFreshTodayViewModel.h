//
//  KHContentLoadingFreshTodayViewModel.h
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHContentLoadingProtocol.h"
#import "KHTableViewSectionModel.h"

@interface KHContentLoadingFreshTodayViewModel : NSObject
<
    KHContentLoadingProtocol,
    KHTableViewSectionModel
>

@end
