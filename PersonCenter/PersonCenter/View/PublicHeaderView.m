//
//  PublicHeaderView.m
//  PersonCenter
//
//  Created by zhuoyu on 2017/9/27.
//  Copyright © 2017年 ColorFish All rights reserved.
//

#import "PublicHeaderView.h"
//#import "UIImage+ImageEffects.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIImageHelper.h"
//#import "CirclePullRefresh.h"
#import "UIImage+ImageWithColor.h"
//#import "CircleRing.h"
//#import "ViewUtils.h"
#import "ProfileButton.h"
//#import "SMPageControl.h"
//#import "ZYRelationButton.h"
//#import "GTMNSString+HTML.h"
#import "UserModel.h"
//#import "BlogInfo.h"
#import "YYText.h"
//#import "ReplyCell.h"
//#import "NSAttributedString+YYText.h"
//#import "NickNameUtils.h"

#define photoHeight 140.0*KiPhone6Radio
#define btnWidth  (CGRectGetWidth(self.bottomView.frame) / 3.0)
#define btnHeight  72*KiPhone6Radio

@interface PublicHeaderView ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) YYLabel *userNameLabel;
@property (nonatomic, strong) UIImageView *sepLine;
@property (nonatomic, strong) UILabel *signature;
@property (nonatomic, strong) ProfileButton *actCnt;
@property (nonatomic, strong) ProfileButton *focus;
@property (nonatomic, strong) ProfileButton *fans;
@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, assign) CGFloat showUserInfoViewOffsetHeight;
@property (nonatomic, assign) CGFloat showRefreshOffsetHeight;
@property (nonatomic, strong) UIImage *placeholder;
@property (nonatomic, strong) UIButton *unLoginButton;
@property (nonatomic, strong) UIButton *concernButton;
@property (nonatomic, strong) UIImageView *identify;

@end

@implementation PublicHeaderView

#pragma mark - Publish Api
- (void)setInfo:(UserModel *)info {
    if (!info) {
        return;
    }
    
    if (self.type == UserHeaderViewTypeOther) {
        [self.concernButton setHidden:NO];
        [self.unLoginButton setHidden:YES];
        [self.userNameLabel setHidden:NO];
        [self.signature setHidden:NO];
    } else if (self.type == UserHeaderViewTypeMy){
        [self.concernButton setHidden:YES];
        [self.unLoginButton setHidden:YES];
        [self.userNameLabel setHidden:NO];
        [self.signature setHidden:NO];
    } else {
        [self.concernButton setHidden:YES];
        [self.unLoginButton setHidden:NO];
        [self.userNameLabel setHidden:YES];
        [self.signature setHidden:YES];
    }

    self.userNameLabel.text = info.nickname;
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *iconImageStr = [[NSString alloc] init];
    NSString *userIcon = info.avatar;
    if (userIcon.length) {
        //iconImageStr = POCO_IMG_URL_SIZE(userIcon, @"S120");
    }
    if (userIcon && [userIcon length]>0) {
        __weak typeof(self) weakSelf = self;
        [self.avatarButton sd_setImageWithURL:[NSURL URLWithString:iconImageStr]
                                     forState:UIControlStateNormal
                             placeholderImage:_placeholder
                                      options:SDWebImageLowPriority
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        if (image) {
                                            CGFloat imageWidth = CGRectGetWidth(weakSelf.avatarButton.frame);
                                            UIImage *squareImage = [image cutCenterImage:CGSizeMake(imageWidth*2, imageWidth*2)];
                                            [weakSelf.avatarButton setImage:squareImage forState:UIControlStateNormal];
                                            [weakSelf.avatarButton setImage:squareImage forState:UIControlStateHighlighted];
                                        }
                                    }];
        
    }
    
    NSInteger actCnt = info.actCnt;
    NSInteger fansCnt = info.fansCnt;
    NSInteger followCnt = info.followCnt;
    NSInteger isFollewed = info.relation;

    if (actCnt>0) {
        [self.actCnt setNumber:[NSString stringWithFormat:@"%ld", actCnt]];
    } else {
        [self.actCnt setNumber:@"0"];
    }
    
    if (fansCnt>0) {
        [self.fans setNumber:[NSString stringWithFormat:@"%ld", fansCnt]];
    } else {
        [self.fans setNumber:@"0"];
    }
    
    if (followCnt>0) {
        [self.focus setNumber:[NSString stringWithFormat:@"%ld",followCnt]];
    } else {
        [self.focus setNumber:@"0"];
    }
    
    if (isFollewed) {
        self.concernButton.selected = YES;
        self.concernButton.layer.borderColor = RGBCOLOR(140, 194, 234).CGColor;
        [self.concernButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        self.concernButton.selected = NO;
        self.concernButton.layer.borderColor = RGBCOLOR(44, 114, 172).CGColor;
        [self.concernButton setImage:[UIImage imageNamed:@"hr_relation_not_focus"] forState:UIControlStateNormal];
        self.concernButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.0);
    }
    
    if ([info.signature length]>0) {
        self.signature.text = info.signature;
    } else {
        self.signature.text = @"这个人很懒，什么都没有写";
    }
    
}
#pragma mark - Propertys
- (void)setType:(UserHeaderViewType)type {
    _type = type;
    
    switch (type) {
        case UserHeaderViewTypeOther:
            self.unLoginButton.hidden = YES;
            self.concernButton.hidden = NO;
            break;
        case UserHeaderViewTypeMy:
            self.unLoginButton.hidden = YES;
            self.concernButton.hidden = YES;
            break;
        case UserHeaderViewTypeNotLogin:
            self.userNameLabel.hidden = YES;
            self.signature.hidden = YES;
            self.unLoginButton.hidden = NO;
            break;
        default:
            break;
    }
    
}

