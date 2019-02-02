//
//  UIImage+ImageWithColor.m
//  UIImage-ImageWithColor
//
//  Created by Bruno Tortato Furtado on 14/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius
{
    CGFloat width = size.width;
    CGFloat height = size.height;

    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    
    // 闭合路径
    CGContextClosePath(context);
   
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathEOFill);
    
    // 填充半透明黑色
    //CGContextSetLineWidth(context, 1.0);
    //CGContextSetRGBStrokeColor(context, 225.0f/255, 225.0f/255, 225.0f/255, 1.0);
    //CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth
{
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    
    // 闭合路径
    CGContextClosePath(context);
    
    // 填充半透明黑色
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetRGBStrokeColor(context, 229.0f/255, 229.0f/255, 229.0f/255, 1.0);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathEOFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, borderWidth);
    CGFloat red,green,blue,alpha;
    [borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextBeginPath(context);
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.5,0.5, size.width-1, size.height-1) cornerRadius:radius];
    bezierPath.lineWidth = borderWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    CGPathRef clippath = bezierPath.CGPath;
    CGContextAddPath(context, clippath);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    /*
    
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    
    // 闭合路径
    CGContextClosePath(context);
    
    // 填充半透明黑色
    //CGContextSetLineWidth(context, borderWidth);
    CGFloat red,green,blue,alpha;
    [borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
    //CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
     */
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+(UIImage*)imageWithView:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    v.layer.borderWidth = borderWidth;
    v.layer.borderColor = borderColor.CGColor;
    v.layer.cornerRadius = radius;
    v.clipsToBounds = YES;
    v.backgroundColor = color;
    
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size maskImage:(UIImage*)mask
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    if (mask) {
        float width = mask.size.width;
        float height = mask.size.height;
        //NSLog(@"mask width %f size.width %f", width, size.width);
        float dx = (size.width- width)/2 >0? (size.width-width)/2:0;
        float dy = (size.height-height)/2>0? (size.height-height)/2:0;
        CGRect imgRect = CGRectMake(dx, dy, width, height);
        
        UIGraphicsPushContext(context);
        [mask drawInRect:imgRect];
        UIGraphicsPopContext();
        //CGContextDrawImage(context, imgRect, mask.CGImage);
    }
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end