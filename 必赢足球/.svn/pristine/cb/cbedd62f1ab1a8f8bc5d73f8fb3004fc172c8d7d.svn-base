//
//  ApplyTeacherCell.m
//  zhitongti
//
//  Created by edz on 2017/5/25.
//  Copyright © 2017年 caobohua. All rights reserved.
//

#import "ApplyTeacherCell.h"
#import "UIView+Extension.h"

@interface ApplyTeacherCell()

//title
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *sepaView;

@end

@implementation ApplyTeacherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = MainTextColor;
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.contentView addSubview:self.titleLabel];
        
        self.textField = [[UITextField alloc] init];
        self.textField.font = [UIFont systemFontOfSize:ys_28];
        [self.contentView addSubview:self.textField];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 0, 80, self.contentView.height);
    self.titleLabel.centerY = self.contentView.height * 0.5;
    [self.titleLabel sizeToFit];
    self.titleLabel.height = self.contentView.height;
    
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + mainSpacing, 0, self.contentView.width - CGRectGetMaxX(self.titleLabel.frame) - 10, self.contentView.height);
    self.textField.centerY = self.titleLabel.centerY;
    
    self.sepaView.frame = CGRectMake(15, self.contentView.height - 0.5, self.contentView.width - 10, 0.5);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setPlaceholderString:(NSString *)placeholderString
{
    _placeholderString = placeholderString;
    
    self.textField.placeholder = placeholderString;
}

@end
