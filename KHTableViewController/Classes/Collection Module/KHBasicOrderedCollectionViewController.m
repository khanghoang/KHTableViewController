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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) KHCollectionController *collectionController;
@property (strong, nonatomic) KHBasicTableViewModel *basicModel;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@property (strong, nonatomic) KHContentLoadingCellFactory *loadingCellFactory;
@property (strong, nonatomic) id<KHTableViewSectionModel> orderedDataProvider;

@end

@implementation KHBasicOrderedCollectionViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    self.collectionController = [[KHCollectionController alloc] init];

    self.collectionController.cellFactory = self.cellFactory;

    self.collectionView.dataSource = (id)self.collectionController;
    self.collectionView.delegate = (id)self.collectionController;

    KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
    KHContentLoadingSectionViewModel *loadingSecionModel = [[KHContentLoadingSectionViewModel alloc] init];
    loadingContentSection.sectionModel = loadingSecionModel;

    id<KHTableViewSectionModel> loadingContentViewModel = [self getLoadingContentViewModel];

    KHOrderedDataProvider *provider = (KHOrderedDataProvider *) loadingContentViewModel;
    provider.delegate = self;
    self.orderedDataProvider = loadingContentViewModel;

    self.basicModel = loadingContentSection;
    self.collectionController.model = self.basicModel;

    [self.collectionView reloadData];

    [provider startLoading];
}

- (void)dataProvider:(KHOrderedDataProvider *)dataProvider didLoadDataAtPage:(NSUInteger)page withItems:(NSArray *)items error:(NSError *)error {

    // create loadmore section
    KHBasicTableViewModel *loadMore = [[KHBasicTableViewModel alloc] initWithModel:nil];
    loadMore.sectionModel = [[KHLoadMoreSection alloc] init];

    // linked with content section
    KHBasicTableViewModel *content = [[KHBasicTableViewModel alloc] initWithModel:loadMore];
    content.sectionModel = self.orderedDataProvider;

    // set back to controller model
    self.collectionController.model = content;

    [self.collectionView reloadData];
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return nil;
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
