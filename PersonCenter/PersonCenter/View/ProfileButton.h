//
//  ProfileButton.h
//  photo
//
//  Created by admin on 14-12-3.
//  Copyright (c) 2014年 poco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileButton : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleHighlightColor;
@property (nonatomic, strong) UIColor *numberNormalColor;
@property (nonatomic, strong) UIColor *numberHighlightColor;
@property (nonatomic, strong) UIColor *highlightBgColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *numberFont;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

- (id)initWithFrame:(CGRect)frame;

- (void)setTitle:(NSString *)title;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

- (void)setNumber:(NSString *)number;

- (void)setNumberColor:(UIColor *)color forState:(UIControlState)state;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
