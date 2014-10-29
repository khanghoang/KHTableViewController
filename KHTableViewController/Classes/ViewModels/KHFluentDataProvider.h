//
//  DataProvider.h
//  FluentResourcePaging-example
//
//  Created by Alek Astrom on 2013-12-28.
//  Copyright (c) 2013 Alek Åström. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KHFluentDataProvider;
@protocol KHDataProviderDelegate<NSObject>

@required
- (id<KHLoadingOperationProtocol>)loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel indexes:(NSIndexSet *)indexes;

@optional
- (void)dataProvider:(KHFluentDataProvider *)dataProvider willLoadDataAtIndexes:(NSIndexSet *)indexes;
- (void)dataProvider:(KHFluentDataProvider *)dataProvider didLoadDataAtIndexes:(NSIndexSet *)indexes;

@end

@interface KHFluentDataProvider : NSObject
<
KHTableViewSectionModel
>

- (instancetype)initWithPageSize:(NSUInteger)pageSize;

@property (nonatomic, weak) id<KHDataProviderDelegate> delegate;

/**
 * The array returned will be a proxy object containing
 * NSNull values for data objects not yet loaded. As data
 * loads, the proxy updates automatically to include
 * the newly loaded objects.
 *
 * @see shouldLoadAutomatically
 */
@property (nonatomic, readonly) NSArray *dataObjects;

@property (nonatomic, readonly) NSUInteger pageSize;
@property (nonatomic, readonly) NSUInteger loadedCount;

/**
 * When this property is set, new data is automatically loaded when
 * the dataObjects array returns an NSNull reference.
 *
 * @see dataObjects
 */
@property (nonatomic) BOOL shouldLoadAutomatically;
@property (nonatomic) NSUInteger automaticPreloadMargin;

- (BOOL)isLoadingDataAtIndex:(NSUInteger)index;
- (void)loadDataForIndex:(NSUInteger)index;

@end
