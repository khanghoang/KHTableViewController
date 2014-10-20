//
//  KHTableViewSectionFactoryProtocol.h
//  KHCleanTableViewController
//
//  Created by Triệu Khang on 2/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewModel.h"

@protocol KHTableViewSectionFactoryProtocol <NSObject>

- (UIView *)sectionAtIndex:(NSInteger)sectionIndex model:(id<KHTableViewModel>)model;

@end
