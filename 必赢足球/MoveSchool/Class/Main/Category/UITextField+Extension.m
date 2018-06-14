//
//  UITextField+Extension.m
//  SchoolBus
//
//  Created by 顾海波 on 2017/3/24.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void) setLefSpacing : (CGFloat) width
{
    CGRect frame = [self frame];
    frame.size.width = width;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

@end
