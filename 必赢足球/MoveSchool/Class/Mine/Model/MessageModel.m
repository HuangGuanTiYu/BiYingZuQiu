//
//  MessageModel.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "MessageModel.h"
#import "NSString+Extension.h"

@implementation MessageModel

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.taskTitleHeight = [title returnStringRect:title size:CGSizeMake(SCREEN_WIDTH - 55, CGFLOAT_MAX) font:[UIFont systemFontOfSize:14]].height;

}

- (void)setInfo:(NSString *)info
{
    _info = info;
    
    self.noticeInfoHeight = [info returnStringRect:info size:CGSizeMake(SCREEN_WIDTH - 55, CGFLOAT_MAX) font:[UIFont systemFontOfSize:14]].height;

    NSMutableString *content = [NSMutableString string];
    if (self.title.length > 0) {
        [content appendString:[NSString stringWithFormat:@"《%@》%@",self.title,info]];
    }else
    {
        [content appendString:info];
    }
    
    self.interactionCellHeight = [content returnStringRect:content size:CGSizeMake(SCREEN_WIDTH - 55, CGFLOAT_MAX) font:[UIFont systemFontOfSize:14]].height;
}

- (void)setAuditopinion:(NSString *)auditopinion
{
    _auditopinion = auditopinion;
    
    if (auditopinion.length > 0) {
        NSMutableString *string = [NSMutableString string];
        [string appendFormat:@"理由：%@",auditopinion];
        self.auditopinionCellHeight = [string returnStringRect:string size:CGSizeMake(SCREEN_WIDTH - 61, CGFLOAT_MAX) font:[UIFont systemFontOfSize:12]].height;
    }else
    {
        self.auditopinionCellHeight = 0;
    }

}


- (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id"
             };
}

@end
