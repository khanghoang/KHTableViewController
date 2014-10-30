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
	NSArray *nibArray = @[];

	if ([[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"] != nil) {
		nibArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(cellClass) owner:nil options:nil];
		if (nibArray.count > 0) {
			UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
			[collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
			return;
		}
	}

	[collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
	return;

	NSAssert(nil, @"Can't register cell class");
}

- (UICollectionViewCell <KHCellProtocol> *)_dequeueReuseableCellWithClass:(Class)cellClass ofCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell <KHCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
	return cell;
}

@end
