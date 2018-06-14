//
//  CollectionReusableView.m
//  MoveTag
//
//  Created by txx on 16/12/21.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.buttonView];
        
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, self.buttonView.height)];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitle:@"添加" forState:UIControlStateNormal];
        [addButton setTitleColor:MainColor forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.buttonView addSubview:addButton];
        
        UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addButton.frame) + mainSpacing, 0, 1, self.buttonView.height * 0.4)];
        sepaView.backgroundColor = MainColor;
        sepaView.centerY = self.buttonView.height * 0.5;
        [self.buttonView addSubview:sepaView];
        
        UILabel *editButton = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sepaView.frame) + mainSpacing, 0, 25, self.buttonView.height)];
        editButton.userInteractionEnabled = YES;
        self.editLabel = editButton;
        [editButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editButtonClick)]];
        editButton.text = @"编辑";
        editButton.textColor = MainColor;
        editButton.font = [UIFont systemFontOfSize:ys_f24];
        [self.buttonView addSubview:editButton];
        
        //没有评论
        UIView *noCommentView = [[UIView alloc] init];
        noCommentView.hidden = YES;
        self.noCommentView = noCommentView;
        [self addSubview:noCommentView];
        
        //图片 + 文字
        UIView *imageTexgView = [[UIView alloc] init];
        self.imageTexgView = imageTexgView;
        [noCommentView addSubview:imageTexgView];
        
        //背景图
        UIImageView *noImage = [[UIImageView alloc] init];
        self.noImage = noImage;
        noImage.image = [UIImage imageNamed:@"kong"];
        [imageTexgView addSubview:noImage];
        
        UILabel *toTestLabel = [[UILabel alloc] init];
        self.toTestLabel = toTestLabel;
        toTestLabel.textAlignment = NSTextAlignmentCenter;
        toTestLabel.text = @"还没有内容呀~";
        toTestLabel.textColor = AuxiliaryColor;
        toTestLabel.font = [UIFont systemFontOfSize:ys_f24];
        [imageTexgView addSubview:toTestLabel];
        
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 0, self.width - 30, 50);
    
    self.buttonView.centerY = self.titleLabel.centerY;
    self.noCommentView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + mainSpacing * 3, self.width, 90);
    self.noCommentView.centerX = self.width * 0.5;
    
    self.imageTexgView.frame = CGRectMake(0, 0, self.noCommentView.width, 129);
    self.imageTexgView.centerY = self.noCommentView.height * 0.5;
    
    self.noImage.frame = CGRectMake(0, 0, 95, 70);
    self.noImage.centerX = self.noCommentView.width * 0.5;
    
    self.toTestLabel.frame = CGRectMake(0, CGRectGetMaxY(self.noImage.frame) + 5, self.noCommentView.width, 20);

}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIView *)buttonView {
    if (!_buttonView) {
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(self.width - 70 - 15, 0, 70, 25)];
        [self addSubview:buttonView];

        _buttonView = buttonView;
    }
    return _buttonView;
}

- (void)setButtonClick:(BOOL)buttonClick
{

    _buttonClick = buttonClick;
    
    if (buttonClick) {
        self.editLabel.text = @"编辑";
    }else
    {
        self.editLabel.text = @"完成";
    }
}

- (void)setIsMy:(BOOL)isMy
{
    _isMy = isMy;
    
    self.buttonView.hidden = !isMy;

}

- (void) addButtonClick
{

    if ([self.delegate respondsToSelector:@selector(addTag)]) {
        [self.delegate addTag];
    }
}

- (void) editButtonClick
{
    if ([self.editLabel.text isEqualToString:@"编辑"]) {
        self.editLabel.text = @"完成";
        if ([self.delegate respondsToSelector:@selector(editState:)]) {
            [self.delegate editState:NO];
        }
    }else
    {
        self.editLabel.text = @"编辑";
        if ([self.delegate respondsToSelector:@selector(editState:)]) {
            [self.delegate editState:YES];
        }
    }
}

@end
