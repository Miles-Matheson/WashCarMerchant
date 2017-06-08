//
//  UIImage+Colorful.m
//  LimiBuyer
//
//  Created by steven on 16/6/30.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import "UIImage+Colorful.h"

@implementation UIImage (Colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
