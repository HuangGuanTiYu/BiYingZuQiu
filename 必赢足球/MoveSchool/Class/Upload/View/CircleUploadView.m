//
//  CircleUploadView.m
//  TXChat
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//
#import "CircleUploadView.h"

@implementation CircleUploadView

- (id)init{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        [self initView];
    }
    return self;
}

- (void)initView{
    _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _uploadBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _uploadBtn.imageView.clipsToBounds = YES;
    _uploadBtn.frame = CGRectMake(0, 0, 94, 94);
    [self addSubview:_uploadBtn];
    
    _vProgress = [[DAProgressOverlayView alloc] initWithFrame:_uploadBtn.bounds];
    _vProgress.userInteractionEnabled = NO;
    _vProgress.progress = 0.1;
    [self addSubview:_vProgress];
}

@end
