//
//  BasicTableViewModel.h
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 2/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "KHTableViewModel.h"

@interface KHBasicTableViewModel : NSObject
<
KHTableViewModel
>

@property (strong, nonatomic) id<KHTableViewSectionModel> sectionModel;

- (void)setViewModel:(id<KHTableViewModel>)viewModel;
- (instancetype)initWithModel:(id<KHTableViewModel>)viewModel;

@end
