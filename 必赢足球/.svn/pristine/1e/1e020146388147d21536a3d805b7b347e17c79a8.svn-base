//
//  NSString+Time_Extension.m
//  MoveSchool
//
//  Created by edz on 2017/12/29.
//

#import "NSString+Time_Extension.h"

@implementation NSString (Time_Extension)

#pragma mark 根据时分秒 获取 秒数
+ (int) getTime : (NSString *) timeSting
{
    int time = 0;
    
    if (timeSting.length > 0 && [timeSting containsString:@":"]) {
        NSArray *times = [timeSting componentsSeparatedByString:@":"];
        time = [times[2] intValue];
        time += [times[1] intValue] * 60;
        time += [times[0] intValue] * 60 * 60;
    }
    
    return time;
}

#pragma mark  传入 秒  得到  xx分钟xx秒
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}

@end
