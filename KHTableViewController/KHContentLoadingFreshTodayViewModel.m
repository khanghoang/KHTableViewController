//
//  KHContentLoadingFreshTodayViewModel.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHContentLoadingFreshTodayViewModel.h"
#import <500px-iOS-api/PXAPI.h>

@implementation KHContentLoadingFreshTodayViewModel

@synthesize delegate;

- (NSString *)title {
    return @"";
}

- (id)objectAtIndex:(NSUInteger)index {
    return @"";
}

- (NSUInteger)count {
    return 1;
}

- (void)loadContent {
    [self loadContent:nil];
}

- (void)loadContent:(void (^)(NSInteger, NSError *, AFHTTPRequestOperation *))completeBlock {
	[PXRequest authenticateWithUserName:@"hoangtrieukhang" password:@"123#@!MinhKhang" completion: ^(BOOL success) {
	    if (success) {
	        [PXRequest requestForPhotoFeature:PXAPIHelperPhotoFeatureFreshToday resultsPerPage:20 page:0 completion: ^(NSDictionary *results, NSError *error) {
	            if (completeBlock) {
	                completeBlock(1000, error, nil);
				}

	            [self.delegate didLoadWithResultWithTotalPage:1000 error:error operation:nil];
			}];
		}
	    else {
	        [self.delegate didLoadWithResultWithTotalPage:-1 error:[NSError errorWithDomain:@"" code:11 userInfo:nil] operation:nil];
		}
	}];
}

@end