#pragma mark - Life cycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(245, 245, 245);
        [self _setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    self.parallaxHeight = 40;//170;
    self.isLightEffect = NO;
    self.isZoomingEffect = YES;
    self.lightEffectPadding = 80;
    self.lightEffectAlpha = 1.15;
    [self initShowView];
}

- (void)dealloc {
    self.avatarButton = nil;
    self.userNameLabel = nil;
    self.unLoginButton = nil;
    self.bannerView = nil;
    self.showView = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if(newSuperview) {
    }
}

- (void)initShowView {
    
    self.showUserInfoViewOffsetHeight = 0;
  //  CGFloat avatarBorderWidth = 1.5f;
   // CGFloat avatarButtonHeight = 64*KiPhone6Radio;
//    CircleRing* borderRing = [[CircleRing alloc] initWithPosition:CGPointMake(self.avatarButton.frame.origin.x-avatarBorderWidth, self.avatarButton.frame.origin.y-avatarBorderWidth) radius:avatarButtonHeight/2+avatarBorderWidth internalRadius:avatarButtonHeight/2 circleStrokeColor:HexRGBAlpha(0xffffff, 0.1)];
//    borderRing.userInteractionEnabled = NO;
    
    [self.showView addSubview:self.avatarButton];
    //[self.showView addSubview:borderRing];
    CGFloat bottomHeight = CGRectGetHeight(self.showView.frame)-CGRectGetHeight(self.bannerView.frame);
    UIImageView* sepLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(btnWidth, bottomHeight-45.0*KiPhone6Radio, kSepLineHeight, 20*KiPhone6Radio)];
    sepLine2.backgroundColor = HexRGB(0xdddddd);
    UIImageView* sepLine3 = [[UIImageView alloc] initWithFrame:CGRectMake(btnWidth*2+CGRectGetWidth(sepLine2.frame), bottomHeight-45.0*KiPhone6Radio, kSepLineHeight, 20*KiPhone6Radio)];
    sepLine3.backgroundColor = HexRGB(0xdddddd);
    
    [self addSubview:self.showView];
    [self.showView addSubview:self.bottomView];
    [self.bottomView addSubview:self.actCnt];
    [self.bottomView addSubview:self.focus];
    [self.bottomView addSubview:self.fans];
    [self.bottomView addSubview:sepLine2];
    [self.bottomView addSubview:sepLine3];
    [self.bottomView addSubview:self.concernButton];
    [self.showView bringSubviewToFront:self.avatarButton];
    //[self.showView addSubview:self.identify];
    
//    if (![LoginUtils isLogin]) {
//        [self.bottomView bringSubviewToFront:self.unLoginButton];
//    }else{
//        [self.bottomView sendSubviewToBack:self.unLoginButton];
//    }
}

// 设置头像
- (void)setAvatarImage:(UIImage *)avatarImage {
    if (avatarImage) {
        [_avatarButton setImage:avatarImage forState:UIControlStateNormal];
        [_avatarButton setImage:avatarImage forState:UIControlStateHighlighted];
    }
}

