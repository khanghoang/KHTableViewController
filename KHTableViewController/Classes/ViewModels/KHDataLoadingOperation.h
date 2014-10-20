//
//  DataLoadingOperation.h
//  FluentResourcePaging-example
//
//  Created by Alek Astrom on 2014-04-11.
//  Copyright (c) 2014 Alek Åström. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHTableViewController.h"

@interface KHDataLoadingOperation : NSBlockOperation
<
    KHLoadingOperationProtocol
>

@end
