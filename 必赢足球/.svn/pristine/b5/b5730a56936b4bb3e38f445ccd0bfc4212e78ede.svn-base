//
//  MessageInteractionCell.m
//  MoveSchool
//
//  Created by edz on 2017/8/4.
//
//

#import "MessageInteractionCell.h"
#import "MessageModel.h"
#import "UIImageView+WebCache.h"

@interface MessageInteractionCell()

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MessageInteractionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.headerView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = RGBColor(143,143,143);
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.textColor = RGBColor(48,48,48);
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = RGBColor(143,143,143);
        [self.contentView addSubview:self.timeLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerView.frame = CGRectMake(15, 15, 36, 36);
    self.headerView.layer.cornerRadius = 18;
    self.headerView.layer.masksToBounds = YES;
    
    CGFloat timeW = 100;
    self.timeLabel.frame = CGRectMake(self.contentView.width - timeW - mainSpacing, self.headerView.y, timeW, 30);
    
    CGFloat titleX = CGRectGetMaxX(self.headerView.frame) + mainSpacing;
    self.titleLabel.frame = CGRectMake(titleX, self.timeLabel.y, 0, self.timeLabel.height);
    
    self.contentLabel.frame = CGRectMake(self.titleLabel.x, 0, self.contentView.width - CGRectGetMaxX(self.titleLabel.frame) - mainSpacing * 2, 0);
    
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
    [self.timeLabel sizeToFit];
    
    self.titleLabel.width = self.timeLabel.x - CGRectGetMaxX(self.headerView.frame) - 2 * mainSpacing;
    self.contentLabel.y = CGRectGetMaxY(self.titleLabel.frame) + mainSpacing - 2;
}

- (void)setModel:(MessageModel *)model
{
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.headpic] placeholderImage:[UIImage imageNamed:@"headerNormal"]];
    
    self.timeLabel.text = model.indate;
    
    NSMutableString *title = [NSMutableString string];
    if (model.nickname.length > 0) {
        [title appendString:model.nickname];
    }
    
    if (model.desc.length > 0) {
        [title appendString:model.desc];
    }
    self.titleLabel.text = title;
    
    NSMutableString *content = [NSMutableString string];
    if (model.title.length > 0) {
        [content appendString:[NSString stringWithFormat:@"《%@》",model.title]];
    }
    
    if (model.info.length > 0) {
        [content appendString:model.info];
    }
    
    if (model.title.length > 0) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:content];
        [string addAttribute:NSForegroundColorAttributeName value:GreenColor range:[content rangeOfString:[NSString stringWithFormat:@"《%@》",model.title]]];
        self.contentLabel.attributedText = string;
    }else
    {
        self.contentLabel.text = content;
    }

    self.contentLabel.height = model.interactionCellHeight;
}

@end
