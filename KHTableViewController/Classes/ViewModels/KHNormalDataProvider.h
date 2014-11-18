//
//  KHNormalDataProvider.h
//  KHTableViewController
//
//  Created by Triệu Khang on 18/11/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewController.h"

@class KHNormalDataProvider;

@protocol KHNormalDataProviderProtocol <NSObject>

@required
- (id<KHLoadingOperationProtocol>)loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel;

@optional
- (void)dataProvider:(KHNormalDataProvider *)dataProvider didLoadWithItems:(NSArray *)items error:(NSError *)error;

@end

@interface KHNormalDataProvider : NSObject
<
    KHTableViewSectionModel
>

- (void)startLoading;

@property (nonatomic, weak) id<KHNormalDataProviderProtocol> delegate;
@property (assign, nonatomic) BOOL reversed;

@end
