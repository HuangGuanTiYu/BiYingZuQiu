//
//  TopImageButton.m
//  zhitongti
//
//  Created by edz on 2017/4/8.
//  Copyright © 2017年 caobohua. All rights reserved.
//

#import "TopImageButton.h"
#import "UIView+Extension.h"

@implementation TopImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.titleLabel.textColor = MainTextColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.centerY = self.height * 0.5;
    
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.width, 30);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.imageSize, self.imageSize);
}

@end
