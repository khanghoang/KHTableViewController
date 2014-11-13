//
//  KHOrderedDataProvider.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHOrderedDataProvider.h"

@interface KHOrderedDataProvider ()

@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) BOOL isLoadingNextPage;
@property (assign, nonatomic, readwrite) BOOL isReachMaxPage;
@property (strong, nonatomic) NSBlockOperation *loadingOperation;
@property (strong, nonatomic) NSMutableArray *arrItems;

@end

@implementation KHOrderedDataProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentPage = -1;
        _isReachMaxPage = NO;
        _isLoadingNextPage = NO;
        _arrItems = [NSMutableArray array];
    }

    return self;
}

#pragma mark - KHTableViewSectionModel interface

- (NSUInteger)count {
    return [self.arrItems count];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self _objectAtIndex:index withPagination:YES];
}

- (id)objectAtIndex:(NSUInteger)index withTriggerPagination:(BOOL)pagination {
    return [self _objectAtIndex:index withPagination:pagination];
}

- (id)_objectAtIndex:(NSUInteger)index withPagination:(BOOL)pagination {
    if (pagination && index == self.arrItems.count - 1) {
        [self _setShouldLoadDataForNextPage];
    }

    return [self.arrItems objectAtIndex:index];
}

#pragma mark - Public method

- (void)startLoading {
    self.currentPage = -1;
    self.isReachMaxPage = NO;
    self.isLoadingNextPage = NO;
    self.arrItems = [NSMutableArray array];
    [self _setShouldLoadDataForNextPage];
}

#pragma mark - Private methods

- (void)_setShouldLoadDataForNextPage {
    if (self.isReachMaxPage) {
        return;
    }

    if (self.isLoadingNextPage) {
        return;
    }

    [self _loadNextPage];
}

- (void)_loadNextPage {
    self.isLoadingNextPage = YES;

    id <KHLoadingOperationProtocol> loadingOperation = [self.delegate loadingOperationForSectionViewModel:self forPage:self.currentPage + 1];
    self.loadingOperation = loadingOperation;
    __weak typeof(self) weakSelf = self;

    [loadingOperation loadData: ^(NSArray *data, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            [weakSelf _dataOperation:loadingOperation finishedLoadingForPage:self.currentPage + 1 error:error];
        }];
    }];
}

- (void)_dataOperation:(NSBlockOperation <KHLoadingOperationProtocol> *)operation finishedLoadingForPage:(NSUInteger)page error:(NSError *)error {
    self.isLoadingNextPage = NO;

    if (operation.dataPage.count == 0 && !error) {
        self.isReachMaxPage = YES;
    }
    else {
        self.currentPage++;
    }

    NSArray *arr = operation.dataPage;
    if (self.reversed) {
        arr = [self _reverseArray:operation.dataPage];
    }

    [self.arrItems addObjectsFromArray:arr];
    if ([self.delegate respondsToSelector:@selector(dataProvider:didLoadDataAtPage:withItems:error:)]) {
        [self.delegate dataProvider:self didLoadDataAtPage:self.currentPage withItems:operation.dataPage error:error];
    }
}

- (NSArray *)_reverseArray:(NSArray *)array {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = array.count - 1; i >= 0; i--) {
        [resultArray addObject:array[i]];
    }
    
    return [resultArray copy];
}

@end
