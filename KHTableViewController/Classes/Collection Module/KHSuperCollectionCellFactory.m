//
//  KHSuperCollectionCellFactory.m
//  KHTableViewController
//
//  Created by Triệu Khang on 29/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHSuperCollectionCellFactory.h"

@implementation KHSuperCollectionCellFactory

- (UICollectionViewCell <KHCellProtocol> *)_getReusableCellWithClass:(Class)cellClass collectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
	[self _registerTheClass:cellClass toCollectionView:collectionView];
	return [self _dequeueReuseableCellWithClass:cellClass ofCollectionView:collectionView atIndexPath:indexPath];
}

- (void)_registerTheClass:(Class)cellClass toCollectionView:(UICollectionView *)collectionView {
	UINib *cellNib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
	if (cellNib) {
		[collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
		return;
	}

	[collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (UICollectionViewCell <KHCellProtocol> *)_dequeueReuseableCellWithClass:(Class)cellClass ofCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell <KHCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
	return cell;
}

@end
