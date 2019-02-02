//
//  MyBarButtonItem.m
//  greygoose
//
//  Created by xie tianhe on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyBarButtonItem.h"
#import "UIImage+ImageWithColor.h"

@implementation MyBarButtonItem

@synthesize buttonType,lab;

+ (UIView *)titleView:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HexRGB(0xffffff);
    label.backgroundColor = [UIColor clearColor];
    CGFloat maxWidth = [[UIScreen mainScreen] bounds].size.width - 50*2;
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(maxWidth, 44)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:label.font}
                                          context:nil].size;
    
    label.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    
    return label;
}

-(id)initWithImage:(UIImage *)img
  highlightedImage:(UIImage *)highlightedImage
       buttonTitle:(NSString*)btnTitle
        buttonSize:(CGSize)btnSize
            target:(id)target
          selector:(SEL)selector
        buttonType:(NavigationButtonType)type {
    self = [super init];
    if (self) {
        if (type == ButtonLeft && btnTitle == nil) {
            UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
            but.backgroundColor = [UIColor clearColor];
            but.tag = kButtonTag;
            [but setImage:img forState:UIControlStateNormal];
            [but setImage:highlightedImage forState:UIControlStateHighlighted];
            [but.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
            [but.titleLabel setShadowColor:[UIColor colorWithWhite:1 alpha:0.4f]];
            [but.titleLabel setShadowOffset:CGSizeMake(0, 0.5f)];
            [but setTitle:btnTitle forState:UIControlStateNormal];
            [but setTitle:btnTitle forState:UIControlStateHighlighted];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [but addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
            
            if (IOSVersion>=7.0) {
                [but setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
                
            }else{
                [but setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            }
            self = [self initWithCustomView:but];
            
        } else if(type == ButtonRight && btnTitle == nil) {
            UIButton* but = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
            but.backgroundColor = [UIColor clearColor];
            but.tag = kButtonTag;
            [but setImage:img forState:UIControlStateNormal];
            [but setImage:highlightedImage forState:UIControlStateHighlighted];
            [but.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
            [but.titleLabel setShadowColor:[UIColor colorWithWhite:1 alpha:0.4f]];
            [but.titleLabel setShadowOffset:CGSizeMake(0, 0.5f)];
            [but setTitle:btnTitle forState:UIControlStateNormal];
            [but setTitle:btnTitle forState:UIControlStateHighlighted];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [but addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
            
            if (IOSVersion>=7.0) {
                [but setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
                
            }else{
                [but setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
            }
            self =  [self initWithCustomView:but];
            
        } else if(type == ButtonLeft && btnTitle !=nil) {
            NavButton* but =  [[NavButton alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
            but.isTextButton = YES;
            but.tag = kButtonTag;
            [but setBackgroundImage:img forState:UIControlStateNormal];
            [but setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [but.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
            [but.titleLabel setShadowColor:[UIColor colorWithWhite:1 alpha:0.4f]];
            [but.titleLabel setShadowOffset:CGSizeMake(0, 0.5f)];
            [but setTitle:btnTitle forState:UIControlStateNormal];
            [but setTitle:btnTitle forState:UIControlStateHighlighted];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [but addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
            
            if (IOSVersion<6.0f) {
                but.frame = CGRectMake(5.0f, 0, btnSize.width, btnSize.height);
                [backView addSubview:but];
                self = [self initWithCustomView:backView];
            }else{
                self = [self initWithCustomView:but];
            }
            
        } else if (type == ButtonRight && btnTitle != nil) {
            NavButton* but = [[NavButton alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
            but.isTextButton = YES;
            but.tag = kButtonTag;
            [but setBackgroundImage:img forState:UIControlStateNormal];
            [but setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [but.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [but.titleLabel setShadowColor:[UIColor colorWithWhite:1 alpha:0.4f]];
            [but.titleLabel setShadowOffset:CGSizeMake(0, 0.5f)];
            [but setTitle:btnTitle forState:UIControlStateNormal];
            [but setTitle:btnTitle forState:UIControlStateHighlighted];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [but addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
            
            if (IOSVersion<6.0f) {
                but.frame = CGRectMake(-5.0f, 0, btnSize.width, btnSize.height);
                [backView addSubview:but];
                self = [self initWithCustomView:backView];
            } else {
                self = [self initWithCustomView:but];
            }
        }
	}
    
	return self;
}

+ (MyBarButtonItem *)backBarButtonWithTarget:(id)target selector:(SEL)selector {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, 50, 44);
    but.backgroundColor = [UIColor clearColor];
    but.tag = kButtonTag;
    [but setImage:[UIImage imageNamed:@"navbar_back.png"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"navbar_back_over.png"] forState:UIControlStateHighlighted];
    [but addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (IOSVersion>=7.0) {
        [but setImageEdgeInsets:UIEdgeInsetsMake(0, -15-4, 0, 15+4)];
    } else {
        [but setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    }
    
   return [[MyBarButtonItem alloc] initWithCustomView:but];
}

+ (MyBarButtonItem *)navLeftBarButtonItemWithTarget:(id)target selector:(SEL)selector normal:(UIImage *)image highlight:(UIImage*)hightlightImage {
    CGSize btnImgSize = CGSizeMake(image.size.width/2.0f, image.size.height/2.0f);
    return [[MyBarButtonItem alloc] initWithImage:image
                                  highlightedImage:hightlightImage
                                       buttonTitle:nil
                                        buttonSize:btnImgSize
                                            target:target
                                          selector:selector
                                        buttonType:ButtonLeft];
    
}

+ (MyBarButtonItem *)navLeftBarButtonItemWithTitle:(NSString*)title target:(id)target selector:(SEL)selector {
    UIImage* leftBtnImg = [UIImage imageNamed:@"otherImage.png"];
    UIImage* leftBtnhighlightedImg = [UIImage imageNamed:@"otherImage_over.png"];
    CGSize fontSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGSize leftBtnImgSize = CGSizeMake(fontSize.width + 20, fontSize.height + 10);
    
    return [[MyBarButtonItem alloc] initWithImage:leftBtnImg
                                  highlightedImage:leftBtnhighlightedImg
                                       buttonTitle:title
                                        buttonSize:leftBtnImgSize
                                            target:target
                                          selector:selector
                                        buttonType:ButtonLeft];
    
   
    
}

+ (MyBarButtonItem *)navRightBarButtonItemWithTarget:(id)target
                                            selector:(SEL)selector
                                              normal:(UIImage *)image
                                           highlight:(UIImage*)hightlightImage {
    UIImage *rightBtnImg = image;
    UIImage *rightBtnhighlightedImg = hightlightImage;
    CGSize rightBtnImgSize = CGSizeMake(50, 44) ;
    return [[MyBarButtonItem alloc] initWithImage:rightBtnImg
                                  highlightedImage:rightBtnhighlightedImg
                                       buttonTitle:nil
                                        buttonSize:rightBtnImgSize
                                            target:target
                                          selector:selector
                                        buttonType:ButtonRight];

}

@end

@implementation NavButton
@synthesize isTextButton;

// ios 6.0 以上才支持此函数
- (UIEdgeInsets)alignmentRectInsets {
    UIEdgeInsets insets;
    if (IOSVersion>=7.0) {
        if ([self isLeftButton]) {
            if(isTextButton){
                insets = UIEdgeInsetsMake(0, 5.0f, 0, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.0f);
            }else{
                insets = UIEdgeInsetsMake(0, /*10.0f+*/5.0f, 0, 0);
            }
            
        }
        else { // IF ITS A RIGHT BUTTON
            if (isTextButton) {
                insets = UIEdgeInsetsMake(0, 0, 0, 5.0f);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0.0f);
            }else{
                insets = UIEdgeInsetsMake(0, 0, 0, 10.0f+5.0f);
            }
            
        }
        
    }else{
        //insets = UIEdgeInsetsZero;
        if ([self isLeftButton]) {
            if (isTextButton) {
                insets = UIEdgeInsetsMake(0, -5.0f, 0, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0.0f);
            }else{
                insets = UIEdgeInsetsMake(0, 0.0f, 0, 0);
            }
            
        }
        else { // IF ITS A RIGHT BUTTON
            if (isTextButton) {
                insets = UIEdgeInsetsMake(0, 0, 0, -5.0f);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0.0f);
            }else{
                insets = UIEdgeInsetsMake(0, 0, 0, 5.0f);
            }
            
        }
    }
    
    return insets;
}



- (BOOL)isLeftButton {
    return self.frame.origin.x < (self.superview.frame.size.width / 2);
}

@end