- (void)setAvatarUrlString:(NSString *)avatarUrlString {
    if (avatarUrlString) {
    }
}
#pragma mark ------GETTER-------
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, self.showUserInfoViewOffsetHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-10)];
        _showView.backgroundColor = [UIColor clearColor];
    }
    return _showView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        CGFloat bottomHeight = CGRectGetHeight(self.showView.frame)-CGRectGetHeight(self.bannerView.frame);
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.bannerView.frame), CGRectGetWidth(self.frame), bottomHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (YYLabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[YYLabel alloc] initWithFrame:CGRectMake(20, 52.0*KiPhone6Radio, CGRectGetWidth(_showView.frame)-40, 19.0*KiPhone6Radio+2)];
        _userNameLabel.textColor = HexRGB(0x222222);
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.numberOfLines = 1;
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.font = [UIFont boldSystemFontOfSize:19.0f*KiPhone6Radio];
        _userNameLabel.hidden = YES;
        [self.bottomView addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

- (UILabel *)signature {
    if (!_signature) {
        _signature = [[UILabel alloc] initWithFrame:CGRectMake(45.0*KiPhone6Radio,CGRectGetMaxY(self.userNameLabel.frame)+12*KiPhone6Radio, CGRectGetWidth(self.frame)-90*KiPhone6Radio,12.0*KiPhone6Radio+2)];
        _signature.textColor =HexRGB(0x666666);
        _signature.backgroundColor = [UIColor clearColor];
        _signature.font = [UIFont systemFontOfSize:12.0f/**KiPhone6Radio*/];
        _signature.textAlignment = NSTextAlignmentCenter;
        _signature.hidden = YES;
        [self.bottomView addSubview:_signature];
    }
    return _signature;
}

- (UIButton *)unLoginButton {
    if (!_unLoginButton) {
        _unLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _unLoginButton.frame = CGRectMake((SCREEN_WIDTH-140.0*KiPhone6Radio)/2.0,52.0*KiPhone6Radio, 140*KiPhone6Radio, 44.0*KiPhone6Radio);
        [_unLoginButton addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
        _unLoginButton.backgroundColor = RGBCOLOR(63, 154, 219);
        _unLoginButton.layer.cornerRadius = 10.0*KiPhone6Radio;
        [_unLoginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        _unLoginButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        //_unLoginButton.hidden = [LoginUtils isLogin];
        [_unLoginButton setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
        NSLog(@"%d",_unLoginButton.isHidden);
        [self.bottomView addSubview:_unLoginButton];
    }
    return _unLoginButton;
}

- (UIButton *)avatarButton {
    if (!_avatarButton) {
        CGFloat avatarButtonHeight = 64*KiPhone6Radio;
        _placeholder =[UIImage imageNamed:@"user_default.png"];
        _avatarButton = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.showView.frame)-avatarButtonHeight)/2, 64, avatarButtonHeight, avatarButtonHeight)];
        _avatarButton.center = CGPointMake(SCREEN_WIDTH/2.0, CGRectGetMaxY(self.bannerView.frame));
        [_avatarButton addTarget:self action:@selector(onClickAvatar:) forControlEvents:UIControlEventTouchUpInside];
        [_avatarButton setImage:_placeholder forState:UIControlStateNormal];
        _avatarButton.backgroundColor = [UIColor lightGrayColor];
        _avatarButton.layer.cornerRadius = avatarButtonHeight / 2 ;
        _avatarButton.clipsToBounds = YES;
    }
    return _avatarButton;
}

