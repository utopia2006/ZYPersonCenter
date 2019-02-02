//
//  MenuView.h
//  PersonCenter
//
//  Created by zhouyu on 2017/10/12.
//  Copyright © 2017年 ColorFish All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface MenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray*)titleArray;

@property (nonatomic, copy) void (^menuSeletedIndex)(NSInteger);

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, copy) NSDictionary *normalAttribute;

@property (nonatomic, copy) NSDictionary *SelectAttribute;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat IndicatorHeight;

@property (nonatomic, strong) UIColor *IndicatorColor;

@property (nonatomic, assign) HMSegmentedControlSegmentWidthStyle segmentWidthStyle;

@property (nonatomic, assign) HMSegmentedControlSelectionStyle selectionStyle;

@property (nonatomic, assign) UIEdgeInsets segmentEdgeInset;

@property (nonatomic, assign) UIEdgeInsets selectionIndicatorEdgeInsets;

@end
