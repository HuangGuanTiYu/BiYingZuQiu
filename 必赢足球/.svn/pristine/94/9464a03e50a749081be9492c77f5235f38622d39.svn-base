//
//  PersonMessageCell.m
//  MoveSchool
//
//  Created by edz on 2017/10/13.
//
//

#import "PersonMessageCell.h"
#import "UIImageView+WebCache.h"

@interface PersonMessageCell()

//标题
@property (nonatomic, strong) UILabel *titleLabel;

//附标题
@property (nonatomic, strong) UILabel *cacheLabel;

@end

@implementation PersonMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.titleLabel.textColor = MainTextColor;
        [self.contentView addSubview:self.titleLabel];
        
        self.cacheLabel = [[UILabel alloc] init];
        self.cacheLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.cacheLabel.textColor = AuxiliaryColor;
        self.cacheLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.cacheLabel];
        
        self.divisionView = [[UIView alloc] init];
        self.divisionView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.divisionView];
        
        self.headerImage = [[UIImageView alloc] init];
        self.headerImage.hidden = YES;
        [self.contentView addSubview:self.headerImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 0, 0, self.height);
    [self.titleLabel sizeToFit];
    self.titleLabel.height = self.height;
    
    self.cacheLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + mainSpacing, 0, 0, self.height);
    
    self.cacheLabel.width = self.contentView.width - CGRectGetMaxX(self.titleLabel.frame) - 30;
    
    self.divisionView.frame = CGRectMake(15, self.contentView.height - 0.5, self.contentView.width, 0.5);
    
    self.headerImage.frame = CGRectMake(0, 0, 34, 34);
    self.headerImage.x = self.contentView.width - 34 - mainSpacing;
    self.headerImage.centerY = self.contentView.height * 0.5;
    self.headerImage.layer.cornerRadius = 17;
    self.headerImage.layer.masksToBounds = YES;
    
}

- (void)setTitle:(NSString *)title
{
    
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle
{
    
    _subTitle = subTitle;
    
    if ([self.title isEqualToString:@"头像"]) {
        self.cacheLabel.text = @"";

        self.headerImage.hidden = NO;
        
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:subTitle] placeholderImage:[UIImage imageNamed:@"my_touxiang"]];
    }else
    {
        self.cacheLabel.text = subTitle;

        self.headerImage.hidden = YES;
    }
}

@end
