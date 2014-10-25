//
//  KHCollectionController.h
//  KHTableViewController
//
//  Created by Triệu Khang on 26/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KHTableViewModel.h"
#import "KHCollectionViewCellFactoryProtocol.h"

@interface KHCollectionController : NSObject
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) id<KHTableViewModel> model;
@property (strong, nonatomic) id<KHCollectionViewCellFactoryProtocol> cellFactory;

@end
