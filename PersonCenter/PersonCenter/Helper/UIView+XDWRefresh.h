//
//  UIView+XDRefresh.h
//  仿微信朋友圈下拉刷新
//  作者：谢兴达（XD）
//  Created by 谢兴达 on 2017/4/14.
//  Copyright © 2017年 谢兴达. All rights reserved.
//  https://github.com/Xiexingda/XDRefresh.git

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,StatusOfRefresh) {
    XDREFRESH_Default = 1,     //非刷新状态，该值不能为0
    XDREFRESH_BeginRefresh,    //刷新状态
    XDREFRESH_None             //全非状态（即不是刷新 也不是 非刷新状态）
};

@class XDRefreshView;

@interface UIView (XDWRefresh)
// 监测范围的临界点,>0代表向上滑动多少距离,<0则是向下滑动多少距离
@property (nonatomic, assign)CGFloat threshold;

//scrollerView 的起始Y坐标 有导航栏顶着导航栏的时候Y坐标为0 没有导航栏顶着屏幕顶部为-64 根据实际情况给值
@property (nonatomic, assign)CGFloat scrollerOriginY;

//下拉多少后可以进行刷新 比如64 则表示往下拉的contentoffSetY 大于64开始可以刷新 0的话则一拉动就可以刷新了
@property (nonatomic, assign)CGFloat refreshStartY;

// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;

//记录刷新状态
@property (nonatomic, assign)StatusOfRefresh refreshStatus;

//用于刷新回调
@property (nonatomic, copy)void(^refreshBlock)(void);

//刷新动画
@property (nonatomic, strong) CABasicAnimation *animation;

//偏移量累加
@property (nonatomic, assign) CGFloat offsetCollect;

//刷新view
@property (nonatomic, strong) XDRefreshView *refreshView;

//只是用来当一个全局变量防止内存泄露的
@property (nonatomic, strong) NSTimer *timers;

//用于承接需要刷新的下拉刷新的extenScrollView
@property (nonatomic, strong) UIScrollView *extenScrollView;
//release 掉还在执行的线程 (该属性请勿动用)
//@property (nonatomic, assign) BOOL isRemoveThread;
/**
 下拉刷新
 
 @param scrollView 需要添加刷新的tableview
 @param position icon位置（默认：{10，34}navBar左上角）
 @param block 刷新回调
 */
- (void)XD_refreshWithObject:(UIScrollView *)scrollView atPoint:(CGPoint)position downRefresh:(void(^)(void))block;

/**
 结束刷新动作
 */
- (void)XD_endRefresh;

/**
 释放观察者
 */
- (void)XD_freeReFresh;

@end



@interface XDRefreshView : UIScrollView
//刷新view的icon
@property (nonatomic, strong)UIImageView *refreshIcon;

@end

