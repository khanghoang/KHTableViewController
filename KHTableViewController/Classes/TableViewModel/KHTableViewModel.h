//
//  KHTableViewModel.h
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 2/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewSectionModel.h"

@protocol KHTableViewModel <NSObject>

- (NSInteger)numberOfSection;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (id<KHTableViewSectionModel>)sectionAtIndex:(NSInteger)sectionIndex;
- (id)itemAtIndexpath:(NSIndexPath *)indexPath;

@end
