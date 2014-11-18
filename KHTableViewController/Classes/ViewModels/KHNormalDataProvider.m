//
//  KHNormalDataProvider.m
//  KHTableViewController
//
//  Created by Triệu Khang on 18/11/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHNormalDataProvider.h"

@interface KHNormalDataProvider()

@property (strong, nonatomic) NSBlockOperation *loadingOperation;
@property (strong, nonatomic) NSMutableArray *arrItems;

@end

@implementation KHNormalDataProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        _arrItems = [NSMutableArray array];
    }

    return self;
}

#pragma mark - KHTableViewSectionModel interface

- (NSUInteger)count {
    return [self.arrItems count];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.arrItems objectAtIndex:index];
}

#pragma mark - Public method

- (void)startLoading {
    self.arrItems = [NSMutableArray array];

    id <KHLoadingOperationProtocol> loadingOperation = [self.delegate loadingOperationForSectionViewModel:self];
    self.loadingOperation = loadingOperation;
    __weak typeof(self) weakSelf = self;

    [loadingOperation loadData: ^(NSArray *data, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            [weakSelf _dataOperation:loadingOperation error:error];
        }];
    }];
}

- (void)_dataOperation:(NSBlockOperation <KHLoadingOperationProtocol> *)operation error:(NSError *)error {

    NSArray *arr = operation.dataPage;
    if (self.reversed) {
        arr = [self _reverseArray:operation.dataPage];
    }

    [self.arrItems addObjectsFromArray:arr];
    if ([self.delegate respondsToSelector:@selector(dataProvider:didLoadWithItems:error:)]) {
        [self.delegate dataProvider:self didLoadWithItems:self.arrItems error:error];
    }
}

- (NSArray *)_reverseArray:(NSArray *)array {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i = array.count - 1; i >= 0; i--) {
        [resultArray addObject:array[i]];
    }
    
    return [resultArray copy];
}

@end
