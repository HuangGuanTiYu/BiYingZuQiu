
//
//  CourseView.m
//  MyStudy
//
//  Created by yuhongtao on 16/6/30.
//  Copyright © 2016年 com.ztt. All rights reserved.
//  一个大问题

#import "CourseView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "ColorTypeTools.h"

#define space 10

@implementation CourseView


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UIColor *color=RGBCOLOR(100, 100, 100);
        UIColor *titlecolor=RGBCOLOR(64, 64, 64);
        UIColor *deacriblecolor=RGBCOLOR(170, 170, 170);
        
        UIImageView  *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width/3, self.frame.size.width/4)];
        imgView.image = [UIImage imageNamed:@"icon"];
        imgView.backgroundColor=[UIColor grayColor];
        imgView.clipsToBounds = YES;
        self.imgView = imgView;
        [self addSubview:imgView];
        
        
        UILabel *typeL=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/3-50-10, 60, 50, 20)];
        typeL.text = @"课程";
        typeL.layer.masksToBounds = YES;
        typeL.layer.cornerRadius = 10;
        typeL.backgroundColor =[UIColor colorWithWhite:0.1 alpha:0.7];
        typeL.textColor = [UIColor whiteColor];
        typeL.font = [UIFont systemFontOfSize:12];
        typeL.textAlignment = NSTextAlignmentCenter;
        self.typeL = typeL;
        [imgView addSubview:typeL];
        
        
        //z状态学习
        UILabel *studyStatusL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
        studyStatusL.hidden = YES;
        studyStatusL.text=@"学习中";
        studyStatusL.backgroundColor=RGBACOLOR(50, 50, 50, 1);
        studyStatusL.font=[UIFont systemFontOfSize:10];
        studyStatusL.textAlignment=NSTextAlignmentCenter;
        studyStatusL.textColor=kColorGray240;
        self.studyStatusL=studyStatusL;
        [imgView addSubview:studyStatusL];
        
        //标题
        UILabel *titel=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, 5, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5)];
        
        titel.text=@"三十分钟轻松制作HTML5交互动画";
        self.titel=titel;
        titel.font=[UIFont systemFontOfSize:13];
        titel.textColor=color;
        [self addSubview:titel];
        //讲师
        UILabel *teacher=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, titel.frame.size.height, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5)];
        
        titel.font=[UIFont systemFontOfSize:13];
        teacher.textColor=deacriblecolor;
        
        
        
        teacher.text=@"";
        teacher.font=[UIFont systemFontOfSize:13];
        self.teacher=teacher;
        [self addSubview:teacher];
        //讲师等级
        UILabel *detail=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, teacher.frame.size.height+teacher.frame.origin.y, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5*2)];
        detail.numberOfLines=0;
        
        detail.text=@"LV1";
        detail.layer.cornerRadius=3;
        detail.layer.masksToBounds=YES;
        detail.layer.borderWidth=0.5;
        detail.layer.borderColor= kColorGray225.CGColor;
        detail.backgroundColor=RGBACOLOR(242, 202, 14, 1);
        
        detail.font=[UIFont systemFontOfSize:9];
        detail.textColor=[UIColor blackColor];
        self.detail=detail;
        [self addSubview:detail];
        //最后一行
        UIView *lastViewBG=[[UIView alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, detail.frame.size.height+detail.frame.origin.y, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5)];
        self.lastViewBG=lastViewBG;
        [self addSubview:lastViewBG];
        
        //参与人数
        UIImageView  *seeImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.height/5, imgView.frame.size.height/5)];
        
        seeImage.image=[UIImage imageNamed:@"sudy_map_time"];
        
        self.seeImage=seeImage;
        [lastViewBG addSubview:seeImage];
        
        UILabel *seeNumbL=[[UILabel alloc]initWithFrame:CGRectMake(seeImage.frame.size.width,0, seeImage.frame.size.width, imgView.frame.size.height/5)];
        
        seeNumbL.font=[UIFont systemFontOfSize:9];
        seeNumbL.text=@"123";
        seeNumbL.textColor=titlecolor;
        self.seeNumbL=seeNumbL;
        [lastViewBG addSubview:seeNumbL];
        
        //评论数
        UIImageView  *commentImage=[[UIImageView alloc]initWithFrame:CGRectMake(seeNumbL.frame.size.width+seeNumbL.frame.origin.x, 0, imgView.frame.size.height/5, imgView.frame.size.height/5)];
        
        commentImage.image=[UIImage imageNamed:@"study_map_people"];
        
        self.commentImage=commentImage;
        [lastViewBG addSubview:commentImage];
        
        UILabel *commentNumbL=[[UILabel alloc]initWithFrame:CGRectMake(commentImage.frame.size.width+commentImage.frame.origin.x, 0, commentImage.frame.size.width, imgView.frame.size.height/5)];
        
        commentNumbL.font=[UIFont systemFontOfSize:9];
        commentNumbL.text=@"123";
        commentNumbL.textColor=titlecolor;
        self.commentNumbL=commentNumbL;
        [lastViewBG addSubview:commentNumbL];
        
        
        //时长
        UIImageView  *timeImage=[[UIImageView alloc]initWithFrame:CGRectMake(commentNumbL.frame.size.width+commentNumbL.frame.origin.x, 0, imgView.frame.size.height/5, imgView.frame.size.height/5)];
        
        timeImage.image=[UIImage imageNamed:@"study_map_words"];
        self.timeImage=timeImage;
        [lastViewBG addSubview:timeImage];
        
        UILabel *timeNumbL=[[UILabel alloc]initWithFrame:CGRectMake(timeImage.frame.size.width+timeImage.frame.origin.x, 0, commentImage.frame.size.width*4, imgView.frame.size.height/5)];
        timeNumbL.textColor=titlecolor;
        timeNumbL.font=[UIFont systemFontOfSize:9];
        timeNumbL.text=@"00:30:45";
        self.timeNumbL=timeNumbL;
        [lastViewBG addSubview:timeNumbL];
        
        
        
        
        self.linelable=[[UILabel alloc]init];
        [self addSubview:self.linelable];
        self.linelable.backgroundColor=RGBCOLOR(225, 225, 225);
    }
    return self;
}

