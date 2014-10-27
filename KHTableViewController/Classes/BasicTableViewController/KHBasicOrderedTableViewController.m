//
//  KHBasicOrderedTableViewController.m
//  KHTableViewController
//
//  Created by Triệu Khang on 20/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicOrderedTableViewController.h"
#import "KHContentLoadingCellFactory.h"
#import "KHOrderedDataProvider.h"
#import "KHLoadingFreshTodayOperation.h"

@interface KHBasicOrderedTableViewController()
<
    KHOrderedDataProtocol,
    KHHandleContentLoadingProtocol
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KHTableController *tableController;
@property (strong, nonatomic) KHBasicTableViewModel *basicModel;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@property (strong, nonatomic) KHContentLoadingCellFactory *loadingCellFactory;
@property (strong, nonatomic) id<KHTableViewSectionModel> orderedDataProvider;

@end

@implementation KHBasicOrderedTableViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    self.tableController = [[KHTableController alloc] init];

    self.tableView.dataSource = self.tableController;
    self.tableController.cellFactory = self.cellFactory;

    KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
    KHBasicSectionModel *loadingSecionModel = [[KHBasicSectionModel alloc] init];
    loadingContentSection.sectionModel = loadingSecionModel;

    id<KHContentLoadingProtocol, KHTableViewSectionModel> loadingContentViewModel = [self getLoadingContentViewModel];
    loadingContentViewModel.delegate = (id)self;
    self.orderedDataProvider = loadingContentViewModel;

    self.basicModel = loadingContentSection;
    self.tableController.model = self.basicModel;

    [self.tableView reloadData];

    [loadingContentViewModel loadContent];
}

- (id<KHContentLoadingProtocol, KHTableViewSectionModel>)getLoadingContentViewModel {
    return nil;
}

- (void)dataProvider:(KHOrderedDataProvider *)dataProvider didLoadDataAtPage:(NSUInteger)page withItems:(NSArray *)items error:(NSError *)error {

}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
    return [[KHLoadingFreshTodayOperation alloc] initWithPage:page];
}


@end
