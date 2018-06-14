//
//  BusinessTypeTool.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/15.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "BusinessTypeTool.h"

@implementation BusinessTypeTool

+ (NSString *) returnBusinessTypeWithCode : (NSString *) code
{
    if ([code isEqualToString:courseType]) {
        return @"课程";
    }else if ([code isEqualToString:liveType]|| [code isEqualToString:@"8"])
    {
        return @"直播";
    }else if ([code isEqualToString:shalongType]|| [code isEqualToString:@"6"])
    {
        return @"沙龙";
    }else if ([code isEqualToString:specialType]|| [code isEqualToString:@"5"])
    {
        return @"专题";
    }else if ([code isEqualToString:testType] || [code isEqualToString:@"3"])
    {
        return @"考试";
    }else if ([code isEqualToString:voteType]|| [code isEqualToString:@"7"])
    {
        return @"问卷";
    }else if ([code isEqualToString:newsType] || [code isEqualToString:@"4"])
    {
        return @"资讯";
    }else if ([code isEqualToString:teacherType]|| [code isEqualToString:@"9"])
    {
        return @"讲师";
    }
    
    return @"";
}

@end
