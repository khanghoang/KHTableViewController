//
//  HandleContentLoadingProtocol.h
//  KHAwesomeImage
//
//  Created by Triệu Khang on 10/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HandleContentLoadingProtocol <NSObject>

- (void)didLoadWithResultWithTotalPage:(NSInteger)totalItems error:(NSError *)error operation:(AFHTTPRequestOperation *)operation;

@end
