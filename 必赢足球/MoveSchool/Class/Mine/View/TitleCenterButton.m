//
//  TitleCenterButton.m
//  MoveSchool
//
//  Created by edz on 2017/7/27.
//
//

#import "TitleCenterButton.h"

@implementation TitleCenterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{

    return CGRectMake((self.width - 50) * 0.5, 0, 100, self.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.width - mainSpacing - self.height, 0, self.height, self.height);
}

@end
