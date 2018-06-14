//
//  NSString+Extension.h
//  SchoolBus
//
//  Created by 顾海波 on 2017/3/25.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/*
 * 返回文字的宽高
 * size 区域大小
 * string 文字
 * font 文字大小
 */
- (CGSize) returnStringRect : (NSString *) string size : (CGSize) size font : (UIFont *) font;

/*
 * 返回文字的宽高
 * size 区域大小
 * string 文字
 * font 文字大小
 */
+ (CGSize) returnStringRect : (NSString *) string size : (CGSize) size font : (UIFont *) font;

/*
 * 字符串base64编码
 * input 字符串
 */
+ (NSString*)encodeBase64:(NSString*)input;

@end
