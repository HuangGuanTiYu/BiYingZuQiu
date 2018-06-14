//
//  CountDownButton.m
//  SchoolBus
//
//  Created by 顾海波 on 2017/3/25.
//  Copyright © 2017年 顾海波. All rights reserved.
//  倒计时按钮

#import "CountDownButton.h"

@implementation CountDownButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(countDownClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(countDownClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark 倒计时按钮点击
- (void) countDownClick : (UIButton *) button
{
    if ([self.delegate respondsToSelector:@selector(getMobileCode:)]) {
        [self.delegate getMobileCode:self];
    }
}

@end
