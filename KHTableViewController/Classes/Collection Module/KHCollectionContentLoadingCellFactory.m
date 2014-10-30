//
//  KHCollectionContentLoadingCellFactory.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHCollectionContentLoadingCellFactory.h"
#import "KHContentLoadingCollectionCell.h"

@implementation KHCollectionContentLoadingCellFactory

- (UICollectionViewCell<KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id<KHTableViewModel>)model {
    UICollectionViewCell<KHCellProtocol> *cell = [self _getReusableCellWithClass:[KHContentLoadingCollectionCell class] collectionView:collection atIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id<KHTableViewModel>)model {
    return collectionView.frame.size;
}

@end
