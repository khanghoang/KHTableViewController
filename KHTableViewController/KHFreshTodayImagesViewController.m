//
//  KHFreshTodayImagesViewController.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHFreshTodayImagesViewController.h"
#import "KHContentLoadingFreshTodayViewModel.h"
#import "KHLoadingFreshTodayOperation.h"
#import "KHFreshTodayCellFactory.h"
#import "KHOrderedDataProvider.h"
#import "KHErrorLoadingMoreSectionModel.h"

@interface KHFreshTodayImagesViewController ()
<
    KHOrderedDataProtocol,
    KHHandleContentLoadingProtocol
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KHTableController *tableController;
@property (strong, nonatomic) KHBasicTableViewModel *basicModel;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;
@property (strong, nonatomic) id <KHTableViewCellFactoryProtocol> cellFactory;

@end

@implementation KHFreshTodayImagesViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.tableController = [[KHTableController alloc] init];

	self.tableView.dataSource = self.tableController;
	self.tableController.cellFactory = [[KHFreshTodayCellFactory alloc] init];

	self.chainDelegate = [[LBDelegateMatrioska alloc] initWithDelegates:@[self.tableController, self]];
	self.tableView.delegate = (id)self.chainDelegate;

	KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
	KHContentLoadingFreshTodayViewModel *loadingContentViewModel = [[KHContentLoadingFreshTodayViewModel alloc] init];
	loadingContentSection.sectionModel = loadingContentViewModel;
	loadingContentViewModel.delegate = (id)self;

	self.basicModel = loadingContentSection;
	self.tableController.model = self.basicModel;

	[self.tableView reloadData];

	[loadingContentViewModel loadContent];
}

- (void)dataProvider:(KHOrderedDataProvider *)dataProvider didLoadDataAtPage:(NSUInteger)page withItems:(NSArray *)items error:(NSError *)error {
	id <KHTableViewModel> tableViewModel;

	if (error) {
		KHBasicTableViewModel *errorLoadingMoreSection = [[KHBasicTableViewModel alloc] init];
		errorLoadingMoreSection.sectionModel = [[KHErrorLoadingMoreSectionModel alloc] init];
        tableViewModel = errorLoadingMoreSection;
	}
	else {
		KHBasicTableViewModel *loadingMoreSection = [[KHBasicTableViewModel alloc] init];
		loadingMoreSection.sectionModel = [[KHLoadMoreSection alloc] init];
        tableViewModel = loadingMoreSection;
	}

	KHBasicTableViewModel *imageSection = self.basicModel;
	[imageSection setViewModel:tableViewModel];

	if (error) {
		NSUInteger lastSectionIndex = [self.basicModel numberOfSection] - 1;
		if (lastSectionIndex > 0) {
			[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:lastSectionIndex] withRowAnimation:UITableViewRowAnimationFade];
		}
	}
	else {
		[self.tableView reloadData];
	}
}

- (void)didLoadWithResultWithTotalPage:(NSInteger)totalItems error:(NSError *)error operation:(AFHTTPRequestOperation *)operation {
	KHOrderedDataProvider *dataProvider = [[KHOrderedDataProvider alloc] init];
	dataProvider.delegate = (id)self;

	KHBasicTableViewModel *loadingMoreSection = [[KHBasicTableViewModel alloc] init];
	loadingMoreSection.sectionModel = [[KHLoadMoreSection alloc] init];

	KHBasicTableViewModel *imageSection = [[KHBasicTableViewModel alloc] initWithModel:loadingMoreSection];
	imageSection.sectionModel = dataProvider;

	self.basicModel = imageSection;

	[self.tableController setModel:self.basicModel];

	[dataProvider startLoading];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
	return [[KHLoadingFreshTodayOperation alloc] initWithPage:page];
}

@end
