//
//  BasicTableViewController.h
//  OrangeFashion
//
//  Created by Triệu Khang on 17/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewController.h"

@interface KHBasicFluentTableViewController : UIViewController

/**
 *  Return loading content object to load total items
 *  Subclasses has to implement
 *
 *  @return object that conforms ContentLoadingProtocol and KHTableViewSectionModel
 */
- (id <KHContentLoadingProtocol, KHTableViewSectionModel> )getLoadingTotalPageObject;

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel indexes:(NSIndexSet *)indexes;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) id<KHTableViewCellFactoryProtocol> cellFactory;

- (void)setEnableRefreshControl:(BOOL)enableRefreshControl;

@end
