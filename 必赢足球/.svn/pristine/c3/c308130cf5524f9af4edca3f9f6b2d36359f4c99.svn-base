//
//  ApplyTeacherDescribeCell.m
//  zhitongti
//
//  Created by edz on 2017/5/25.
//  Copyright © 2017年 caobohua. All rights reserved.
//

#import "ApplyTeacherDescribeCell.h"
#import "UIView+Extension.h"
#import "UITextView+Placeholder.h"

@interface ApplyTeacherDescribeCell()

@property (nonatomic, strong) UIView *sepaView;

@property (nonatomic, strong) UIView *textBackView;

@end

@implementation ApplyTeacherDescribeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = ViewBackColor;
        [self.contentView addSubview:self.sepaView];
        
        self.textBackView = [[UIView alloc] init];
        self.textBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.textBackView];

        self.textView = [[UITextView alloc] init];
        self.textView.font = [UIFont systemFontOfSize:ys_f24];
        self.textView.backgroundColor = [UIColor whiteColor];
        [self.textBackView addSubview:self.textView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textBackView.frame = CGRectMake(0, mainSpacing, self.contentView.width, self.contentView.height  - 20);
    
    self.textView.frame = CGRectMake(13, 0, self.textBackView.width - 30, self.textBackView.height);
    
    self.sepaView.frame = CGRectMake(0, 0, self.contentView.width, mainSpacing);
}

- (void)setPlaceholderString:(NSString *)placeholderString
{
    _placeholderString = placeholderString;
    
    self.textView.placeholder = self.placeholderString;

}

@end
