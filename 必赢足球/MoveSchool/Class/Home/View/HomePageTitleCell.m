//
//  HomePageTitleCell.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/17.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "HomePageTitleCell.h"

@interface HomePageTitleCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomePageTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = MainTextColor;
        self.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
        [self.contentView addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (void)setIndate:(NSString *)indate
{
    _indate = indate;
    
    self.titleLabel.text = indate;
}

@end
