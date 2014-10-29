//
//  KHPopularCollectionCellFactory.m
//  KHTableViewController
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHPopularCollectionCellFactory.h"
#import "KHLoadMoreSection.h"
#import "KHLoadingContentTableViewCell.h"
#import "KHLoadingContentErrorViewModel.h"
#import "ContentLoadingPopularViewModel.h"
#import "KHImageCollectionViewCell.h"
#import "KHContentLoadingErrorCollectionViewCell.h"
#import "KHContentLoadingCollectionCell.h"

@implementation KHPopularCollectionCellFactory

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id <KHTableViewModel> )model {
	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
		return CGSizeMake(collectionView.frame.size.width, 40);
	}

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[ContentLoadingPopularViewModel class]]) {
		return collectionView.frame.size;
	}

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadingContentErrorViewModel class]]) {
		return collectionView.frame.size;
	}

    // regular image cell size
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.width);
}

- (UICollectionViewCell<KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id<KHTableViewModel>)model {
	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[ContentLoadingPopularViewModel class]]) {
        return [self _getReusableCellWithClass:[KHContentLoadingCollectionCell class] collectionView:collection atIndexPath:indexPath];
	}

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadingContentErrorViewModel class]]) {
        return [self _getReusableCellWithClass:[KHContentLoadingErrorCollectionViewCell class] collectionView:collection atIndexPath:indexPath];
	}

	id data = [model itemAtIndexpath:indexPath];

    UICollectionViewCell <KHCellProtocol> *cell = [self _getReusableCellWithClass:[KHImageCollectionViewCell class] collectionView:collection atIndexPath:indexPath];
	[cell configWithData:data];
	return cell;
}

@end
