//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicOrderedCollectionViewController.h"
#import "KHContentLoadingCellFactory.h"
#import "KHCollectionController.h"
#import "KHOrderedDataProvider.h"
#import "KHLoadingContentErrorViewModel.h"
#import "KHContentLoadingSectionViewModel.h"

@interface KHBasicOrderedCollectionViewController ()
<
KHOrderedDataProtocol
>

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) KHCollectionController *collectionController;
@property (strong, nonatomic) KHBasicTableViewModel *basicModel;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@property (strong, nonatomic) KHContentLoadingCellFactory *loadingCellFactory;
@property (strong, nonatomic) id <KHTableViewSectionModel> orderedDataProvider;

@end

@implementation KHBasicOrderedCollectionViewController

- (void)viewDidLoad {
    self.collectionController = [[KHCollectionController alloc] init];

    self.collectionController.cellFactory = self.cellFactory;

    self.collectionView.dataSource = (id)self.collectionController;
    self.collectionView.delegate = (id)self.collectionController;

    [self _onRefresh];
}

- (void)dataProvider:(KHOrderedDataProvider *)dataProvider didLoadDataAtPage:(NSUInteger)page withItems:(NSArray *)items error:(NSError *)error {
    KHBasicTableViewModel *loadMore = nil;
    if (!dataProvider.isReachMaxPage) {
        // create loadmore section
        loadMore = [[KHBasicTableViewModel alloc] initWithModel:nil];
        loadMore.sectionModel = [[KHLoadMoreSection alloc] init];
    }

    // linked with content section
    KHBasicTableViewModel *content = [[KHBasicTableViewModel alloc] initWithModel:loadMore];
    content.sectionModel = self.orderedDataProvider;

    // set back to controller model
    self.collectionController.model = content;

    [self.collectionView reloadData];
}

- (id <KHTableViewSectionModel> )getLoadingContentViewModel {
    return nil;
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - Public

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.orderedDataProvider objectAtIndex:indexPath.item];
}

- (void)enablePullToRefresh {
    [self _addPullRefresh];
}

#pragma mark - Pull refresh

- (void)_addPullRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(_onRefresh) forControlEvents:UIControlEventValueChanged];
}

- (void)_onRefresh {
    KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
    KHContentLoadingSectionViewModel *loadingSecionModel = [[KHContentLoadingSectionViewModel alloc] init];
    loadingContentSection.sectionModel = loadingSecionModel;

    id <KHTableViewSectionModel> loadingContentViewModel = [self getLoadingContentViewModel];

    KHOrderedDataProvider *provider = (KHOrderedDataProvider *)loadingContentViewModel;
    provider.delegate = self;
    self.orderedDataProvider = loadingContentViewModel;

    self.basicModel = loadingContentSection;
    self.collectionController.model = self.basicModel;
    
    [self.collectionView reloadData];
    
    [provider startLoading];
}

@end
