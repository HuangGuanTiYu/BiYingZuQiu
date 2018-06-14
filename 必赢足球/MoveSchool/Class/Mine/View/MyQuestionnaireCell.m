//
//  MyQuestionnaireCell.m
//  MoveSchool
//
//  Created by edz on 2017/9/14.
//
//

#import "MyQuestionnaireCell.h"
#import "QuestionnaireModel.h"

@interface MyQuestionnaireCell()

//标题
@property (nonatomic,strong) UILabel *titleLabel;

//时长
@property (nonatomic,strong) UILabel *timeLabel;

//分割线
@property (nonatomic,strong) UIView *sepaView;

//分数
@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation MyQuestionnaireCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = MainTextColor;
        [self.contentView addSubview:self.titleLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.timeLabel.textColor = AuxiliaryColor;
        [self.contentView addSubview:self.timeLabel];
        
        self.scoreLabel = [[UILabel alloc] init];
        self.scoreLabel.textAlignment = NSTextAlignmentRight;
        self.scoreLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.scoreLabel.textColor = MainColor;
        [self.contentView addSubview:self.scoreLabel];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 15, 0, 40);
    [self.titleLabel sizeToFit];
    self.titleLabel.width = self.contentView.width - 30;
    
    self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) + 12, self.contentView.width - 30, 20);
    [self.timeLabel sizeToFit];
    self.timeLabel.width = self.contentView.width - 30 - 50;
    
    self.sepaView.frame = CGRectMake(15, CGRectGetMaxY(self.contentView.frame) - 0.5, self.contentView.width - 15, 0.5);
    
    self.scoreLabel.frame = CGRectMake(self.contentView.width - 50 - 15, 0, 50, 20);
    self.scoreLabel.centerY = self.timeLabel.centerY;
}

- (void)setModel:(QuestionnaireModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.votetitle;
    self.timeLabel.text = [NSString stringWithFormat:@"截止时间：%@",model.etime];
    
    if ([model.partake isEqualToString:@"1"]) { //1未参与  2已参与
        if ([model.start isEqualToString:@"1"]) { //1已开始
            self.scoreLabel.text = @"已开始";
            self.scoreLabel.textColor = MainColor;
        }else
        {
            self.scoreLabel.text = @"未开始";
            self.scoreLabel.textColor = AuxiliaryColor;
        }
    }else
    {
        self.scoreLabel.textColor = AuxiliaryColor;
        if ([model.guoqi isEqualToString:@"1"]) { //1已过期 0未过期
            self.scoreLabel.text = @"已结束";
        }else
        {
            self.scoreLabel.text = @"未结束";
        }
    }
}

@end
