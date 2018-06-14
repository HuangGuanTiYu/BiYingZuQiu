//
//  UIImage+Extension.m
//  driverTemporary
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 chokchok. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (instancetype)resizableImageWithImage : (NSString *)image
{
    UIImage *newImage = [UIImage imageNamed:image];
    newImage = [newImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    return newImage;
}

/*
 *  颜色转图片
 */
+ (UIImage *) createImageWithColor:(UIColor *) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
