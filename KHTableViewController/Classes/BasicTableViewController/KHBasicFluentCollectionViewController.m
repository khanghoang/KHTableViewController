//
//  KHBasicFluentCollectionViewController.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicFluentCollectionViewController.h"
#import "KHTableController.h"
#import "KHLoadingContentErrorViewModel.h"
#import "KHCollectionContentLoadingCellFactory.h"
#import "KHCollectionController.h"

@interface KHBasicFluentCollectionViewController ()

@property (strong, nonatomic) KHCollectionController *collectionController;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL enableRefreshControl;

@end

@implementation KHBasicFluentCollectionViewController

- (id <KHContentLoadingProtocol, KHTableViewSectionModel> )getLoadingTotalPageObject {
	[NSException raise:NSInternalInconsistencyException
	            format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return nil;
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel indexes:(NSIndexSet *)indexes {
	[NSException raise:NSInternalInconsistencyException
	            format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return nil;
}

- (id <KHTableViewCellFactoryProtocol> )getCellFactory {
	[NSException raise:NSInternalInconsistencyException
	            format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return nil;
}

- (void)_checkIfSetupTableView {
	if (!self.collectionView) {
		[NSException raise:NSInternalInconsistencyException
		            format:@"You have to set table view in subclass loadView method"];
	}
}

- (void)_checkIfSetupCellFactory {
	if (!self.cellFactory) {
		[NSException raise:NSInternalInconsistencyException
		            format:@"You have to set cell factory in subclass viewDidLoad method"];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];

    [self _checkIfSetupTableView];
    [self _onRefresh];
}

- (void)setEnableRefreshControl:(BOOL)enableRefreshControl {
    _enableRefreshControl = enableRefreshControl;
    [self _shouldAddRefreshControl];
}

- (void)didLoadWithResultWithTotalPage:(NSInteger)totalItems error:(NSError *)error operation:(AFHTTPRequestOperation *)operation {

    [self.refreshControl endRefreshing];

	if (error) {
		KHBasicTableViewModel *loadingContentErrorSection = [[KHBasicTableViewModel alloc] initWithModel:nil];
		KHLoadingContentErrorViewModel *loadingContentErrorViewModel = [[KHLoadingContentErrorViewModel alloc] init];
		loadingContentErrorSection.sectionModel = loadingContentErrorViewModel;

		[self.collectionController setModel:loadingContentErrorSection];
        self.collectionController.cellFactory = [[KHCollectionContentLoadingCellFactory alloc] init];

		[self.collectionView reloadData];

		return;
	}

	KHBasicTableViewModel *dataSection = [[KHBasicTableViewModel alloc] init];
	KHFluentDataProvider *provider = [[KHFluentDataProvider alloc] initWithPageSize:10];
	provider.automaticPreloadMargin = 2;
	provider.shouldLoadAutomatically = YES;
	dataSection.sectionModel = provider;
	provider.delegate = self;

	self.collectionController.model = dataSection;

    [self _checkIfSetupCellFactory];

	self.collectionController.cellFactory = self.cellFactory;

	[self.collectionView reloadData];
}

- (void)dataProvider:(KHFluentDataProvider *)dataProvider didLoadDataAtIndexes:(NSIndexSet *)indexes {
	NSMutableArray *arrReloadRow = [NSMutableArray array];
	[indexes enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
	    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
	    BOOL visible = [[self.collectionView indexPathsForVisibleItems] containsObject:indexPath];
	    if (visible) {
	        [arrReloadRow addObject:indexPath];
		}
	}];

    [self.collectionView reloadItemsAtIndexPaths:arrReloadRow];
}

- (void)_shouldAddRefreshControl {
    if (!self.enableRefreshControl) {
        return;
    }

    [self _addRefreshControl];
}

- (void)_addRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(_onRefresh) forControlEvents:UIControlEventValueChanged];
	[self.collectionView addSubview:self.refreshControl];
}

- (void)_onRefresh {
    [self.refreshControl endRefreshing];
	KHBasicTableViewModel *dataSection = [[KHBasicTableViewModel alloc] init];
	id <KHTableViewSectionModel, KHContentLoadingProtocol> loadingTotalItems = [self getLoadingTotalPageObject];
	loadingTotalItems.delegate = self;
	dataSection.sectionModel = loadingTotalItems;

	[loadingTotalItems loadContent];

	self.collectionController = [[KHCollectionController alloc] init];
	self.collectionController.model = dataSection;
	self.collectionController.cellFactory = [[KHCollectionContentLoadingCellFactory alloc] init];

	self.collectionView.dataSource = self.collectionController;
	self.collectionView.delegate = self.collectionController;

    [self.collectionView reloadData];
}

@end