//
//  KHCollectionController.m
//  KHTableViewController
//
//  Created by Triệu Khang on 26/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHCollectionController.h"

@implementation KHCollectionController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSUInteger sections = [self.model numberOfSection];
    return sections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger numberCellInSection = [self.model numberOfItemsInSection:section];
    return numberCellInSection;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellFactory collectionView:collectionView sizeForItemAtIndexPath:indexPath model:self.model];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellFactory collectionView:collectionView cellAtIndexPath:indexPath withModel:self.model];
}

@end
