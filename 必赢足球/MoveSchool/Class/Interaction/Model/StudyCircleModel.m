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

- (void)setContent:(NSString *)content
{
    
    if (self.isself == 1) {
        _content = content;
        return;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Hudong" ofType:@"plist"];
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
    
    int x = arc4random() % 38;
    _content = dicArr[x];
}

@end
