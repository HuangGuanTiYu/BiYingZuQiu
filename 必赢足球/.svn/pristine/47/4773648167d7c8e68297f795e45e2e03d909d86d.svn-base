//
//  CourseStudyCommentCell.m
//  MoveSchool
//
//  Created by edz on 2017/6/2.
//
//

#import "CourseStudyCommentCell.h"
#import "CourseStudyCommentFrame.h"
#import "UIImageView+WebCache.h"
#import "CourseStudyCommentModel.h"
#import "TitleImageButton.h"
#import "NSDataEx.h"
#import "AFNetWW.h"
#import "NSDate+Extension.h"

@interface CourseStudyCommentCell()

//头像
@property(nonatomic, strong) UIImageView *headerView;

//昵称
@property(nonatomic, strong) UILabel *nameLabel;

//内容
@property(nonatomic, strong) UILabel *contentLabel;

//时间
@property(nonatomic, strong) UILabel *timeLabel;

//赞
@property(nonatomic, strong) TitleImageButton *goodButton;


@end

@implementation CourseStudyCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.headerView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
    
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = kColorBlack;
        [self.contentView addSubview:self.timeLabel];
        
        self.goodButton = [[TitleImageButton alloc] init];
        [self.goodButton addTarget:self action:@selector(goodButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.goodButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.goodButton];
    }
    return self;
}

- (void)setModelFrame:(CourseStudyCommentFrame *)modelFrame
{
    _modelFrame = modelFrame;
    
    //设置frame
    [self setUpFrame : modelFrame];
    
    //设置data
    [self setUpData : modelFrame.model];
}

#pragma mark 设置frame
- (void) setUpFrame :(CourseStudyCommentFrame *)frame
{
    self.headerView.frame = frame.headerFrame;
    self.headerView.layer.cornerRadius = frame.headerFrame.size.width * 0.5;
    self.headerView.layer.masksToBounds = YES;
    
    self.goodButton.frame = frame.goodFrame;
    
    self.nameLabel.frame = frame.nickNameFrame;
    
    self.contentLabel.frame = frame.contentFrame;
    
    self.timeLabel.frame = frame.timeFrame;
}

#pragma mark 设置Data
- (void) setUpData : (CourseStudyCommentModel *) model
{
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.userheadpic]];
    
    NSString *imageName = @"common_praise_default";
    if (model.existself == 1) {
        imageName = @"common_praise_active";
    }
    [self.goodButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.goodButton setTitle:model.praise forState:UIControlStateNormal];
    [self.goodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    NSMutableString *name = [[NSMutableString alloc] initWithString:model.username];

    if (model.replay_userid != 0) {
        [name appendString:[NSString stringWithFormat:@" 回复 %@",model.replay_username]];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:name];
    
    if (name.length > 0 && model.username.length > 0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(92, 104, 128) range:[name rangeOfString:model.username]];
    }
    
    if (model.replay_userid != 0 && model.replay_username.length > 0 && name.length > 0) {

        [attributedString addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(92, 104, 128) range:[name rangeOfString:model.replay_username options:NSBackwardsSearch]];
    }
    
    self.nameLabel.attributedText = attributedString;
    
    self.contentLabel.text = [self base64DecodeString:model.content];
    
    NSDate *date = [self getDateByString:model.time];
    self.timeLabel.text = [date timeIntervalDescription];
}

-(NSString *)base64DecodeString:(NSString *)string
{
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [NSData dataWithBase64EncodedString:string];
    
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

-(NSDate *) getDateByString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}

#pragma mark 赞按钮点击
- (void) goodButtonClick
{
    if (self.modelFrame.model.existself == 0) {
        NSDictionary *parameter = @{
                                    @"discussid":self.modelFrame.model.ID
                                    };
        
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDiscussPraise,[UserInfoTool getUserInfo].token];
        
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
            
            NSInteger code = [responseDic[@"rescode"] integerValue];
            
            if (code == 10000) {
                if ([self.delegate respondsToSelector:@selector(courseDiscussPraise: praise:)]) {
                    int praise = [responseDic[@"data"][@"praise"] intValue];
                    [self.delegate courseDiscussPraise:self praise:[NSString stringWithFormat:@"%d",praise]];
                }
            }else
            {
                [MBProgressHUD showError:@"刷新失败，网络错误"];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
        }];
    }
}

@end
