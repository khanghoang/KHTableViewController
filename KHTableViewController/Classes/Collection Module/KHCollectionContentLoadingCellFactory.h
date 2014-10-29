//
//  KHCollectionContentLoadingCellFactory.h
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KHCollectionViewCellFactoryProtocol.h"
#import "KHSuperCollectionCellFactory.h"

@interface KHCollectionContentLoadingCellFactory : KHSuperCollectionCellFactory
<
KHCollectionViewCellFactoryProtocol
>

@end
