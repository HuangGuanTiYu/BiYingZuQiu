//
//  CourseCollectioncell.m
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "CourseCollectioncell.h"
#import "UIImageView+WebCache.h"

@implementation CourseCollectioncell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        // 视频图片
        CGFloat width = frame.size.width-20;
        CGFloat  height =  width*9/16;
        
        self.courseImageview=[[UIImageView alloc]init];
        self.courseImageview.frame=CGRectMake(10, 10, width, height);
        self.courseImageview.image=[UIImage imageNamed:@"common_no_image"];
        self.courseImageview.clipsToBounds = YES;
        [self addSubview:self.courseImageview];
        
        // 视频名字
        self.name = [[UILabel alloc]init];
        self.name.text=@"设计师学习课程";
        self.name.frame = CGRectMake(10, frame.size.height-45, frame.size.width-20,20);
        self.name.font = [UIFont systemFontOfSize:13.5];
        self.name.textAlignment=NSTextAlignmentLeft;
        self.name.textColor=kColorBlack;
        [self addSubview:self.name];
        
        
        self.number=[[UIButton alloc]init];
        self.number.frame=CGRectMake(self.frame.size.width-40-15, frame.size.height-20-40-40, 45, 20);
        [self.number setTitle:@"课程" forState:UIControlStateNormal];
        self.number.backgroundColor =[UIColor colorWithWhite:0.1 alpha:0.7];
        self.number.titleLabel.font=[UIFont systemFontOfSize:12];
        [self.number setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.number.layer.masksToBounds= YES;
        self.number.layer.cornerRadius = self.number.frame.size.height/2;
        [ self.courseImageview addSubview:self.number];
        
    }
    return self;
}

-(void)setModel:(CourseHotModel *)model{
    //1课程，2 直播，3沙龙，4 专题

    [self.courseImageview sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    NSString *  type;
    if ([model.type isEqualToString:@"1"] || [model.type isEqualToString:courseType]) {
        type = @"课程";
    }else if([model.type isEqualToString:@"2"] || [model.type isEqualToString:liveType]) {
        type = @"直播";
    }else if([model.type isEqualToString:@"3"] || [model.type isEqualToString:shalongType]) {
        type = @"沙龙";
    }else if([model.type isEqualToString:@"4"] || [model.type isEqualToString:@"40100"]){
        type = @"专题";
    }else{
        type = @"";
    }
    [self.number setTitle:type forState:UIControlStateNormal];
    self.name.text=model.title;
}
@end
