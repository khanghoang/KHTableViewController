//
//  KHCollectionContentLoadingCellFactory.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHCollectionContentLoadingCellFactory.h"
#import "KHLoadingContentTableViewCell.h"

@implementation KHCollectionContentLoadingCellFactory

- (UICollectionViewCell<KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id<KHTableViewModel>)model {
    UICollectionViewCell<KHCellProtocol> *cell = [self _getReusableCellWithClass:[KHLoadingContentTableViewCell class] collectionView:collection atIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id<KHTableViewModel>)model {
    return collectionView.frame.size;
}

#pragma mark - Private methods

- (UICollectionViewCell <KHCellProtocol> *)_getReusableCellWithClass:(Class)cellClass collectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    [self _registerTheClass:cellClass toCollectionView:collectionView];
    return [self _dequeueReuseableCellWithClass:cellClass ofCollectionView:collectionView atIndexPath:indexPath];
}

- (void)_registerTheClass:(Class)cellClass toCollectionView:(UICollectionView *)collectionView {
	UINib *cellNib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
	[collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (UICollectionViewCell <KHCellProtocol> *)_dequeueReuseableCellWithClass:(Class)cellClass ofCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell <KHCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
	return cell;
}

@end
