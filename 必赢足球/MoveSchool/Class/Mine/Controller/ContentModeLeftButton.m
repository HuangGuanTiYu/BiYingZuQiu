//
//  ContentModeLeftButton.m
//  zhitongti
//
//  Created by edz on 2017/5/25.
//  Copyright © 2017年 caobohua. All rights reserved.
//

#import "ContentModeLeftButton.h"
#import "UIView+Extension.h"

@implementation ContentModeLeftButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, (self.height - 22) * 0.5, 22, 22);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(32, 0, self.width - 32, self.height);
}

@end
