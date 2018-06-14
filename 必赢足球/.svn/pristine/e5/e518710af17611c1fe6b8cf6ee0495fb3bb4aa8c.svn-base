//
//  FindCell.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/18.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "FindCell.h"
#import "TopImageButton.h"
#import "FindModel.h"

@interface FindCell()

@property (nonatomic, strong) TopImageButton *button;

@end

@implementation FindCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.button = [[TopImageButton alloc] init];
        self.button.imageSize = 51;
        [self.button setTitleColor:MainTextColor forState:UIControlStateNormal];
        [self.contentView addSubview:self.button];
        self.button.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
        [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void) buttonClick
{
    if ([self.delegate respondsToSelector:@selector(findCellClick:)]) {
        [self.delegate findCellClick:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
}

- (void)setModel:(FindModel *)model
{
    _model = model;
    
    [self.button setTitle:model.title forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:model.imageText] forState:UIControlStateNormal];
}


@end