-(void)setModel:(CourseDetailModel *)model{

    if (!model.btnstatus) {
        model.btnstatus=@"";
    }
    if (!model.title) {
        model.title=@"";
    }
    if (!model.teacher) {
        model.teacher=@"";
    }
    if (!model.teacherlv) {
        model.teacherlv=@"";
    }
    if (!model.showDuration) {
        model.showDuration=@"";
    }

    NSString * IMageUrl = model.imgurl?model.imgurl:model.picurl;
    NSString * learnNumber = model.learnNum?model.learnNum:model.learnnum;
    NSString * disCuessNumber = model.discussNum?model.discussNum:model.discussnum;
    if (M_ISSTRNULL(model.learnNum)) {
      learnNumber = model.learnnum?model.learnnum:model.learnNum;
        
    }
    
    if (M_ISSTRNULL(model.discussNum)) {
        disCuessNumber = model.discussnum?model.discussnum:model.discussNum;
        
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:IMageUrl] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    self.titel.text=model.title;
    self.teacher.text=[NSString stringWithFormat:@"讲师：%@",model.teacher];
    if ([model.teacherlv isEqualToString:@"0"]) {
        model.teacherlv=@"1";
    }
    
    self.detail.text=[NSString stringWithFormat:@"LV%@",model.teacherlv];
    self.seeNumbL.text= model.showDuration;    //时长
    self.commentNumbL.text=learnNumber;//discussnum   //人数
    self.timeNumbL.text=disCuessNumber;  //评论数
    self.typeL.hidden = self.hiddenCourse;

    
    self.studyStatusL.text=[ColorTypeTools getStudyStatusWith:model.btnstatus];
    if([self.studyStatusL.text isEqualToString:@"过期"]){
        self.studyStatusL.hidden=YES;
    }
    
    
    self.studyStatusL.hidden = !self.showState;
}

-(void)layoutSubviews{
    
    self.imgView.frame=CGRectMake(10, 10, self.width/3,self.width/5);
    self.typeL.frame = CGRectMake(self.width/3-38, 40, 45, 20);

    self.studyStatusL.frame=CGRectMake(0, 0, self.width/8,15);
    self.titel.frame=CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 10, self.width-self.imgView.width-20, 25);
    
    
    
    CGSize teachersize = [self sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(100, 10000) withStr: self.teacher.text];
    self.teacher.frame=CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.titel.frame), teachersize.width, (self.height-20)/3);
    
    
    //LV1
    CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(100, 10000) withStr: self.detail.text];
    self.detail.frame=CGRectMake(CGRectGetMaxX(self.teacher.frame)+10, CGRectGetMaxY(self.titel.frame)+2,size.width+10, size.height);
    self.detail.layer.cornerRadius=size.height/2;
    self.detail.textAlignment=NSTextAlignmentCenter;
    self.detail.centerY=self.teacher.centerY;
    self.lastViewBG.frame=CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, self.detail.frame.size.height+self.detail.frame.origin.y+7, self.frame.size.width-self.imgView.frame.size.width-space,self. self.imgView.frame.size.height/5);
    
    
    //时长
    CGFloat  offset = 4.5;
    self.seeImage.frame=CGRectMake(0, offset, 11,11);
    self.seeNumbL.frame=CGRectMake(CGRectGetMaxX(self.seeImage.frame)+5, offset, self.lastViewBG.width/3-self.imgView.height/5, self.imgView.frame.size.height/5);
    //人数
    self.commentImage.frame=CGRectMake(CGRectGetMaxX(self.seeNumbL.frame)+5, offset+1, 13,10);
    self.commentNumbL.frame=CGRectMake(CGRectGetMaxX(self.commentImage.frame)+5, offset+1, self.lastViewBG.width/3-self.imgView.height/5, self.imgView.height/5);
    
    //评论数
    self.timeImage.frame = CGRectMake(CGRectGetMaxX(self.commentNumbL.frame)-15, offset+2,13, 10);
    self.timeNumbL.frame = CGRectMake(CGRectGetMaxX(self.timeImage.frame)+5, offset+2, self.lastViewBG.width/3-self.imgView.height/5, self.imgView.frame.size.height/5);
    
    self.commentNumbL.centerY = self.commentImage.centerY = self.seeImage.centerY = self.seeNumbL.centerY = self.timeImage.centerY = self.timeNumbL.centerY;
    
    self.linelable.frame=CGRectMake(10, self.height-1, SCREEN_WIDTH, 1);
    
    
}
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize withStr:(NSString *)str
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
