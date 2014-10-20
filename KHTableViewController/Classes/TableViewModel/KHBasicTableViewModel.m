//
//  BasicTableViewModel.m
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 2/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHBasicTableViewModel.h"

@interface KHBasicTableViewModel()

@property (strong, nonatomic) id<KHTableViewModel> viewModel;

@end

@implementation KHBasicTableViewModel

- (instancetype)initWithModel:(id<KHTableViewModel>)viewModel {
    self = [super init];
    if(self) {
        _viewModel = viewModel;
    }

    return self;
}

- (NSInteger)numberOfSection {
    return 1 + [self.viewModel numberOfSection];
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    if(section == 0) return self.sectionModel.count;
    return [self.viewModel numberOfItemsInSection:section-1];
}

- (id<KHTableViewSectionModel>)sectionAtIndex:(NSInteger)sectionIndex {
    if(sectionIndex == 0) return self.sectionModel;
    return [self.viewModel sectionAtIndex:sectionIndex-1];
}

- (id)itemAtIndexpath:(NSIndexPath *)indexPath
{
    id<KHTableViewSectionModel> viewSectionModel = [self sectionAtIndex:indexPath.section];
    return [viewSectionModel objectAtIndex:indexPath.row];
}

- (void)setViewModel:(id<KHTableViewModel>)viewModel {
    _viewModel = viewModel;
}

@end
