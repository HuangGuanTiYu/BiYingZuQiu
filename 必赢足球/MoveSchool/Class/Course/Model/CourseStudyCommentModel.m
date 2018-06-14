//
//  CourseStudyCommentModel.m
//  MoveSchool
//
//  Created by edz on 2017/6/2.
//
//

#import "CourseStudyCommentModel.h"
#import "MJExtension.h"

@implementation CourseStudyCommentModel

- (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id"
             };
}

- (NSString *)content
{
    
    return @"这是互动内容";
}

@end
