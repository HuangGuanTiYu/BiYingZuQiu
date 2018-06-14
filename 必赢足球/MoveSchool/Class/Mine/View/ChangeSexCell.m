//
//  ChangeSexCell.m
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import "ChangeSexCell.h"
#import "TBCityIconFont.h"

@interface ChangeSexCell()

@end

@implementation ChangeSexCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabe = [[UILabel alloc] init];
        self.titleLabe.textAlignment = NSTextAlignmentCenter;
        self.titleLabe.font = [UIFont systemFontOfSize:ys_28];
        self.titleLabe.textColor = MainTextColor;
        [self.contentView addSubview:self.titleLabe];
        
        self.selectButton = [[UIButton alloc] init];
        self.selectButton.userInteractionEnabled = NO;
        self.selectButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.selectButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e623", ys_28, [UIColor clearColor])] forState:UIControlStateNormal];
        [self.selectButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e623", ys_28, MainColor)] forState:UIControlStateSelected];
        [self.contentView addSubview:self.selectButton];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.selectButton.frame = CGRectMake(self.contentView.width - 15 - 18, 0, 18, 18);
    self.selectButton.centerY = self.contentView.height * 0.5;
    
    self.titleLabe.frame = CGRectMake(15, 0, CGRectGetMaxX(self.selectButton.frame) - 15, self.contentView.height);
    
    self.sepaView.frame = CGRectMake(15, self.contentView.height - 0.5, self.contentView.width - 15, 0.5);

}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabe.text = title;
}

@end
