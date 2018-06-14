//
//  StudyCircleModel.m
//  MoveSchool
//
//  Created by edz on 2017/5/8.
//
//

#import "StudyCircleModel.h"
#import "MJExtension.h"
#import "StudyReply.h"
#import "StudyAttachs.h"

@implementation StudyCircleModel

MJCodingImplementation

- (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id"
             };
}

- (NSDictionary *)objectClassInArray
{
    return @{@"comments": [StudyReply class], @"attachs" : [StudyAttachs class]};
}

@end
