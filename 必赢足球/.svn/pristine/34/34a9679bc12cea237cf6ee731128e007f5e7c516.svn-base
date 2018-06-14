//
//  ExamineNoReadCell.m
//  MoveSchool
//
//  Created by edz on 2017/7/27.
//
//

#import "ExamineNoReadCell.h"
#import "MessageModel.h"
#import "UIImageView+WebCache.h"

@interface ExamineNoReadCell()

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *examineButton;


@end

@implementation ExamineNoReadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backView = [[UIView alloc] init];
        [self.contentView addSubview:self.backView];
        
        self.headerView = [[UIImageView alloc] init];
        [self.backView addSubview:self.headerView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.text = @"中小企业如何运用互联网技术推广产品";
        self.titleLabel.textColor = RGBColor(48,48,48);
        [self.backView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:12];
        self.contentLabel.text = @"陈老师的课程审核";
        self.contentLabel.textColor = RGBColor(143,143,143);
        [self.backView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = RGBColor(143,143,143);
        self.timeLabel.text = @"2017-06-18 13:30";
        [self.backView addSubview:self.timeLabel];
        
        self.examineButton = [[UIButton alloc] init];
        self.examineButton.layer.cornerRadius = 2.5;
        self.examineButton.layer.masksToBounds = YES;
        self.examineButton.layer.borderColor = GreenColor.CGColor;
        self.examineButton.layer.borderWidth = 0.5;
        [self.examineButton setTitleColor:GreenColor forState:UIControlStateNormal];
        [self.examineButton setTitle:@"待审核" forState:UIControlStateNormal];
        self.examineButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.examineButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, 0, self.contentView.width, 70);
    
    self.headerView.frame = CGRectMake(15, 15, 36, 36);
    self.headerView.layer.cornerRadius = 18;
    self.headerView.layer.masksToBounds = YES;
    
    CGFloat labelW = CGRectGetMaxX(self.headerView.frame) + mainSpacing;
    self.titleLabel.frame = CGRectMake(labelW, self.headerView.y, self.backView.width - labelW, 30);
    
    self.contentLabel.frame = CGRectMake(self.titleLabel.x, 0, 0, self.backView.height * 0.4);
    
    CGFloat timeW = 100;
    self.timeLabel.frame = CGRectMake(self.backView.width - timeW - mainSpacing, 0, timeW, self.contentLabel.height);
    self.timeLabel.centerY = self.contentLabel.centerY;
    
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
    [self.timeLabel sizeToFit];
    
    self.contentLabel.y = CGRectGetMaxY(self.titleLabel.frame) + mainSpacing - 2;
    self.timeLabel.centerY = self.contentLabel.centerY;
    
    self.contentLabel.width = self.timeLabel.x - labelW;
    
    self.examineButton.frame = CGRectMake(self.contentLabel.x, CGRectGetMaxY(self.contentLabel.frame) + mainSpacing, 50, 20);
    
}

- (void)setModel:(MessageModel *)model
{
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.headpic] placeholderImage:[UIImage imageNamed:@"headerNormal"]];
    
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.info;
    self.timeLabel.text = model.indate;
}

@end
