//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicOrderedCollectionViewController.h"
#import "KHContentLoadingCellFactory.h"
#import "KHCollectionController.h"
#import "KHOrderedDataProvider.h"
#import "KHLoadingFreshTodayOperation.h"

@interface KHBasicOrderedCollectionViewController ()
<
    KHOrderedDataProtocol,
    KHHandleContentLoadingProtocol
>

@property (weak, nonatomic) IBOutlet UITableView *collectionView;
@property (strong, nonatomic) KHCollectionController *collectionController;
@property (strong, nonatomic) KHBasicTableViewModel *basicModel;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@property (strong, nonatomic) KHContentLoadingCellFactory *loadingCellFactory;
@property (strong, nonatomic) id<KHContentLoadingProtocol, KHTableViewSectionModel> orderedDataProvider;

@end

@implementation KHBasicOrderedCollectionViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    self.collectionController = [[KHCollectionController alloc] init];

    self.collectionView.dataSource = self.collectionController;
    self.collectionController.cellFactory = self.cellFactory;

    KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
    KHBasicSectionModel *loadingSecionModel = [[KHBasicSectionModel alloc] init];
    loadingContentSection.sectionModel = loadingSecionModel;

    id<KHContentLoadingProtocol, KHTableViewSectionModel> loadingContentViewModel = [self getLoadingContentViewModel];
    loadingContentViewModel.delegate = (id)self;
    self.orderedDataProvider = loadingContentViewModel;

    self.basicModel = loadingContentSection;
    self.collectionController.model = self.basicModel;

    [self.collectionView reloadData];

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
