//
//  KHBasicOrderedCollectionViewController.h
//  KHTableViewController
//
//  Created by Triệu Khang on 26/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHCollectionContentLoadingCellFactory.h"
#import "KHLoadingOperationProtocol.h"

@protocol KHBasicOrderedCollectionViewControllerProtocol <NSObject>

@required
- (UICollectionView *)collectionView;
- (id<KHCollectionViewCellFactoryProtocol>)cellFactory;
- (id<KHTableViewSectionModel>)getLoadingContentViewModel;
- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page;

@optional
- (UICollectionViewLayout *)getCollectionViewLayout;

@end

@interface KHBasicOrderedCollectionViewController : UIViewController

@property (strong, nonatomic) id <KHCollectionViewCellFactoryProtocol> cellFactory;

- (void)enablePullToRefresh;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
