//
//  KHLoadingFreshTodayOperation.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <500px-iOS-api/PXAPI.h>
#import "KHLoadingFreshTodayOperation.h"

@interface KHLoadingFreshTodayOperation ()

@property (strong, nonatomic) NSIndexSet *indexes;
@property (assign, nonatomic) NSUInteger page;
@property (strong, nonatomic) NSArray *dataPage;

@end

@implementation KHLoadingFreshTodayOperation

- (instancetype)initWithIndexes:(NSIndexSet *)indexes {
	self = [super init];

	if (self) {
		_indexes = indexes;
	}

	return self;
}

- (instancetype)initWithPage:(NSUInteger)page {
	self = [super init];

	if (self) {
		_page = page;
	}

	return self;
}

- (void)loadData:(void (^)(NSArray *data, NSError *error))finishBlock {
	typeof(self) weakSelf = self;
	[PXRequest authenticateWithUserName:@"hoangtrieukhang" password:@"123#@!MinhKhang" completion: ^(BOOL success) {
	    if (success) {
	        [PXRequest requestForPhotoFeature:PXAPIHelperPhotoFeatureFreshWeek resultsPerPage:20 page:weakSelf.page completion: ^(NSDictionary *results, NSError *error) {
	            weakSelf.dataPage = results[@"photos"];

	            if (finishBlock) {
	                finishBlock(weakSelf.dataPage, error);
				}
			}];
		}
	    else {
	        if (finishBlock) {
	            NSError *errorWithAuth = [NSError errorWithDomain:NSStringFromClass([self class]) code:101 userInfo:@{ @"description": @"Error with authentication" }];
                finishBlock(nil, errorWithAuth);
			}
		}
	}];
}

@end
