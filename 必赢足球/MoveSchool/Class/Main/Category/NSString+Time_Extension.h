//
//  NSString+Time_Extension.h
//  MoveSchool
//
//  Created by edz on 2017/12/29.
//

#import <Foundation/Foundation.h>

@interface NSString (Time_Extension)

#pragma mark 根据时分秒 获取 秒数
+ (int) getTime : (NSString *) timeSting;

#pragma mark 根据秒数获取 时分秒
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

@end
