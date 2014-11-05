//
//  KHFreshTodayCollectionViewController.m
//  KHTableViewController
//
//  Created by Triệu Khang on 26/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHFreshTodayCollectionViewController.h"
#import "KHLoadingFreshTodayOperation.h"
#import "KHTableViewSectionModel.h"
#import "KHOrderedDataProvider.h"
#import "KHPopularCollectionCellFactory.h"

@interface KHFreshTodayCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation KHFreshTodayCollectionViewController

- (UICollectionView *)collectionView {
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enablePullToRefresh];
}

- (id<KHCollectionViewCellFactoryProtocol>)cellFactory {
    return [[KHPopularCollectionCellFactory alloc] init];
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
    return [[KHLoadingFreshTodayOperation alloc] initWithPage:page];
}

@end
