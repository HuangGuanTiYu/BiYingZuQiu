//
//  StudyReplyCell.m
//  MoveSchool
//
//  Created by edz on 2017/5/15.
//
//

#import "StudyReplyCell.h"
#import "StudyReply.h"
#import "NSDataEx.h"
#import "EmotionTool.h"
#import "NSString+Extension.h"
#import "UILabel+YBAttributeTextTapAction.h"

@interface StudyReplyCell()

@property(nonatomic, strong) UILabel *replyLabel;

@end

@implementation StudyReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.replyLabel = [[UILabel alloc] init];
        self.replyLabel.numberOfLines = 0;
        self.replyLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.replyLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.replyLabel.frame = CGRectMake(5, 0, self.contentView.width - 2 * 5, self.contentView.height);
}

- (void)setModel:(StudyReply *)model
{
    _model = model;
    
    NSString *content = @"";
    NSString *nickName = model.nickname;
    NSString *tonickName = model.tonickname;
    
    //有回复
    if (model.touserid > 0) {
        content = [NSString stringWithFormat:@"%@ 回复 %@：%@",nickName,tonickName,model.content];
    }else
    {
        content = [NSString stringWithFormat:@"%@：%@",nickName,model.content];
    }
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:model.replyString];
    
    if (nickName.length > 0) {
        [attributeString addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[content rangeOfString:nickName]];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ys_f24] range:[content rangeOfString:nickName]];
    }
    if (tonickName.length > 0) {
        [attributeString addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[content rangeOfString:tonickName options:NSBackwardsSearch]];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ys_f24] range:[content rangeOfString:tonickName options:NSBackwardsSearch]];
    }
    
    self.replyLabel.attributedText = attributeString;
    NSArray *strings = @[nickName];
    if (model.touserid > 0) {
        strings = @[nickName,tonickName];
    }
    
    [self.replyLabel yb_addAttributeTapActionWithStrings:strings tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        if ([self.delegate respondsToSelector:@selector(nameClick:)]) {
            NSInteger userId = model.userid;
            if ([model.tonickname isEqualToString:string]) {
                userId = model.touserid;
            }
            [self.delegate nameClick:userId];
        }
    }];
}

-(NSString *)base64DecodeString:(NSString *)string
{
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [NSData dataWithBase64EncodedString:string];
    
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
