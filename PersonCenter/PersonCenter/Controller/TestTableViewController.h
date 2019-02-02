//
//  TestTableViewController.h
//  PersonCenter
//
//  Created by admin on 1/2/19.
//  Copyright © 2019年 Zhuoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmbedScrollViewControllerProtocol.h"

@interface TestTableViewController : UITableViewController<EmbedScrollViewControllerProtocol>
@property (nonatomic, assign) BOOL canScroll;
@property(nonatomic,weak)id<EmbedScrollViewControllerDelegate> delegate;
@end
