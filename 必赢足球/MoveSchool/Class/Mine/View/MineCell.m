//
//  MineCell.m
//  MoveSchool
//
//  Created by edz on 2017/8/21.
//
//

#import "MineCell.h"
#import "TBCityIconFont.h"

@interface MineCell()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *nextView;

@end

@implementation MineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = MainTextColor;
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.contentView addSubview:self.titleLabel];
        
        self.nextView = [[UIImageView alloc] init];
        self.nextView.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", ys_f24, AuxiliaryColor)];
        [self.contentView addSubview:self.nextView];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
        
        self.newsLabel = [[UILabel alloc] init];
        self.newsLabel.hidden = YES;
        self.newsLabel.layer.cornerRadius = 2.5;
        self.newsLabel.layer.masksToBounds = YES;
        self.newsLabel.textAlignment = NSTextAlignmentCenter;
        self.newsLabel.text = @"New";
        self.newsLabel.textColor = [UIColor whiteColor];
        self.newsLabel.backgroundColor = MainColor;
        self.newsLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.newsLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(15, 0, 19, 19);
    self.iconView.centerY = self.contentView.height * 0.5;
    
    self.nextView.frame = CGRectMake(self.contentView.width - 15 - 15, 0, 15, 15);
    self.nextView.centerY = self.contentView.height * 0.5;
    
    CGFloat titleLabelX = CGRectGetMaxX(self.iconView.frame) + mainSpacing;
    self.titleLabel.frame = CGRectMake(titleLabelX, 0, self.nextView.x - titleLabelX, self.height);
    
    self.sepaView.frame = CGRectMake(self.iconView.x, self.contentView.height - 0.5, self.contentView.width - self.iconView.x, 0.5);
    
    self.newsLabel.frame = CGRectMake(self.nextView.x - mainSpacing - 30, 0, 30, 15);
    self.newsLabel.centerY = self.nextView.centerY;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setIconText:(NSString *)iconText
{
    _iconText = iconText;
    
    self.iconView.image = [UIImage iconWithInfo:TBCityIconInfoMake(self.iconText, 20, MainTextColor)];
}

@end
