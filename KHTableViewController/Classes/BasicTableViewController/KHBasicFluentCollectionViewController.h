//
//  KHBasicFluentCollectionViewController.h
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHLoadingOperationProtocol.h"
#import "KHContentLoadingProtocol.h"
#import "KHTableViewSectionModel.h"
#import "KHContentLoadingCellFactory.h"
#import "KHCollectionViewCellFactoryProtocol.h"

@interface KHBasicFluentCollectionViewController : UIViewController

/**
 *  Return loading content object to load total items
 *  Subclasses has to implement
 *
 *  @return object that conforms ContentLoadingProtocol and KHTableViewSectionModel
 */
- (id <KHContentLoadingProtocol, KHTableViewSectionModel> )getLoadingTotalPageObject;

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel indexes:(NSIndexSet *)indexes;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) id<KHCollectionViewCellFactoryProtocol> cellFactory;

- (void)setEnableRefreshControl:(BOOL)enableRefreshControl;

@end
