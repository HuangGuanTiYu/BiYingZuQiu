//
//  LeftStyleButton.m
//  MoveSchool
//
//  Created by edz on 2017/6/3.
//
//

#import "LeftStyleButton.h"

@implementation LeftStyleButton

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
    return CGRectMake(13 + 5, 0, self.width - 13, self.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, (self.height - 21) * 0.5, 13, 21);
}

@end
