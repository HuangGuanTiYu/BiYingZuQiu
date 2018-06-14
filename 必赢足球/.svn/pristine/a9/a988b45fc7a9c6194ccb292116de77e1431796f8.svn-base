//
//  SCSearchBar.m
//  search
//
//  Created by yuhongtao on 16/8/1.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "SCSearchBar.h"
#import "UIView+Extension.h"

@implementation SCSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(300, 30);
        self.font = [UIFont systemFontOfSize:14];
        self.placeholder = @"请输入查询条件";
        // 提前在Xcode上设置图片中间拉伸
        self.background = [UIImage imageNamed:@"search_box"];
        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"search_btn"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.size = CGSizeMake(30, 30);
        [self setValue:kColorGray154 forKeyPath:@"_placeholderLabel.textColor"];
        [self setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        
        self.layer.borderColor = kColorGray225.CGColor;
        self.layer.borderWidth = 1;
 
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}

@end
