//
//  ContentViewCell.h
//  PersonalHomePageDemo
//
//  Created by Kegem Huang on 2017/3/15.
//  Copyright © 2017年 huangkejin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentViewCell;

@interface ContentViewCell : UITableViewCell

//子控制器是否可以滑动  YES可以滑动
@property (nonatomic, assign) BOOL canScroll;
//外部segment点击更改selectIndex,切换页面
- (void)selectedBar:(NSInteger)tabIndex;
@property (nonatomic, copy) void (^scrolleSelected)(NSInteger);

-(void)refreshIndex:(NSInteger)index;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier controllers:(NSArray<UIViewController*> *)controller;
@end
