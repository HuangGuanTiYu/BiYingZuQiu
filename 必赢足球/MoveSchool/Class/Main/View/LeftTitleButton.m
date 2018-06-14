//
//  LeftTitleButton.m
//  MoveSchool
//
//  Created by edz on 2017/10/25.
//
//

#import "LeftTitleButton.h"

@implementation LeftTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.width - 20, self.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.width - 22, 0, 22, self.height);
}

@end
