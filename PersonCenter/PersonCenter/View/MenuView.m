//
//  MenuView.m
//  PersonCenter
//
//  Created by zhouyu on 2017/10/12.
//  Copyright © 2017年 ColorFish All rights reserved.
//

#import "MenuView.h"
#import "HMSegmentedControl.h"

@interface MenuView()

@property (nonatomic, strong) HMSegmentedControl *pageControl;

@property (nonatomic, strong) UIView *segmentView;

@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation MenuView {
    UIImageView *lineView;
}

- (instancetype)init{
    
    if (![super init]) {
        return nil;
    }
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    return [self initWithFrame:frame TitleArray:@[]];
}
- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray*)titleArray{
    
    self = [super initWithFrame:frame];
    
    
    if (!self) {
        return nil;
    }
    
    self.titleArr = titleArray;
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self).offset(0.0);
        make.height.mas_offset(CGRectGetHeight(self.frame));
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.segmentView);
    }];
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = RGBCOLOR(230, 230, 230);
    [self addSubview:line];
    lineView = line;
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(1);
        make.height.mas_offset(isIpad ? 1 : kSepLineHeight);
    }];
    [self bringSubviewToFront:line];
    
    return self;
}

#pragma mark ------SETTER-----
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    _selectedIndex = selectedIndex;
    [self.pageControl setSelectedSegmentIndex:selectedIndex animated:YES];
}
- (void)setNormalAttribute:(NSDictionary *)normalAttribute{
    
    _normalAttribute = normalAttribute;
    _pageControl.titleTextAttributes = normalAttribute;
}
- (void)setSelectAttribute:(NSDictionary *)SelectAttribute{
    
    _SelectAttribute = SelectAttribute;
    _pageControl.selectedTitleTextAttributes = SelectAttribute;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    
    _pageControl.backgroundColor = backgroundColor;
}
- (void)setLineColor:(UIColor *)lineColor{
    
    _lineColor = lineColor;
    lineView.backgroundColor = lineColor;
}
- (void)setIndicatorHeight:(CGFloat)IndicatorHeight{
    
    _IndicatorHeight = IndicatorHeight;
    _pageControl.selectionIndicatorHeight = IndicatorHeight;
}
- (void)setIndicatorColor:(UIColor *)IndicatorColor{
    
    _IndicatorColor = IndicatorColor;
    _pageControl.selectionIndicatorColor = IndicatorColor;
}
- (void)setSegmentWidthStyle:(HMSegmentedControlSegmentWidthStyle)segmentWidthStyle {
    _segmentWidthStyle = segmentWidthStyle;
    _pageControl.segmentWidthStyle = segmentWidthStyle;
}

- (void)setSelectionStyle:(HMSegmentedControlSelectionStyle)selectionStyle {
    _selectionStyle = selectionStyle;
    _pageControl.selectionStyle = selectionStyle;
}
- (void)setSegmentEdgeInset:(UIEdgeInsets)segmentEdgeInset {
    _segmentEdgeInset = segmentEdgeInset;
    _pageControl.segmentEdgeInset = segmentEdgeInset;
}
- (void)setSelectionIndicatorEdgeInsets:(UIEdgeInsets)selectionIndicatorEdgeInsets {
    _selectionIndicatorEdgeInsets = selectionIndicatorEdgeInsets;
    _pageControl.selectionIndicatorEdgeInsets = selectionIndicatorEdgeInsets;
}

#pragma mark ------GETTER-----
- (UIView *)segmentView{
    
    if (!_segmentView) {
        _segmentView = [[UIView alloc] init];
        _segmentView.backgroundColor = HexRGB(0xffffff);
        [self addSubview:_segmentView];
    }
    return _segmentView;
}
- (HMSegmentedControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.titleArr];
        [_pageControl addTarget:self
                         action:@selector(pageControlValueChanged:)
               forControlEvents:UIControlEventValueChanged];
        _pageControl.backgroundColor =HexRGB(0xffffff);
        _pageControl.titleTextAttributes = @{NSForegroundColorAttributeName : HexRGB(0x333333),NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};
        _pageControl.selectionIndicatorColor = kDarkBlue;
        _pageControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _pageControl.selectionIndicatorHeight = 2.0f;
        _pageControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _pageControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kDarkBlue,NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};
        _pageControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _pageControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        _pageControl.verticalDividerEnabled = NO;
        _pageControl.verticalDividerColor = kDarkBlue;
        [self.segmentView addSubview:_pageControl];
    }
    return _pageControl;
}
#pragma mark - 切换板块

- (void)pageControlValueChanged:(id)sender {
    if (self.menuSeletedIndex) {
        self.menuSeletedIndex( self.pageControl.selectedSegmentIndex);
        NSLog(@"pageControlValueChanged: %d", self.pageControl.selectedSegmentIndex);
    }
}
@end
