//
//  KHNormalCollectionViewController.m
//  KHTableViewController
//
//  Created by Triệu Khang on 18/11/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHNormalCollectionViewController.h"
#import "KHContentLoadingCellFactory.h"
#import "KHCollectionController.h"
#import "KHNormalDataProvider.h"
#import "KHLoadingContentErrorViewModel.h"
#import "KHContentLoadingSectionViewModel.h"

@interface KHNormalCollectionViewController ()
<
    KHNormalDataProviderProtocol
>

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) KHCollectionController *collectionController;
@property (strong, nonatomic) KHBasicTableViewModel *basicModel;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@property (strong, nonatomic) KHContentLoadingCellFactory *loadingCellFactory;
@property (strong, nonatomic) id <KHTableViewSectionModel> dataProvider;

@property (strong, nonatomic) UICollectionViewFlowLayout *originLayout;


@end

@implementation KHNormalCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionController = [[KHCollectionController alloc] init];

    self.collectionController.cellFactory = self.cellFactory;

    self.collectionView.dataSource = (id)self.collectionController;
    self.collectionView.delegate = (id)self.collectionController;

    self.originLayout = (id)self.collectionView.collectionViewLayout;

    [self _onRefresh];
}

- (void)dataProvider:(KHNormalDataProvider *)dataProvider didLoadWithItems:(NSArray *)items error:(NSError *)error {

    KHBasicTableViewModel *content = [[KHBasicTableViewModel alloc] init];
    content.sectionModel = self.dataProvider;

    // set back to controller model
    self.collectionController.model = content;

    [self.collectionView reloadData];

    [self _setShouldCollectionViewLayout];
}

- (id <KHTableViewSectionModel> )getLoadingContentViewModel {
    return nil;
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel {
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - Public

- (void)reloadAlData {
    [self _onRefresh];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataProvider objectAtIndex:indexPath.item];
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
    [self.refreshControl endRefreshing];

    KHBasicTableViewModel *loadingContentSection = [[KHBasicTableViewModel alloc] init];
    KHContentLoadingSectionViewModel *loadingSecionModel = [[KHContentLoadingSectionViewModel alloc] init];
    loadingContentSection.sectionModel = loadingSecionModel;

    id <KHTableViewSectionModel> loadingContentViewModel = [self getLoadingContentViewModel];

    KHNormalDataProvider *provider = (KHNormalDataProvider *)loadingContentViewModel;
    provider.delegate = self;
    self.dataProvider = loadingContentViewModel;

    self.basicModel = loadingContentSection;
    self.collectionController.model = self.basicModel;

    [self.collectionView reloadData];

    [self _setBackToCollectionViewLayout];

    [provider startLoading];
}

- (void)_setBackToCollectionViewLayout {
    UICollectionViewFlowLayout *flowLayout = self.originLayout;
    [flowLayout setItemSize:self.collectionView.frame.size];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.collectionViewLayout = flowLayout;
    return;
}

- (void)_setShouldCollectionViewLayout {
    // if it isn't the loading flow layout means that it was changed alr
    if (![self.collectionView.collectionViewLayout isEqual:self.originLayout]) {
        return;
    }

    if ([self respondsToSelector:@selector(getCollectionViewLayout)] && [self getCollectionViewLayout]) {
        UICollectionViewLayout *layout = [self getCollectionViewLayout];
        self.collectionView.collectionViewLayout = layout;
        return;
    }
}

- (UICollectionViewLayout *)getCollectionViewLayout {
    return nil;
}

@end
