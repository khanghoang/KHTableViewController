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

- (void)loadData:(void (^)(NSArray *data))finishBlock {
	typeof(self) weakSelf = self;
	NSMutableArray *dataPage = [NSMutableArray arrayWithCapacity:20];
	[PXRequest authenticateWithUserName:@"hoangtrieukhang" password:@"123#@!MinhKhang" completion: ^(BOOL success) {
	    if (success) {
	        [PXRequest requestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:20 page:(weakSelf.indexes.lastIndex + 1) / 20 completion: ^(NSDictionary *results, NSError *error) {
	            [weakSelf.indexes enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
	                id data = [results[@"photos"] objectAtIndex:idx % 20];
	                dataPage[idx % 20] = data;
				}];
	            weakSelf->_dataPage = dataPage;
	            if (finishBlock) {
	                finishBlock(dataPage);
				}
			}];
		}
	    else {
		}
	}];
}

@end
