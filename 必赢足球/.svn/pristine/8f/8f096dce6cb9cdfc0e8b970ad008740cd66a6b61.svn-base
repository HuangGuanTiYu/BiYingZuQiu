//
//  LiveTableViewCell.m
//  zhitongti
//
//  Created by edz on 2016/11/28.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "LiveTableViewCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

#define space  10

@implementation LiveTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UIColor *color = RGBCOLOR(100, 100, 100);
        UIColor *deacriblecolor=RGBCOLOR(170, 170, 170);
        UIImageView  *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width/3, self.frame.size.width/4)];
        imgView.image=[UIImage imageNamed:@"icon"];
        imgView.backgroundColor=[UIColor grayColor];
        self.imgView=imgView;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
  
        
        UILabel *typeL=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/3-50-10, 60, 50, 20)];
        typeL.text = @"直播";
        typeL.layer.masksToBounds = YES;
        typeL.layer.cornerRadius = 10;
        typeL.backgroundColor =[UIColor colorWithWhite:0.3 alpha:0.8];
        typeL.font = [UIFont systemFontOfSize:12];
        typeL.textAlignment = NSTextAlignmentCenter;
        self.typeL = typeL;
        [imgView addSubview:typeL];
        //标题
        UILabel *titel=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, 5, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5)];
        titel.text=@"三十分钟轻松制作HTML5交互动画";
        self.titel=titel;
        titel.font=[UIFont systemFontOfSize:13];
        titel.textColor=color;
        [self addSubview:titel];
        
        
        
        //举办时间
        UILabel *teacher=[[UILabel alloc]initWithFrame:CGRectMake(10,10,10,10)];
        teacher.font=[UIFont systemFontOfSize:13];
        teacher.textColor=deacriblecolor;
        teacher.text=@"讲师：攻入个";
        teacher.font=[UIFont systemFontOfSize:13];
        self.teacher=teacher;
        [self addSubview:teacher];
        
        //举办时间详情
        UILabel *teacherLV=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, teacher.frame.size.height+teacher.frame.origin.y, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5*2)];
        teacherLV.numberOfLines=0;
        
        teacherLV.text=@"LV1";
        teacherLV.layer.cornerRadius=3;
        teacherLV.layer.masksToBounds=YES;
        teacherLV.layer.borderWidth=0.5;
        teacherLV.layer.borderColor= kColorGray225.CGColor;
        teacherLV.backgroundColor=RGBACOLOR(242, 202, 14, 1);
        
        teacherLV.font=[UIFont systemFontOfSize:9];
        teacherLV.textColor=[UIColor blackColor];
        self.teacherLV=teacherLV;
        [self addSubview:teacherLV];

        //图标
        UIImageView *imageX = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 12, 12)];
        imageX.image =[UIImage imageNamed:@"common_live_time"];
        
        self.imageX =imageX;
        [self addSubview:imageX];
        
        
        //举办时间详情
        UILabel *leartime=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, teacher.frame.size.height+teacher.frame.origin.y, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5*2)];
        leartime.numberOfLines=0;
        
        leartime.text=@"06-01  10:30";
        
        leartime.font=[UIFont systemFontOfSize:12];
        leartime.textColor=kColorGray86;
        self.leartime=leartime;
        [self addSubview:leartime];
        

        self.linelable=[[UILabel alloc]initWithFrame:CGRectMake(10, self.y-1,self.width ,1)];
        [self addSubview:self.linelable];
        self.linelable.backgroundColor=kColorGray225;
   }
    return self;
}
-(void)setModel:(LiveModel *)model{

    if (!model.title) {
        model.title=@"";
    }
    if (!model.startTime) {
        model.startTime=@"";
    }
    if (!model.teacher) {
        model.teacher=@"";
    }
    if (!model.teacherlv) {
        model.teacherlv=@"";
    }
    if (!model.startTime) {
        model.startTime=@"";

    }
        [self.imgView  sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
        self.titel.text = model.title;
        self.teacher.text   = [NSString stringWithFormat:@"讲师：%@",model.teacher];
        self.teacherLV.text  =[NSString stringWithFormat:@"LV%@",model.teacherlv] ;
        self.leartime.text = model.startTime;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(10, 10, self.width/3, self.height-20);
    self.typeL.frame = CGRectMake(self.width/3-38, 40, 45, 20);
    self.titel.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 10,300,20);
    self.teacher.frame = CGRectMake(self.titel.x, 10, 100, 14);
    self.teacher.centerY = 50;
      CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(100, 10000) withStr: self.teacherLV.text];
    self.teacherLV.frame = CGRectMake(CGRectGetMaxX(self.teacher.frame), 10, size.width+10 , size.height);
    self.teacherLV.centerY = self.self.teacher.centerY ;
    self.teacherLV.layer.cornerRadius=self.teacherLV.height/2;
    self.teacherLV.textAlignment = NSTextAlignmentCenter;
    self.imageX.frame =  CGRectMake(self.titel.x, self.height-10-15, 15, 15);
    
    self.leartime.frame = CGRectMake(CGRectGetMaxX(self.imageX.frame)+10 , self.imageX.y, 300, 15);
    self.linelable.frame = CGRectMake(10, CGRectGetMaxY(self.leartime.frame)+10,self.width ,1);
}

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize withStr:(NSString *)str
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end

