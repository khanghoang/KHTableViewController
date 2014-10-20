//
//  KHContentLoadingProtocol.h
//  KHAwesomeImage
//
//  Created by Triệu Khang on 10/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KHContentLoadingProtocol <NSObject>

- (void)loadContent:(void(^)(NSInteger totalItems, NSError *error, AFHTTPRequestOperation *operation))completeBlock;
- (void)loadContent;

@property (nonatomic, weak) id<KHHandleContentLoadingProtocol> delegate;

@end
