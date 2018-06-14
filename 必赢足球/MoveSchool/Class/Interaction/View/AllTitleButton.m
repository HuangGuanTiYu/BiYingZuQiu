//
//  AllTitleButton.m
//  MoveSchool
//
//  Created by edz on 2017/5/17.
//
//

#import "AllTitleButton.h"
#import "UIColor+Hex.h"

@implementation AllTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel sizeToFit];
        [self setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#c5c8bf"]] forState:UIControlStateHighlighted];

    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return self.bounds;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectZero;
}

@end
