//
//  MyBarButtonItem.m
//  greygoose
//
//  Created by xie tianhe on 11-8-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyBarButtonItem.h"

@implementation MyBarButtonItem

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

@end
