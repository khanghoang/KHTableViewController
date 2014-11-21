//
//  KHNormalCollectionViewController.h
//  KHTableViewController
//
//  Created by Triệu Khang on 18/11/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHCollectionContentLoadingCellFactory.h"
#import "KHLoadingOperationProtocol.h"

@protocol KHNormalCollectionViewControllerProtocol <NSObject>

@required
- (UICollectionView *)collectionView;
- (id<KHCollectionViewCellFactoryProtocol>)cellFactory;
- (id<KHTableViewSectionModel>)getLoadingContentViewModel;
- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel;
- (void)collectionDidReloadWithItems:(NSArray *)items;

@optional
- (UICollectionViewLayout *)getCollectionViewLayout;

@end

@interface KHNormalCollectionViewController : UIViewController

@property (strong, nonatomic) id <KHCollectionViewCellFactoryProtocol> cellFactory;

- (void)reloadAlData;
- (void)enablePullToRefresh;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
