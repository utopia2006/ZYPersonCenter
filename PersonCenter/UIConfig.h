//
//  UIConfig.h
//  PersonCenter
//
//  Created by zhuoyu on 14-11-7.
//  Copyright (c) 2019年 ColorFish All rights reserved.
//

#ifndef photo_UIConfig_h
#define photo_UIConfig_h

/**
 * 尺寸
 */
static const int kUserIconWidth    = 40;
static const int kNewUserIconWidth = 35;
static const int kMaxTimeWidth     = 115;
static const int kCellBtnWidth     = 60;
static const int kCellBtnHeight    = 30;
static const int kCellHeaderHeight = 55;
static const int kCellFooterHeight = 50;
static const int kCellLeftMargin   = 10;
static const int kCellTopMargin    = 10;
static const int kCellHSpace       = 10;
static const int kCellVSpace       = 10;
static const int kCellSepSpace     = 15;

static const CGFloat kActionBarHeight = 40;
static const CGFloat kTagBarHeight = 30;

/**
 * 字体
 */
#define kSmallFont [UIFont systemFontOfSize:14.0f]
#define kMidFont   [UIFont systemFontOfSize:16.0f]
#define kLargeFont [UIFont systemFontOfSize:18.0f]


/**
 * 颜色
 */
#define kNavBarBg HexRGB(0x222222)
#define kLightGrayBg HexRGB(0xf5f5f5)
#define kImagePlaceholderBg HexRGB(0xe1e1e1)
#define kSelectedItemBg HexRGB(0xf2f2f2)

#define kTextColorCCC HexRGB(0xcccccc)
#define kTextColor333 HexRGB(0x333333)
#define kTextColor666 HexRGB(0x666666)
#define kTextColor999 HexRGB(0x999999)
#define kTextColor222 HexRGB(0x222222)
#define kTimeColor HexRGB(0xcccccc)

#define kSepLineHeight  (isRetina?0.5f:1.0f)
#define kSepLineColor HexRGB(0xe6e6e6)
#define kBorderWidth  kSepLineHeight
#define kBorderColor kSepLineColor
#define kSepBarHeight  10
#define kSepBarColor HexRGB(0xf2f2f2)

#define kDarkBlue HexRGB(0x2c72ac)
#define kLightBlue HexRGB(0x3f9adc)
#define kNoticeRed HexRGB(0xda4643)
#define kDarkBlack  HexRGB(0x666666)

#define COMMON_LINK_COLOR kDarkBlue
#define ACTIVE_LINK_COLOR kLightBlue

#endif
