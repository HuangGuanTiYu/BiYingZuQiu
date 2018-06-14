//
//  SalonTableViewCell.m
//  zhitongti
//
//  Created by edz on 2016/11/28.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "SalonTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#define space  10

@implementation SalonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UIColor *color=RGBCOLOR(100, 100, 100);
        UIColor *deacriblecolor=RGBCOLOR(170, 170, 170);
        
        UIImageView  *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width/3, self.frame.size.width/4)];
        imgView.image=[UIImage imageNamed:@"icon"];
        imgView.backgroundColor=[UIColor grayColor];
        imgView.clipsToBounds = YES;
        self.imgView=imgView;
        [self addSubview:imgView];
        //z状态学习
        UILabel *studyStatusL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
        studyStatusL.text=@"学习中";
        studyStatusL.font=[UIFont systemFontOfSize:14];
        studyStatusL.textAlignment=NSTextAlignmentCenter;
        studyStatusL.textColor=[UIColor redColor];
        self.studyStatusL=studyStatusL;
        [imgView addSubview:studyStatusL];
        
        
        
        
        UILabel *typeL=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/3-50-10, 60, 50, 20)];
        typeL.text = @"沙龙";
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
        titel.font=[UIFont systemFontOfSize:14];
        titel.textColor=color;
        
        [self addSubview:titel];
        //举办时间
        
        UILabel *startTimme=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, titel.frame.size.height, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5)];
    
        startTimme.textColor=deacriblecolor;

        startTimme.text=@"举办时间：";
        startTimme.font=[UIFont systemFontOfSize:13];
        self.startTimme=startTimme;
        [self addSubview:startTimme];
       
        
        //举办时间详情
        UILabel *startTimmeD=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, startTimme.frame.size.height+startTimme.frame.origin.y, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5*2)];
        startTimmeD.numberOfLines=0;
        startTimmeD.text=@"6月12日10:30";
        
        startTimmeD.font=[UIFont systemFontOfSize:13];
        startTimmeD.textColor=deacriblecolor;
        self.startTimmeD=startTimmeD;
        [self addSubview:startTimmeD];
        
        //举办时间详情
        UILabel *learnnum=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, startTimme.frame.size.height+startTimme.frame.origin.y, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5*2)];
        learnnum.numberOfLines=0;
        learnnum.text=@"已报名6人";
        learnnum.font=[UIFont systemFontOfSize:12];
        learnnum.textColor=[UIColor blackColor];
        self.learnnum=learnnum;
        [self addSubview:learnnum];
        
        
        //实例化一个进度条，有两种样式，一种是UIProgressViewStyleBar一种是UIProgressViewStyleDefault，几乎无区别
        UIProgressView *pro1=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        //设置的高度对进度条的高度没影响，整个高度=进度条的高度，进度条也是个圆角矩形
        //但slider滑动控件：设置的高度对slider也没影响，但整个高度=设置的高度，可以设置背景来检验
        pro1.frame=CGRectMake(30, 100, 200, 50);
        //设置进度条颜色
        pro1.trackTintColor=deacriblecolor;
        //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
        pro1.progress=0.7;
        //设置进度条上进度的颜色
        pro1.progressTintColor=[UIColor blackColor];

        [pro1 setProgress:0.7 animated:YES];
        
        self.Progress = pro1;
        [self addSubview:pro1];
        
        
        //剩余人数
        UILabel *limitPepole=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.size.width+space, startTimme.frame.size.height+startTimme.frame.origin.y, self.frame.size.width-imgView.frame.size.width-space, imgView.frame.size.height/5*2)];
        limitPepole.numberOfLines=0;
        limitPepole.text=@"剩余34人";
        limitPepole.font=[UIFont systemFontOfSize:12];
        limitPepole.textColor=deacriblecolor;
        self.limitPepole = limitPepole;
        [self addSubview:limitPepole];
        self.linelable=[[UILabel alloc]init];
        [self addSubview:self.linelable];
        self.linelable.backgroundColor=RGBCOLOR(225, 225, 225);
    }
    return self;
}

-(void)setModel:(SalonModel *)model{
    UIColor *deacriblecolor=RGBCOLOR(170, 170, 170);
  
    if (!model.title) {
        model.title=@"";
    }
    if (!model.starttime) {
        model.starttime=@"";
    }
    if (!model.title) {
        model.title=@"";
    }
    if (!model.limitPepole) {
        model.limitPepole=@"";
    }
    if (!model.learnNum) {
        model.learnNum=@"0";
    }
    
    
    //状态：-1未报名，  0 已报名， 1 已签到， 2 已报名签到',

    if (!model.userstatus) {
        model.userstatus=@"";
    }else if ([model.userstatus isEqualToString:@"0"]) {
        model.userstatus=@"已报名";
        self.studyStatusL.textColor =  deacriblecolor;
    }else if ([model.userstatus isEqualToString:@"-1"]) {
        model.userstatus=@"报名";
    }else if ([model.userstatus isEqualToString:@"1"]) {
        model.userstatus=@"已签到";
        self.studyStatusL.textColor =  deacriblecolor;
    }else{//2
        model.userstatus=@"已报名签到";
        self.studyStatusL.textColor =  deacriblecolor;
    }
    if (!model.imgurl) {
        model.imgurl=@"";
    }
    
    self.titel.text = model.title;
       self.startTimmeD.text =model.starttime;
        self.learnnum.text =[NSString stringWithFormat:@"已报名%@人", model.learnNum];
        self.limitPepole.text = [NSString stringWithFormat:@"剩余%d人",(model.limitPepole.intValue-model.learnNum.intValue)];
        self.studyStatusL.text  = model.userstatus;
         [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    
    //数据有问题，无奈写个100；
    self.Progress.progress =  model.learnNum.doubleValue/100;
}

-(void)layoutSubviews{
    [super  layoutSubviews];
    self.imgView.frame = CGRectMake(10, 10, self.width/3, self.height-20);
    self.typeL.frame = CGRectMake(self.width/3-38, 40, 45, 20);

    self.titel.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 10,120,20);
    self.studyStatusL.frame = CGRectMake(self.width-50-10 , 3, 60, 14);
    self.startTimme.frame = CGRectMake(self.titel.x, CGRectGetMaxY(self.titel.frame)+10, 80, 15);
    self.startTimme.centerY = self.imgView.centerY;
    self.startTimmeD.frame = CGRectMake(self.startTimme.x+self.startTimme.width, self.startTimme.y, 300, self.startTimme.height);
    self.startTimmeD.centerY = self.startTimme.centerY ;
    self.Progress.frame = CGRectMake(self.titel.x, CGRectGetMaxY(self.startTimme.frame)+4,self.startTimme.width+self.startTimmeD.width+25 , 1);
    CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(100, 10000) withStr:@"已报名12人"];
    self.learnnum.frame = CGRectMake(self.titel.x, self.height-10-15,size.width +10,size.height);
    CGSize sizeX = [self sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(100, 10000) withStr:@"剩余12人"];
    self.limitPepole.frame = CGRectMake(self.learnnum.x+self.learnnum.width+30, self.height-10-15,sizeX.width+10 ,sizeX.height);
    self.linelable.frame = CGRectMake(10,CGRectGetMaxY(self.limitPepole.frame)+9,self.width ,1);

}
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize withStr:(NSString *)str
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end

