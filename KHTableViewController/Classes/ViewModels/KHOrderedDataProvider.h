//
//  KHOrderedDataProvider.h
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewController.h"

@class KHOrderedDataProvider;

@protocol KHOrderedDataProtocol <NSObject>

@required
- (id<KHLoadingOperationProtocol>)loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel forPage:(NSUInteger)page;

@optional
- (void)dataProvider:(KHOrderedDataProvider *)dataProvider didLoadDataAtPage:(NSUInteger)page withItems:(NSArray *)items error:(NSError *)error;

@end

@interface KHOrderedDataProvider : NSObject
<
    KHTableViewSectionModel
>

@property (nonatomic, weak) id<KHOrderedDataProtocol> delegate;
@property (assign, nonatomic, readonly) BOOL isReachMaxPage;

@property (assign, nonatomic) BOOL reversed;

- (void)startLoading;
- (id)objectAtIndex:(NSUInteger)index withTriggerPagination:(BOOL)pagination;

@end
