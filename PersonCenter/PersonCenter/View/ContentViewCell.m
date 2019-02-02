//
//  ContentViewCell.m
//  PersonCenter
//
//  Created by zhuoyu on 2017/3/15.
//  Copyright © 2017年 ColorFish All rights reserved.
//

#import "ContentViewCell.h"
#import "EmbedScrollViewControllerProtocol.h"
#import "QCSlideSwitchView.h"

@interface ContentViewCell ()<UIScrollViewDelegate,QCSlideSwitchViewDelegate>
@property (strong, nonatomic) NSArray<UIViewController *> *dataArray;
@property (strong, nonatomic) QCSlideSwitchView *slideSwitchView;
@property (nonatomic, assign) NSInteger tabIndex;
@end

@implementation ContentViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier controllers:(NSArray<UIViewController*> *)controller {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.tabIndex = 0;
        self.backgroundColor =HexRGB(0xffffff);
        [self.slideSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        self.dataArray = controller;
        [self.slideSwitchView buildUI];
    }
    return self;
}

#pragma mark --scrollerViewDelegate----
//用于让pageView到边缘时不让滑动一段距离的问题
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.bounces = NO;
}

#pragma mark ------ACTION-----
- (void)selectedBar:(NSInteger)tabIndex {
    [self.slideSwitchView switchToTab:tabIndex];
}

-(void)refreshIndex:(NSInteger)index {
    UIViewController *controller = self.dataArray[index];
    id<EmbedScrollViewControllerProtocol> target;
    if ([controller conformsToProtocol:@protocol(EmbedScrollViewControllerProtocol)]) {
        target = (id<EmbedScrollViewControllerProtocol>)controller;
        [target refresh];
    }
}

- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
    id<EmbedScrollViewControllerProtocol> target;

    //修改所有的子控制器的状态
    for (UIViewController *ctrl in self.dataArray) {
        if ([ctrl conformsToProtocol:@protocol(EmbedScrollViewControllerProtocol)]) {
            target = (id<EmbedScrollViewControllerProtocol>)ctrl;
            target.canScroll = canScroll;
            if (!canScroll) {
                [target resetOffset];
            }
        }
        
    }
}
#pragma mark ------GETTER-----
- (QCSlideSwitchView *)slideSwitchView {
    if (!_slideSwitchView) {
        _slideSwitchView = [[QCSlideSwitchView alloc] init];
        _slideSwitchView.slideSwitchViewDelegate = self;
        _slideSwitchView.backgroundColor = RGBCOLOR(245, 245, 245);
        [self.contentView addSubview:_slideSwitchView];
    }
    return _slideSwitchView;
}

#pragma mark - 滑动tab视图代理方法
- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view {
    // you can set the best you can do it ;
    return self.dataArray.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number {
    return self.dataArray[number];
}

- (NSInteger)selectedIndexOfTab:(QCSlideSwitchView *)view {
    return self.tabIndex;
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number {
    self.tabIndex = number;
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectSegmentedControl:(NSUInteger)number {
    self.tabIndex = number;
    if (self.scrolleSelected) {
        self.scrolleSelected(number);
    }
}

@end
