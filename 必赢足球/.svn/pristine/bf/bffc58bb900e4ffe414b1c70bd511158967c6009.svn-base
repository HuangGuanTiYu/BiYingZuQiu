//
//  CourseStudyCommentFrame.m
//  MoveSchool
//
//  Created by edz on 2017/6/2.
//
//

#import "CourseStudyCommentFrame.h"
#import "CourseStudyCommentModel.h"
#import "NSString+Extension.h"
#import "NSDataEx.h"
#import "NSString+Extension.h"

@implementation CourseStudyCommentFrame

- (void)setModel:(CourseStudyCommentModel *)model
{
    _model = model;
    
    _headerFrame = CGRectMake(mainSpacing, mainSpacing, 50, 50);
    
    CGFloat goodW = [model.praise returnStringRect:model.praise size:CGSizeMake(SCREEN_WIDTH, 14) font:[UIFont systemFontOfSize:14]].width;
    _goodFrame = CGRectMake(SCREEN_WIDTH - goodW - mainSpacing - 15, _headerFrame.origin.y, 20 + goodW, 14);
    
    _nickNameFrame = CGRectMake(CGRectGetMaxX(_headerFrame) + mainSpacing, _headerFrame.origin.y, SCREEN_WIDTH - CGRectGetMaxX(_headerFrame) - mainSpacing - _goodFrame.size.width, 14);
    
    NSString *content = [self base64DecodeString:model.content];
    _contentFrame = CGRectMake(_nickNameFrame.origin.x, CGRectGetMaxY(_nickNameFrame)+ 5, _nickNameFrame.size.width, [content returnStringRect:content size:CGSizeMake(_nickNameFrame.size.width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:14]].height);
    
    _timeFrame = CGRectMake(_nickNameFrame.origin.x, CGRectGetMaxY(_contentFrame) + mainSpacing, _contentFrame.size.width, 14);
    
    if (CGRectGetMaxY(_timeFrame) > CGRectGetMaxY(_contentFrame)) {
        _cellHeight = CGRectGetMaxY(_timeFrame) + mainSpacing;
    }else
    {
        _cellHeight = CGRectGetMaxY(_contentFrame) + mainSpacing;
    }
}

-(NSString *)base64DecodeString:(NSString *)string
{
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [NSData dataWithBase64EncodedString:string];
    
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
