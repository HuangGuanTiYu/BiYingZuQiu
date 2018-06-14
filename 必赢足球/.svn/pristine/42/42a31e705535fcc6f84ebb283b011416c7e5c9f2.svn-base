//
//  NewMessageCell.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "NewMessageCell.h"
#import "UIImageView+WebCache.h"
#import "MessageModel.h"

@interface NewMessageCell()

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation NewMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.headerView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.text = @"第二期骨干学习培训专题";
        self.titleLabel.textColor = RGBColor(48,48,48);
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:12];
        self.contentLabel.text = @"[陈老师]发送专题学习";
        self.contentLabel.textColor = RGBColor(143,143,143);
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = RGBColor(143,143,143);
        self.timeLabel.text = @"2017-06-18 13:30";
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerView.frame = CGRectMake(mainSpacing + 5.5, 0, 36, 36);
    self.headerView.centerY = self.contentView.height * 0.5;
    self.headerView.layer.cornerRadius = 18;
    self.headerView.layer.masksToBounds = YES;
    self.headerView.backgroundColor = [UIColor redColor];
    
    CGFloat labelW = CGRectGetMaxX(self.headerView.frame) + mainSpacing - 2;
    self.titleLabel.frame = CGRectMake(labelW, self.headerView.y - 1.5, self.contentView.width - labelW, self.contentView.height * 0.6);
    
    self.contentLabel.frame = CGRectMake(self.titleLabel.x, self.titleLabel.height - 3, 0, self.contentView.height * 0.4);

    CGFloat timeW = 100;
    self.timeLabel.frame = CGRectMake(self.contentView.width - timeW - mainSpacing, 0, timeW, self.contentLabel.height);
    self.timeLabel.centerY = self.contentLabel.centerY;
    
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
    [self.timeLabel sizeToFit];
    
    self.contentLabel.width = self.timeLabel.x - labelW;

}

- (void)setModel:(MessageModel *)model
{
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.headpic] placeholderImage:[UIImage imageNamed:@"headerNormal"]];
    
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.indate;
    
    NSMutableString *contentString = [NSMutableString string];
    if (model.nickname.length > 0) {
        [contentString appendString:[NSString stringWithFormat:@"[%@]",model.nickname]];
    }
    
    if (model.desc.length > 0) {
        [contentString appendString:model.desc];
    }
    
    self.contentLabel.text = contentString;
}

@end
