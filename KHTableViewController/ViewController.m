//
//  ViewController.m
//  KHAwesomePicture
//
//  Created by Triệu Khang on 7/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <LBDelegateMatrioska/LBDelegateMatrioska.h>
#import "ViewController.h"
#import "CellFactory1.h"
#import "ContentLoadingPopularViewModel.h"
#import "KHLoadingContentErrorViewModel.h"
#import "KHLoadingPopularOperation.h"
#import "KHPopularCollectionCellFactory.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellFactory = [[KHPopularCollectionCellFactory alloc] init];
    [self setEnableRefreshControl:YES];
}

- (id<KHContentLoadingProtocol, KHTableViewSectionModel>)getLoadingTotalPageObject {
	ContentLoadingPopularViewModel *loadingTotalItems = [[ContentLoadingPopularViewModel alloc] init];
	loadingTotalItems.delegate = (id)self;
	[loadingTotalItems loadContent];
    return loadingTotalItems;
}

#pragma mark - handle error

- (id<KHLoadingOperationProtocol>)loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel indexes:(NSIndexSet *)indexes {
    KHLoadingPopularOperation *operation = [[KHLoadingPopularOperation alloc] initWithIndexes:indexes];
    return operation;
}

@end
