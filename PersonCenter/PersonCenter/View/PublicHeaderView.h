//
//  PublicHeaderView.h
//  photo
//
//  Created by mac--yaoyinglong on 2017/10/11.
//  Copyright © 2017年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCoverHeaderHeight 160.0f

@class UserModel;

@protocol PublicHeaderDelegate <NSObject>

- (void)onClickFocusCnt:(id)sender;

- (void)onClickFansCnt:(id)sender;

- (void)onClickActCnt:(id)sender;

- (void)onClickFocus:(id)sender;

@optional
- (void)onClickAvatar:(id)sender;
- (void)onClickLogin;
- (void)onClickCertify:(id)sender;
@end

/**
 个人主页的headView有三种情况
 1、UserHeaderViewTypeOther，别人的个人资料页，需要显示关注按钮
 2、UserHeaderViewTypeMy, 登录状态下的我的个人资料页，隐藏了关注按钮
 3、UserHeaderViewTypeNotLogin,未登录状态下的我的个人资料页，显示立即登录按钮，代替昵称和个性签名
 这三种的控件高度，UserHeaderViewTypeMy和UserHeaderViewTypeNotLogin可以取一样的高度，
 而UserHeaderViewTypeOther的高度则比前者高出一定高度
 */
typedef NS_ENUM(NSUInteger,UserHeaderViewType){
    UserHeaderViewTypeOther=0, //  别人的个人主页
    UserHeaderViewTypeMy,  // 我的个人主页
    UserHeaderViewTypeNotLogin //我的主页（未登录时)
};

@interface  PublicHeaderView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) UserHeaderViewType type;
@property (nonatomic, weak) id<PublicHeaderDelegate> MyDelegate;
@property (nonatomic, assign) CGFloat offsetY;

// parallax background origin Y for parallaxHeight
@property (nonatomic, assign) CGFloat parallaxHeight; // default is 170， this height was not self heigth.

@property (nonatomic, assign) BOOL isZoomingEffect; // default is NO， if isZoomingEffect is YES, will be dissmiss parallax effect
@property (nonatomic, assign) BOOL isLightEffect; // default is YES
@property (nonatomic, assign) CGFloat lightEffectPadding; // default is 80
@property (nonatomic, assign) CGFloat lightEffectAlpha; // default is 1.12 (between 1 - 2)

@property (nonatomic, copy) void(^handleRefreshEvent)(void);

- (void)setInfo:(UserModel *)info;

@end
