//
//  EmbedScrollViewControllerProtocol.h
//  PersonalHomePageDemo
//
//  Created by Patrick on 2017/3/15.
//  Copyright © 2017年 POCO.CN. All rights reserved.
//

/**
 * 子视图通知主视图完成刷新
 */
@protocol EmbedScrollViewControllerDelegate <NSObject>
- (void)embedViewControllerDidFinishRefreshing:(UIViewController *)viewController;
@end

/**
 * 嵌入到主视图控制器中的子视图控制器必须实现此协议
 */
@protocol EmbedScrollViewControllerProtocol <NSObject>
@property (assign, nonatomic) BOOL canScroll;
@property(nonatomic,weak)id<EmbedScrollViewControllerDelegate> delegate;
- (void)refresh; // 子视图刷新
- (void)resetOffset; //子视图的contentOffset复位，回到scrollview顶部
@end

