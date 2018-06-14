//
//  NSAttributedString+Extension.h
//  SchoolBus
//
//  Created by edz on 2017/4/14.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)

/*
 * 返回文字的宽高
 * size 区域大小
 * string 文字
 * font 文字大小
 */
- (CGSize) returnAttributedStringRect : (NSAttributedString *) string size : (CGSize) size font : (UIFont *) font;

/*
 * 返回文字的宽高
 * size 区域大小
 * string 文字
 * font 文字大小
 */
+ (CGSize) returnAttributedStringRect : (NSAttributedString *) string size : (CGSize) size font : (UIFont *) font;

@end
