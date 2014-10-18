//
//  BasicTableViewController.m
//  OrangeFashion
//
//  Created by Triệu Khang on 17/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicFluentTableViewController.h"
#import "KHContentLoadingCellFactory.h"

@interface KHBasicFluentTableViewController ()
<
    HandleContentLoadingProtocol,
    DataProviderDelegate
>

@property (strong, nonatomic) TableController *tableController;

@end

@implementation KHBasicFluentTableViewController

- (id <ContentLoadingProtocol, KHTableViewSectionModel> )getLoadingTotalPageObject {
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

	BasicTableViewModel *dataSection = [[BasicTableViewModel alloc] init];
	id <KHTableViewSectionModel, ContentLoadingProtocol> loadingTotalItems = [self getLoadingTotalPageObject];
	loadingTotalItems.delegate = self;
	dataSection.sectionModel = loadingTotalItems;

	[loadingTotalItems loadContent];

	self.tableController = [[TableController alloc] init];
	self.tableController.model = dataSection;
	self.tableController.cellFactory = [[WSContentLoadingCellFactory alloc] init];

	self.tableView.dataSource = self.tableController;
	self.tableView.delegate = self.tableController;

	[self.tableView reloadData];
}

- (void)didLoadWithResultWithTotalPage:(NSInteger)totalItems error:(NSError *)error operation:(AFHTTPRequestOperation *)operation {
	BasicTableViewModel *dataSection = [[BasicTableViewModel alloc] init];
	DataProvider *provider = [[DataProvider alloc] initWithPageSize:10];
	provider.automaticPreloadMargin = 2;
	provider.shouldLoadAutomatically = YES;
	dataSection.sectionModel = provider;
	provider.delegate = self;

	self.tableController.model = dataSection;

    [self _checkIfSetupCellFactory];

	self.tableController.cellFactory = self.cellFactory;

	[self.tableView reloadData];
}

- (void)dataProvider:(DataProvider *)dataProvider didLoadDataAtIndexes:(NSIndexSet *)indexes {
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

@end
