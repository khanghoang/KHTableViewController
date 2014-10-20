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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellFactory = [[CellFactory1 alloc] init];
}

//- (void)onRefresh {
//    KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
//	ContentLoadingPopularViewModel *loadingContentViewModel = [[ContentLoadingPopularViewModel alloc] init];
//	loadingContentSection.sectionModel = loadingContentViewModel;
//	loadingContentViewModel.delegate = self;
//
//	self.basicModel = loadingContentSection;
//    self.tableController.model = self.basicModel;
//
//	[self.tableView reloadData];
//
//	[loadingContentViewModel loadContent];
//}

- (id<KHContentLoadingProtocol, KHTableViewSectionModel>)getLoadingTotalPageObject {
	ContentLoadingPopularViewModel *loadingTotalItems = [[ContentLoadingPopularViewModel alloc] init];
	loadingTotalItems.delegate = (id)self;
	[loadingTotalItems loadContent];
    return loadingTotalItems;
}

#pragma mark - handle error

//- (void)didLoadWithResultWithTotalPage:(NSInteger)totalItems error:(NSError *)error operation:(AFHTTPRequestOperation *)operation {
//
//    [self.refreshControl endRefreshing];
//
//	if (error) {
//		KHBasicTableViewModel *loadingContentErrorSection = [[KHBasicTableViewModel alloc] initWithModel:nil];
//		KHLoadingContentErrorViewModel *loadingContentErrorViewModel = [[KHLoadingContentErrorViewModel alloc] init];
//		loadingContentErrorSection.sectionModel = loadingContentErrorViewModel;
//
//		self.basicModel = loadingContentErrorSection;
//		[self.tableController setModel:self.basicModel];
//
//		[self.tableView reloadData];
//
//		return;
//	}
//
//	KHFluentDataProvider *dataProvider = [[KHFluentDataProvider alloc] init];
//	dataProvider.delegate = (id)self;
//	dataProvider.shouldLoadAutomatically = YES;
//	dataProvider.automaticPreloadMargin = 20;
//
//	KHBasicTableViewModel *imageSection = [[KHBasicTableViewModel alloc] init];
//	imageSection.sectionModel = dataProvider;
//
//	self.basicModel = imageSection;
//
//	[self.tableController setModel:self.basicModel];
//
//	[dataProvider loadDataForIndex:0];
//	[self.tableView reloadData];
//}

- (id<KHLoadingOperationProtocol>)loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel indexes:(NSIndexSet *)indexes {
    KHLoadingPopularOperation *operation = [[KHLoadingPopularOperation alloc] initWithIndexes:indexes];
    return operation;
}

@end
