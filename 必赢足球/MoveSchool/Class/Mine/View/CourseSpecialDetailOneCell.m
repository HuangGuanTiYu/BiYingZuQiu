
//
//  CourseSpecialDetailOneCell.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/15.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "CourseSpecialDetailOneCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation CourseSpecialDetailOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
         UIColor *titlecolor=RGBCOLOR(64, 64, 64);
         UIColor *deacriblecolor=RGBCOLOR(125, 125, 125);
        UIImageView *imagview=[[UIImageView alloc]initWithFrame:self.frame];
        self.imageview=imagview;
        imagview.backgroundColor=[UIColor whiteColor];
        imagview.userInteractionEnabled = YES;
        [self addSubview:imagview];
        
        
        UILabel *titelLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.height/3, self.width, self.height/3)];
        self.titleLabel=titelLabel;
        titelLabel.font=[UIFont systemFontOfSize:14];
        titelLabel.backgroundColor=[UIColor colorWithWhite:1 alpha:0.5];
        titelLabel.textColor=titlecolor;
        [self addSubview:titelLabel];
        
        UILabel *describeLebel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.height/3*2, self.width, self.height/3)];
        self.describeLebel=describeLebel;
        describeLebel.numberOfLines = 0;
        describeLebel.font=[UIFont systemFontOfSize:13];
        describeLebel.backgroundColor=[UIColor colorWithWhite:1 alpha:0.5];
           describeLebel.textColor=deacriblecolor;
        describeLebel.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        
        [describeLebel addGestureRecognizer:labelTapGestureRecognizer];
        [self addSubview:describeLebel];
        
        UIButton *coloection=[[UIButton alloc]initWithFrame:CGRectMake(self.width-50,  self.imageview.height-50, 30, 30)];
        self.coloection=coloection;
        [coloection setBackgroundImage:[UIImage imageNamed:@"coloection"]  forState:UIControlStateNormal];
        [coloection setBackgroundImage:[UIImage imageNamed:@"coloectioned"]  forState:UIControlStateSelected];

        [coloection addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
        [imagview addSubview:coloection];
        
        
        UIButton *moreInformation=[[UIButton alloc]initWithFrame:CGRectMake(self.width-50,  self.imageview.height-50, 14, 10)];
        moreInformation.backgroundColor =[UIColor whiteColor];

        self.moreInformation=moreInformation;
        [moreInformation setBackgroundImage:[UIImage imageNamed:@"course_intr_open"]  forState:UIControlStateNormal];
        [moreInformation setBackgroundImage:[UIImage imageNamed:@""]  forState:UIControlStateSelected];
        moreInformation.hidden = YES;
        [moreInformation addTarget:self action:@selector(MoreInformation:) forControlEvents:UIControlEventTouchUpInside];
        [self.describeLebel addSubview:moreInformation];
        [self.describeLebel bringSubviewToFront:moreInformation];
        
    }
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageview.frame=CGRectMake(0, 0, self.width, self.width*0.4);
    self.titleLabel.frame=CGRectMake(10, CGRectGetMaxY(self.imageview.frame), self.width, 30);
    CGSize size= [self HeightWithString:self.describeLebel.text fontSize:13 width:self.width-20];
    
    CGSize sizeThere= [self HeightWithString:@"新伙伴欢迎你，培训部新员工培训项目组精心为你准备了这个线上课程包，帮助你更快融入，更快上手，更全面地了解公司，在网易足球学习平台与小伙伴交" fontSize:13 width:self.width-20];

    if (self.selectedX == 0) {
        
        if (size.height > sizeThere.height) {  //大于三行
            self.describeLebel.frame=CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), self.width-20, sizeThere.height);
            self.moreInformation.frame = CGRectMake(self.describeLebel.width-8,  self.describeLebel.height-10, 14, 10);
            self.moreInformation.hidden = NO;
        }else{
            self.describeLebel.frame=CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), self.width-20, size.height);
        }

    }else{
        self.describeLebel.frame=CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), self.width-20, size.height);
        self.moreInformation.frame = CGRectMake(self.describeLebel.width-8,  self.describeLebel.height-10, 14, 10);
        self.moreInformation.hidden = NO;
        self.moreInformation.selected =YES;
    }
    
        self.coloection.frame=CGRectMake(self.width-50,  self.imageview.height-45, 30, 30);
    
}

-(void)setModel:(CourseSpecialDetailCellOneModel *)model{
    
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    
    if (model.classesname!=nil) {
        self.titleLabel.text=model.classesname;
    }else{
    
    self.titleLabel.text=@"";
    }
    
    if (model.descr!=nil) {
        self.describeLebel.text=model.descr;

    }else{
    
    self.describeLebel.text=@"";
    }
    self.coloection.selected = model.isfavorited.intValue;
}

#pragma mark 根据文字计算长度
-(CGSize)HeightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)Width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(Width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

-(void)collection:(UIButton *)btn{
    if (btn.selected==1) {
        btn.selected=!btn.selected;
    }
    [self.delegate collectionDele];
}

-(void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    UILabel *label=(UILabel*)recognizer.view;
    [self.delegate moreInfomationWith:label];

}
-(void)MoreInformation:(UIButton *)btn{
    btn.selected = ! btn.selected;
    UILabel *label;
    [self.delegate moreInfomationWith:label];

}
@end
