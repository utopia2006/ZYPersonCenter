//
//  ProfileButton.m
//  PersonCenter
//
//  Created by zhuoyu on 14-12-3.
//  Copyright (c) 2014年 ColorFish All rights reserved.
//

#import "ProfileButton.h"


@interface ProfileButton ()
@property (nonatomic, assign) UIControlState state;
@end

@implementation ProfileButton

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.titleNormalColor = HexRGB(0x999999);
    self.titleHighlightColor = HexRGB(0x999999);
    self.numberNormalColor = HexRGB(0x000000);
    self.numberHighlightColor = HexRGB(0x000000);
    self.highlightBgColor = HexRGB(0xf5f5f5);
    self.titleFont = [UIFont systemFontOfSize:11.0f];
    self.numberFont = [UIFont boldSystemFontOfSize:17.0f];
    _state = UIControlStateNormal;
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.titleNormalColor = color;
    } else if (state == UIControlStateHighlighted) {
        self.titleHighlightColor = color;
    }
    [self setNeedsDisplay];
}

- (void)setNumber:(NSString *)number {
    _number = number;
    [self setNeedsDisplay];
}

- (void)setNumberColor:(UIColor *)color forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.numberNormalColor = color;
    } else if (state == UIControlStateHighlighted) {
        self.numberHighlightColor = color;
    }
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //获得处理的上下文
    //CGContextRef context = UIGraphicsGetCurrentContext();
    [super drawRect:rect];
    
    if (_state == UIControlStateNormal) {
        [self.numberNormalColor set];
        int textWidth = ceilf([_number sizeWithAttributes:@{NSFontAttributeName:self.numberFont}].width);
        if (textWidth>= CGRectGetWidth(rect)) {
            textWidth = CGRectGetWidth(rect);
        }
        [_number drawInRect:CGRectMake((CGRectGetWidth(rect)-textWidth)/2, 18, textWidth, CGRectGetHeight(rect)/2) withAttributes:@{NSFontAttributeName:self.numberFont,NSForegroundColorAttributeName:self.numberNormalColor}];
        
        [self.titleNormalColor set];
        textWidth = ceil([_title sizeWithAttributes:@{NSFontAttributeName:self.titleFont}].width);
        if (textWidth>= CGRectGetWidth(rect)) {
            textWidth = CGRectGetWidth(rect);
        }
        [_title drawInRect:CGRectMake((CGRectGetWidth(rect)-textWidth)/2, CGRectGetHeight(rect)/2+4, textWidth, CGRectGetHeight(rect)/2) withAttributes:@{NSFontAttributeName:self.titleFont,NSForegroundColorAttributeName:self.titleNormalColor}];
        
    } else {
        [self.numberHighlightColor set];
        int textWidth = ceilf([_number sizeWithAttributes:@{NSFontAttributeName:self.numberFont}].width);
        if (textWidth>= CGRectGetWidth(rect)) {
            textWidth = CGRectGetWidth(rect);
        }
        [_number drawInRect:CGRectMake((CGRectGetWidth(rect)-textWidth)/2, 18, textWidth, CGRectGetHeight(rect)/2) withAttributes:@{NSFontAttributeName:self.numberFont,NSForegroundColorAttributeName:self.numberHighlightColor}];
        
        [self.titleHighlightColor set];
        textWidth = ceilf([_title sizeWithAttributes:@{NSFontAttributeName:self.titleFont}].width);
        if (textWidth>= CGRectGetWidth(rect)) {
            textWidth = CGRectGetWidth(rect);
        }
        [_title drawInRect:CGRectMake((CGRectGetWidth(rect)-textWidth)/2, CGRectGetHeight(rect)/2+4, textWidth, CGRectGetHeight(rect)/2) withAttributes:@{NSFontAttributeName:self.titleFont,NSForegroundColorAttributeName:self.titleHighlightColor}];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _state = UIControlStateHighlighted;
    self.backgroundColor = self.highlightBgColor;
    [self setNeedsDisplay];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _state = UIControlStateNormal;
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (self.target && [self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:self];
    }
#pragma clang diagnostic pop
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    _state = UIControlStateNormal;
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (controlEvents == UIControlEventTouchUpInside) {
        self.target = target;
        self.action = action;
    }
}

@end
