//
//  BasicTableViewController.m
//  OrangeFashion
//
//  Created by Triệu Khang on 17/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicFluentTableViewController.h"
#import "KHContentLoadingCellFactory.h"
#import "KHLoadingContentErrorViewModel.h"
#import "KHContentLoadingErrorCellFactory.h"

@interface KHBasicFluentTableViewController ()
<
    KHHandleContentLoadingProtocol,
    KHDataProviderDelegate
>

@property (strong, nonatomic) KHTableController *tableController;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL enableRefreshControl;

@end

@implementation KHBasicFluentTableViewController

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
	if (!self.tableView) {
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

		[self.tableController setModel:loadingContentErrorSection];
        self.tableController.cellFactory = [[KHContentLoadingErrorCellFactory alloc] init];

		[self.tableView reloadData];

		return;
	}

	KHBasicTableViewModel *dataSection = [[KHBasicTableViewModel alloc] init];
	KHFluentDataProvider *provider = [[KHFluentDataProvider alloc] initWithPageSize:10];
	provider.automaticPreloadMargin = 2;
	provider.shouldLoadAutomatically = YES;
	dataSection.sectionModel = provider;
	provider.delegate = self;

	self.tableController.model = dataSection;

    [self _checkIfSetupCellFactory];

	self.tableController.cellFactory = self.cellFactory;

	[self.tableView reloadData];
}

- (void)dataProvider:(KHFluentDataProvider *)dataProvider didLoadDataAtIndexes:(NSIndexSet *)indexes {
	[self.tableView beginUpdates];
	NSMutableArray *arrReloadRow = [NSMutableArray array];
	[indexes enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
	    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
	    BOOL visible = [[self.tableView indexPathsForVisibleRows] containsObject:indexPath];
	    if (visible) {
	        [arrReloadRow addObject:indexPath];
		}
	}];
	[self.tableView reloadRowsAtIndexPaths:arrReloadRow withRowAnimation:UITableViewRowAnimationFade];
	[self.tableView endUpdates];
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
	[self.tableView addSubview:self.refreshControl];
}

- (void)_onRefresh {
    [self.refreshControl endRefreshing];
	KHBasicTableViewModel *dataSection = [[KHBasicTableViewModel alloc] init];
	id <KHTableViewSectionModel, KHContentLoadingProtocol> loadingTotalItems = [self getLoadingTotalPageObject];
	loadingTotalItems.delegate = self;
	dataSection.sectionModel = loadingTotalItems;

	[loadingTotalItems loadContent];

	self.tableController = [[KHTableController alloc] init];
	self.tableController.model = dataSection;
	self.tableController.cellFactory = [[KHContentLoadingCellFactory alloc] init];

	self.tableView.dataSource = self.tableController;
	self.tableView.delegate = self.tableController;

    [self.tableView reloadData];
}

@end
