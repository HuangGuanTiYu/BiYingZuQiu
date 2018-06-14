//
//  NSString+Extension.m
//  SchoolBus
//
//  Created by 顾海波 on 2017/3/25.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import "NSString+Extension.h"
#import "GTMBase64.h"

@implementation NSString (Extension)

/*
 * 返回文字的宽高
 * string 文字
 * font 文字大小
 */
- (CGSize) returnStringRect : (NSString *) string size : (CGSize) size font : (UIFont *) font
{
    CGSize titleSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize;
}

/*
 * 字符串base64编码
 * input 字符串
 */
+ (NSString*)encodeBase64:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //转换到base64
    data = [GTMBase64 encodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

/*
 * 返回文字的宽高
 * string 文字
 * font 文字大小
 */
+ (CGSize) returnStringRect : (NSString *) string size : (CGSize) size font : (UIFont *) font
{
    CGSize titleSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize;
}

@end
