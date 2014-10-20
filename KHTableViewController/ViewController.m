//
//  ViewController.m
//  KHAwesomePicture
//
//  Created by Triệu Khang on 7/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "ViewController.h"
#import "CellFactory1.h"
#import "ContentLoadingPopularViewModel.h"
#import "KHLoadingContentErrorViewModel.h"
#import "KHLoadingPopularOperation.h"

@interface ViewController ()
<
    HandleContentLoadingProtocol
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) TableController *tableController;
@property (strong, nonatomic) BasicTableViewModel *basicModel;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;
@property (strong, nonatomic) CellFactory1 *cellFactory;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
	[self.tableView addSubview:self.refreshControl];

	self.tableController = [[TableController alloc] init];

	self.tableView.dataSource = self.tableController;
    self.tableController.factory = [[CellFactory1 alloc] init];

	self.chainDelegate = [[LBDelegateMatrioska alloc] initWithDelegates:@[self.tableController, self]];
	self.tableView.delegate = (id)self.chainDelegate;

	[self onRefresh];
}

- (void)onRefresh {
    BasicTableViewModel *loadingContentSection = [[BasicTableViewModel alloc] init];
	ContentLoadingPopularViewModel *loadingContentViewModel = [[ContentLoadingPopularViewModel alloc] init];
	loadingContentSection.sectionModel = loadingContentViewModel;
	loadingContentViewModel.delegate = self;

	self.basicModel = loadingContentSection;
    self.tableController.model = self.basicModel;

	[self.tableView reloadData];

	[loadingContentViewModel loadContent];
}

#pragma mark - Data controller delegate

- (void)dataProvider:(DataProvider *)dataProvider didLoadDataAtIndexes:(NSIndexSet *)indexes {
	[self.tableView beginUpdates];
	[indexes enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
	    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
	    BOOL visible = [[self.tableView indexPathsForVisibleRows] containsObject:indexPath];
	    if (visible) {
	        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
	}];
	[self.tableView endUpdates];
}

#pragma mark - handle error

- (void)didLoadWithResultWithTotalPage:(NSInteger)totalItems error:(NSError *)error operation:(AFHTTPRequestOperation *)operation {

    [self.refreshControl endRefreshing];

	if (error) {
		BasicTableViewModel *loadingContentErrorSection = [[BasicTableViewModel alloc] initWithModel:nil];
		KHLoadingContentErrorViewModel *loadingContentErrorViewModel = [[KHLoadingContentErrorViewModel alloc] init];
		loadingContentErrorSection.sectionModel = loadingContentErrorViewModel;

		self.basicModel = loadingContentErrorSection;
		[self.tableController setModel:self.basicModel];

		[self.tableView reloadData];

		return;
	}

	DataProvider *dataProvider = [[DataProvider alloc] init];
	dataProvider.delegate = (id)self;
	dataProvider.shouldLoadAutomatically = YES;
	dataProvider.automaticPreloadMargin = 20;

	BasicTableViewModel *imageSection = [[BasicTableViewModel alloc] init];
	imageSection.sectionModel = dataProvider;

	self.basicModel = imageSection;

	[self.tableController setModel:self.basicModel];

	[dataProvider loadDataForIndex:0];
	[self.tableView reloadData];
}

- (id<KHLoadingOperationProtocol>)loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel indexes:(NSIndexSet *)indexes {
    KHLoadingPopularOperation *operation = [[KHLoadingPopularOperation alloc] initWithIndexes:indexes];
    return operation;
}

@end
