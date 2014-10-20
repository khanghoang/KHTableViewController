//
//  KHLoadingPopularOperation.m
//  KHAwesomePicture
//
//  Created by Triệu Khang on 7/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHLoadingPopularOperation.h"
#import <500px-iOS-api/PXAPI.h>

@interface KHLoadingPopularOperation ()

@property (nonatomic, readonly) NSIndexSet *indexes;
@property (nonatomic, readonly) NSArray *dataPage;

@end

@implementation KHLoadingPopularOperation

- (instancetype)initWithIndexes:(NSIndexSet *)indexes {
	self = [super init];

	if (self) {
		_indexes = indexes;
	}

	return self;
}

- (void)loadData:(void (^)(NSArray *data, NSError *error))finishBlock {
	typeof(self) weakSelf = self;
	NSMutableArray *dataPage = [NSMutableArray arrayWithCapacity:10];
	[PXRequest authenticateWithUserName:@"hoangtrieukhang" password:@"123#@!MinhKhang" completion: ^(BOOL success) {
	    if (success) {
	        [PXRequest requestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:10 page:(weakSelf.indexes.lastIndex + 1) / 10 completion: ^(NSDictionary *results, NSError *error) {
	            [weakSelf.indexes enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
	                id data = [results[@"photos"] objectAtIndex:idx % 10];
	                dataPage[idx % 10] = data;
				}];
	            weakSelf->_dataPage = dataPage;
	            if (finishBlock) {
	                finishBlock(dataPage, error);
				}
			}];
		}
	    else {
		}
	}];
}

@end
