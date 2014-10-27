//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicOrderedCollectionViewController.h"
#import "KHContentLoadingCellFactory.h"
#import "KHCollectionController.h"
#import "KHOrderedDataProvider.h"
#import "KHLoadingFreshTodayOperation.h"
#import "KHPopularCollectionCellFactory.h"
#import "KHLoadingContentErrorViewModel.h"j

@interface KHBasicOrderedCollectionViewController ()
<
    KHOrderedDataProtocol,
    UICollectionViewDataSource
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

    self.cellFactory = [[KHPopularCollectionCellFactory alloc] init];
    self.collectionController.cellFactory = self.cellFactory;

    self.collectionView.dataSource = (id)self.collectionController;
    self.collectionView.delegate = (id)self.collectionController;

    KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
    KHLoadingContentErrorViewModel *loadingSecionModel = [[KHLoadingContentErrorViewModel alloc] init];
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
    KHBasicTableViewModel *content = [[KHBasicTableViewModel alloc] init];
    content.sectionModel = self.orderedDataProvider;
    self.collectionController.model = content;
    self.collectionView.delegate = (id)self.collectionController;
    [self.collectionView reloadData];
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return nil;
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
    return [[KHLoadingFreshTodayOperation alloc] initWithPage:page];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
