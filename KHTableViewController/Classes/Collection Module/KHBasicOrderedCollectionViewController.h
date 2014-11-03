//
//  KHBasicOrderedCollectionViewController.h
//  KHTableViewController
//
//  Created by Triệu Khang on 26/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHCollectionContentLoadingCellFactory.h"

@interface KHBasicOrderedCollectionViewController : UIViewController

@property (strong, nonatomic) id <KHCollectionViewCellFactoryProtocol> cellFactory;

- (void)enablePullToRefresh;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
