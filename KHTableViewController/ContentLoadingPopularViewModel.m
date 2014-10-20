//
//  ContentLoadingPopularViewModel.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 10/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "ContentLoadingPopularViewModel.h"
#import <500px-iOS-api/PXAPI.h>

@interface ContentLoadingPopularViewModel()

@end

@implementation ContentLoadingPopularViewModel

@synthesize delegate;

- (void)loadContent:(void (^)(NSInteger totalItems, NSError *error, AFHTTPRequestOperation *operation))completeBlock {
	[PXRequest authenticateWithUserName:@"hoangtrieukhang" password:@"123#@!MinhKhang" completion: ^(BOOL success) {
	    if (success) {
	        [PXRequest requestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:20 page:1 completion: ^(NSDictionary *results, NSError *error) {
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

- (void)loadContent {
	[self loadContent:nil];
}

- (id)objectAtIndex:(NSUInteger)index {
	return @"";
}

- (NSUInteger)count {
	return 1;
}

- (NSString *)title {
	return @"";
}

@end
