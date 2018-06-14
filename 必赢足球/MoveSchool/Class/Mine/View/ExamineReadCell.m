//
//  ExamineReadCell.m
//  MoveSchool
//
//  Created by edz on 2017/7/27.
//
//

#import "ExamineReadCell.h"
#import "MessageModel.h"
#import "UIImageView+WebCache.h"

@interface ExamineReadCell()

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *resonLabel;


@end

@implementation ExamineReadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backView = [[UIView alloc] init];
        [self.contentView addSubview:self.backView];
        
        self.headerView = [[UIImageView alloc] init];
        [self.backView addSubview:self.headerView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = RGBColor(48,48,48);
        [self.backView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:12];
        self.contentLabel.textColor = RGBColor(143,143,143);
        [self.backView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = RGBColor(143,143,143);
        [self.backView addSubview:self.timeLabel];
        
        self.resonLabel = [[UILabel alloc] init];
        self.resonLabel.numberOfLines = 0;
        self.resonLabel.font = [UIFont systemFontOfSize:12];
        self.resonLabel.textColor = RGBColor(143,143,143);
        [self.contentView addSubview:self.resonLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, 0, self.contentView.width, 70);
    
    self.headerView.frame = CGRectMake(15, 15, 36, 36);
    self.headerView.centerY = self.backView.height * 0.5;
    self.headerView.layer.cornerRadius = 22;
    self.headerView.layer.masksToBounds = YES;
    self.headerView.backgroundColor = [UIColor redColor];
    
    CGFloat labelW = CGRectGetMaxX(self.headerView.frame) + mainSpacing;
    self.titleLabel.frame = CGRectMake(labelW, self.headerView.y, self.backView.width - labelW, 30);
    
    self.contentLabel.frame = CGRectMake(self.titleLabel.x, 0, 0, 30);
    
    CGFloat timeW = 100;
    self.timeLabel.frame = CGRectMake(self.backView.width - timeW - mainSpacing, 0, timeW, self.contentLabel.height);
    self.timeLabel.centerY = self.contentLabel.centerY;
    
    self.resonLabel.frame = CGRectMake(self.contentLabel.x, 0, self.titleLabel.width, 0);
    
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
    [self.timeLabel sizeToFit];
    [self.resonLabel sizeToFit];
    
    self.contentLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 5;
    
    self.resonLabel.y = CGRectGetMaxY(self.contentLabel.frame) + 5;
    
    self.contentLabel.width = self.timeLabel.x - labelW;
    
    self.timeLabel.centerY = self.contentLabel.centerY;
    
}

- (void)setModel:(MessageModel *)model
{
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.headpic] placeholderImage:[UIImage imageNamed:@"headerNormal"]];
    
    self.titleLabel.text = model.title;
    
    NSMutableString *content = [NSMutableString string];
    if (model.nickname.length > 0) {
        [content appendString:[NSString stringWithFormat:@"%@：",model.nickname]];
    }
    
    if (model.desc.length > 0) {
        [content appendString:model.desc];
    }
    
    if (content.length > 0) {
        if ([@"审核不通过" isEqualToString:model.desc]) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:content];
            [string addAttribute:NSForegroundColorAttributeName value:GreenColor range:NSMakeRange(0, content.length)];
            self.contentLabel.attributedText = string;
        }else
        {
            self.contentLabel.text = content;
        }
    }
    
    self.timeLabel.text = model.indate;
    
    if (model.auditopinion.length > 0) {
        NSMutableString *string = [NSMutableString string];
        [string appendFormat:@"理由：%@",model.auditopinion];
        
        self.resonLabel.text = string;
        
        self.resonLabel.height = model.auditopinionCellHeight;
    }else
    {
        self.resonLabel.text = @"";
    }

}

@end
