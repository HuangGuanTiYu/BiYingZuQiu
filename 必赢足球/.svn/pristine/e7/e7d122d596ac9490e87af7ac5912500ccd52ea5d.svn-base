//
//  SetLanguageCell.m
//  MoveSchool
//
//  Created by edz on 2017/9/17.
//
//

#import "SetLanguageCell.h"
#import "TBCityIconFont.h"

@interface SetLanguageCell()

@property (nonatomic, strong) UILabel *titleLabe;

@end

@implementation SetLanguageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabe = [[UILabel alloc] init];
        self.titleLabe.font = [UIFont systemFontOfSize:ys_f24];
        self.titleLabe.textColor = MainTextColor;
        [self.contentView addSubview:self.titleLabe];
        
        self.selectButton = [[UIButton alloc] init];
        self.selectButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.selectButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e623", 18, [UIColor clearColor])] forState:UIControlStateNormal];
        [self.selectButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e623", 18, MainColor)] forState:UIControlStateSelected];
        [self.contentView addSubview:self.selectButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.selectButton.frame = CGRectMake(self.contentView.width - 15 - 18, 0, 18, 18);
    self.selectButton.centerY = self.contentView.height * 0.5;

    self.titleLabe.frame = CGRectMake(15, 0, CGRectGetMaxX(self.selectButton.frame) - 15, self.contentView.height);
    
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabe.text = title;
}


@end
