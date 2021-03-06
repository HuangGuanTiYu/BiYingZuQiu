//
//  NSAttributedString+Extension.m
//  SchoolBus
//
//  Created by edz on 2017/4/14.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

/*
 * 返回文字的宽高
 * size 区域大小
 * string 文字
 * font 文字大小
 */
- (CGSize) returnAttributedStringRect : (NSMutableAttributedString *) string size : (CGSize) size font : (UIFont *) font;
{
    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    
    CGSize titleSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return titleSize;
}

/*
 * 返回文字的宽高
 * size 区域大小
 * string 文字
 * font 文字大小
 */
+ (CGSize) returnAttributedStringRect : (NSMutableAttributedString *) string size : (CGSize) size font : (UIFont *) font;
{
    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    
    CGSize titleSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return titleSize;
}


@end
