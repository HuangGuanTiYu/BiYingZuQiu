//
//  CollectionViewCell.m
//  MoveTag
//
//  Created by txx on 16/12/21.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+CornerRadius.h"
#import "TBCityIconFont.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.deleteButton];
    }
    return self;
}

-(void)setEditeState:(BOOL)editeState
{
    _editeState = editeState ;
    self.titleLabel.backgroundColor = _editeState ? [UIColor whiteColor] :[UIColor whiteColor];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
    self.deleteButton.frame = CGRectMake(0, 0, ys_f30, ys_f30);
    self.deleteButton.centerX = self.contentView.width;
    self.deleteButton.centerY = 0;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}

-(UIButton *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UIButton alloc] init];
        _titleLabel.enabled = NO;
        _titleLabel.layer.borderColor = AuxiliaryColor.CGColor;
        _titleLabel.layer.borderWidth = 0.5;
        
        UIImageView *normalImage = [[UIImageView alloc] initWithFrame:_titleLabel.bounds];
        [normalImage zy_cornerRadiusAdvance:2 rectCornerType:UIRectCornerAllCorners];
        normalImage.image = [UIImage createImageWithColor:[UIColor whiteColor]];
        [_titleLabel setBackgroundImage:normalImage.image forState:UIControlStateNormal];
        _titleLabel.layer.cornerRadius = 2;
        
        _titleLabel.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [_titleLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        _titleLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *) deleteButton
{

    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e663", ys_f30, AuxiliaryColor)] forState:UIControlStateNormal];
    }
    
    return _deleteButton;
}

- (void) deleteButtonClick
{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:self];
    }
}

@end
