

//
//  NOContentView.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/20.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "NOContentView.h"
#import "UIView+Extension.h"

@implementation NOContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView *vw=[[UIImageView alloc]init];
        vw.image=[UIImage imageNamed:_image];
        [self addSubview:vw];
        self.vw=vw;
        
        UIButton *btn=[[UIButton alloc]init];
        [btn  setTitle:_title forState:UIControlStateNormal];
        [self addSubview:btn];
        self.btn=btn;
    };

    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.vw.frame=CGRectMake(self.width/3, 0, self.width/3, self.width/3);
    self.btn.frame=CGRectMake(0, 0, self.width, 50);
    self.vw.centerX=self.centerX;
    self.btn.centerX=self.centerX;
    self.vw.centerY=self.centerY-self.width/6-30;
    self.btn.centerX=self.centerY+25+30;

}


@end
