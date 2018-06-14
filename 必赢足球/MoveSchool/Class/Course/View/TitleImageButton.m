//
//  Huanyihuan.m
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "TitleImageButton.h"

@implementation TitleImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel sizeToFit];
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 2, self.width - 14, 15);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(self.width - 14, 0, 14 , 15);
}

@end