- (ProfileButton *)actCnt {
    if (!_actCnt) {
        _actCnt = [[ProfileButton alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(self.bottomView.frame)-btnHeight, btnWidth, btnHeight)];
        [_actCnt setTitle:@"文章"];
        [_actCnt setTitleFont:[UIFont systemFontOfSize:11.0f]];
        [_actCnt setTitleColor:HexRGB(0x666666) forState:UIControlStateNormal];
        [_actCnt setTitleColor:HexRGB(0x666666) forState:UIControlStateHighlighted];
        [_actCnt setNumber:@"--"];
        [_actCnt setNumberFont:[UIFont boldSystemFontOfSize:17.0f]];
        [_actCnt setNumberColor:HexRGB(0x333333) forState:UIControlStateNormal];
        [_actCnt setNumberColor:HexRGB(0x333333) forState:UIControlStateHighlighted];
        [_actCnt addTarget:self action:@selector(onClickActCnt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _actCnt;
}

- (ProfileButton *)focus {
    if (!_focus) {
        _focus = [[ProfileButton alloc] initWithFrame:CGRectMake(btnWidth*1,CGRectGetHeight(self.bottomView.frame)-btnHeight, btnWidth, btnHeight)];
        [_focus setTitle:@"关注"];
        [_focus setTitleFont:[UIFont systemFontOfSize:11.0f]];
        [_focus setTitleColor:HexRGB(0x666666) forState:UIControlStateNormal];
        [_focus setTitleColor:HexRGB(0x666666) forState:UIControlStateHighlighted];
        [_focus setNumber:@"--"];
        [_focus setNumberFont:[UIFont boldSystemFontOfSize:17.0f]];
        [_focus setNumberColor:HexRGB(0x333333) forState:UIControlStateNormal];
        [_focus setNumberColor:HexRGB(0x333333) forState:UIControlStateHighlighted];
        [_focus addTarget:self action:@selector(onClickFocusCnt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focus;
}

- (ProfileButton *)fans {
    if (!_fans) {
        _fans = [[ProfileButton alloc] initWithFrame:CGRectMake(btnWidth*2,CGRectGetHeight(self.bottomView.frame)-btnHeight, btnWidth, btnHeight)];
        [_fans setTitle:@"粉丝"];
        [_fans setTitleFont:[UIFont systemFontOfSize:11.0f]];
        [_fans setTitleColor:HexRGB(0x666666) forState:UIControlStateNormal];
        [_fans setTitleColor:HexRGB(0x666666) forState:UIControlStateHighlighted];
        [_fans setNumber:@"--"];
        [_fans setNumberFont:[UIFont boldSystemFontOfSize:17.0f]];
        [_fans setNumberColor:HexRGB(0x333333) forState:UIControlStateNormal];
        [_fans setNumberColor:HexRGB(0x333333) forState:UIControlStateHighlighted];
        [_fans addTarget:self action:@selector(onClickFansCnt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fans;
}

- (UIButton *)concernButton {
    if (!_concernButton) {
        _concernButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _concernButton.frame = CGRectMake((CGRectGetWidth(self.bottomView.frame)-55.0*KiPhone6Radio)/2.0, CGRectGetMaxY(self.signature.frame)+15.0*KiPhone6Radio, 55.0*KiPhone6Radio, 28.0*KiPhone6Radio);
        [_concernButton addTarget:self action:@selector(clickconcern:) forControlEvents:UIControlEventTouchUpInside];
        _concernButton.layer.cornerRadius = 4.0*KiPhone6Radio;
        _concernButton.layer.borderColor = RGBCOLOR(44, 114, 172).CGColor;
        _concernButton.layer.borderWidth = 1.0*KiPhone6Radio;
        [_concernButton setTitle:@"关注" forState:UIControlStateNormal];
        _concernButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5.0, 0, 0);
        _concernButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_concernButton setTitleColor:RGBCOLOR(44, 114, 172) forState:UIControlStateNormal];
        [_concernButton setImage:[UIImage imageNamed:@"hr_relation_not_focus"] forState:UIControlStateNormal];
        _concernButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.0);
        [_concernButton setTitle:@"已关注" forState:UIControlStateSelected];
        [_concernButton setTitleColor:RGBCOLOR(140, 194, 234) forState:UIControlStateSelected];
        _concernButton.hidden = YES;
    }
    return _concernButton;
}

#pragma mark - 按钮事件
- (void)goLogin {
    if (self.MyDelegate && [self.MyDelegate respondsToSelector:@selector(onClickLogin)]) {
        [self.MyDelegate onClickLogin];
    }
}

- (void)onClickFocusCnt:(id)sender {
    if (self.MyDelegate && [self.MyDelegate respondsToSelector:@selector(onClickFocusCnt:)]) {
        [self.MyDelegate onClickFocusCnt:sender];
    }
}

- (void)onClickFansCnt:(id)sender {
    if (self.MyDelegate && [self.MyDelegate respondsToSelector:@selector(onClickFansCnt:)]) {
        [self.MyDelegate onClickFansCnt:sender];
    }
}

- (void)onClickActCnt:(id)sender {
    if (self.MyDelegate && [self.MyDelegate respondsToSelector:@selector(onClickActCnt:)]) {
        [self.MyDelegate onClickActCnt:sender];
    }
}

-(void)onClickFocus:(id)sender {
    if (self.MyDelegate && [self.MyDelegate respondsToSelector:@selector(onClickFocus:)]) {
        [self.MyDelegate onClickFocus:sender];
    }
}

- (void)onClickAvatar:(id)sender {
    if (self.MyDelegate && [self.MyDelegate respondsToSelector:@selector(onClickAvatar:)]) {
        [self.MyDelegate onClickAvatar:sender];
    }
}

- (void)clickconcern:(id)sender{
    if (self.MyDelegate && [self.MyDelegate respondsToSelector:@selector(onClickFocus:)]) {
        [self.MyDelegate onClickFocus:sender];
    }
}

@end
