//
//  CourseStudyListModel.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/29.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "CourseStudyListModel.h"
#import "MJExtension.h"

@implementation CourseStudyListModel

- (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"name" : @"name",
             };
}
@end
