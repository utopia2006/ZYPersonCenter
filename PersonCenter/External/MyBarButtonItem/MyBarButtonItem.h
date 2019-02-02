//
//  MyBarButtonItem.h
//  greygoose
//
//  Created by xie tianhe on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kButtonTag 100
typedef enum {
    ButtonLeft = 0,           // 左边按钮
	ButtonRight,			  // 右边按钮
} NavigationButtonType;

@interface MyBarButtonItem : UIBarButtonItem {

	NavigationButtonType buttonType;
    UILabel *lab;
}

@property(nonatomic, assign) NavigationButtonType buttonType;
@property(nonatomic, strong) UILabel *lab;

-(id)initWithImage:(UIImage *)img
  highlightedImage:(UIImage *)highlightedImage
       buttonTitle:(NSString*)btnTitle
        buttonSize:(CGSize)btnSize
            target:(id)target
          selector:(SEL)selector
        buttonType:(NavigationButtonType)type;

+ (UIView *)titleView:(NSString *)title;

+ (MyBarButtonItem *)navLeftBarButtonItemWithTitle:(NSString*)title target:(id)target selector:(SEL)selector;

+ (MyBarButtonItem *)backBarButtonWithTarget:(id)target selector:(SEL)selector;

+ (MyBarButtonItem *)navLeftBarButtonItemWithTarget:(id)target selector:(SEL)selector normal:(UIImage *)image highlight:(UIImage*)hightlightImage;

+ (MyBarButtonItem *)navRightBarButtonItemWithTarget:(id)target selector:(SEL)selector normal:(UIImage *)image highlight:(UIImage*)hightlightImage;

@end

@interface NavButton : UIButton {
    BOOL isTextButton;
}

@property (nonatomic,assign) BOOL isTextButton;

@end

