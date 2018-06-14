//
//  HotPointView.m
//  zhitongti
//
//  Created by yuhongtao on 16/6/28.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "HotPointView.h"
#import "HotPointModel.h"
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "RecommedModel.h"
#import "AboutMessageModel.h"
#import "UIButton+WebCache.h"
#import "UIView+Extension.h"
#import "ColorTypeTools.h"

#define  space 10
#define  ScroImgWidth (CGFloat)self.frame.size.height*0.16-30
#define  whoSeeH (CGFloat)self.frame.size.height*0.062
#define  ScroImgWid_each 30
@implementation HotPointView


-(instancetype)initWithFrame:(CGRect)frame{


    if (self=[super initWithFrame:frame]) {
        
        
        self.backgroundColor=[UIColor whiteColor];
 
       
      //设置图片－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－＝＝＝＝＝＝＝－
        self.imgView=[[TapGestureRecognizer alloc]init];
        [self.imgView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        self.imgView.tag=1;
        [self  addSubview:self.imgView];
        
        //添加图片简介lable
       self.imageLable=[[UILabel alloc]init];
        self.imageLable.frame=CGRectMake(space, 0, frame.size.width-2*space, 20);
            //设置标题－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－＝＝＝＝＝＝＝－

          UIFont *imgLfont = [UIFont systemFontOfSize:16];
        self.imageLable.font=imgLfont;
        CGSize imgLsize = CGSizeMake(frame.size.width,20000);

        
        CGSize imgLSize =[self.imageLable.text boundingRectWithSize:imgLsize options:0 attributes:@{NSFontAttributeName :imgLfont} context:nil].size;
        CGFloat imgLH=imgLSize.height;
        UIView* LabelView=[[UIView alloc]init];
        LabelView.frame=CGRectMake(0, self.imgView.frame.size.height-imgLH-2*space, frame.size.width-2*space, imgLH+2*space);
        LabelView.backgroundColor=[UIColor  colorWithRed:0 green:0 blue:0 alpha:0.5];
//        [boardView addSubview: LabelView];
        self.imageLable.textColor=[UIColor whiteColor];
        self.imageLable.backgroundColor=[UIColor colorWithRed:94/255.0f green:94/255.0f blue:94/255.0f alpha:0.7];
        [self.imgView addSubview: self.imageLable];
        
        
        
        //添加时间/分类标签
        
        UILabel * timeLable=[[UILabel alloc]initWithFrame:CGRectMake(space,LabelView.frame.size.height+LabelView.frame.origin.y+space, 120,_imageLable.bounds.size.height)];//150还是要改
        timeLable.font=[UIFont systemFontOfSize:12];
            //设置标题－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－＝＝＝＝＝＝＝－

        timeLable.backgroundColor=[UIColor whiteColor];
        timeLable.textColor=[UIColor grayColor];
        timeLable.textAlignment=NSTextAlignmentLeft;
        self.timeLable=timeLable;
        [self addSubview:timeLable];
        
        
        UILabel* typeLable=[[UILabel alloc]initWithFrame:CGRectMake(timeLable.frame.origin.x+timeLable.frame.size.width,timeLable.frame.origin.y , timeLable.frame.size.width/2,timeLable.frame.size.height)];
        typeLable.font=[UIFont systemFontOfSize:14];
            //设置标题－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－＝＝＝＝＝＝＝－

        typeLable.textAlignment=NSTextAlignmentCenter;
        typeLable.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
        typeLable.textColor=[UIColor grayColor];
        typeLable.layer.cornerRadius=10;
        typeLable.clipsToBounds = YES;
        self.typeLable=typeLable;
        [self addSubview:typeLable];
        
        //添加简介标签
        
        UILabel *lable=[[UILabel  alloc]initWithFrame:CGRectMake(0,0,0,0)];
        [lable setNumberOfLines:0];  //必须是这组值
            //设置标题－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－＝＝＝＝＝＝＝－
        
              lable.textColor=kColorBlack;
        lable.textAlignment=NSTextAlignmentLeft;
        //文本对齐方式
//        lable.backgroundColor=[UIColor redColor];
        self.lable=lable;
        lable.font = kFont13;


        [self addSubview:lable];
      //谁在看
        UIImageView *seeView=[[UIImageView alloc] initWithFrame:CGRectMake(space, lable.frame.size.height+lable.frame.origin.y+space, 2, imgLH)];
        
        seeView.backgroundColor =  GreenColor;
        self.seeView=seeView;
        [self addSubview:seeView];
        
        
        UILabel *whoSeeL=[[UILabel alloc]initWithFrame:CGRectMake(seeView.frame.origin.x+4+space, seeView.frame.origin.y, 4*imgLH, imgLH)];
        
        whoSeeL.text = [ManyLanguageMag  gethotStrWith:@"谁在看"];
        whoSeeL.textColor=kColorBlack;

        whoSeeL.font=kFont14;
        self.whoSeeL=whoSeeL;
        [self addSubview:whoSeeL];
        
     //scrollviewwhosee
        UIScrollView *scroll=[[UIScrollView alloc]init];
        
        scroll.userInteractionEnabled=YES;
        scroll.scrollEnabled=YES;
        //取消指示器
        scroll.showsHorizontalScrollIndicator=NO;
        scroll.showsVerticalScrollIndicator=NO;
        self.scroll=scroll;
        [self addSubview:scroll];
        
        
        //相关推荐
        UIImageView *recommedView=[[UIImageView alloc] init];
        
        recommedView.backgroundColor =  GreenColor;
        self.recommedView=recommedView;
        [self addSubview:recommedView];
      
        UILabel *recommedL=[[UILabel alloc]initWithFrame:CGRectMake(recommedView.frame.origin.x+4+2*space, recommedView.frame.origin.y, 4*imgLH, imgLH)];
        recommedL.text=[ManyLanguageMag  gethotStrWith:@"相关推荐"];
        recommedL.textColor=kColorBlack;

        recommedL.font=kFont14;
        self.recommedL=recommedL;
        [self addSubview:recommedL];
  
    }
    return self;
}
-(void)setModel:(HotPointModel *)model{

    CGFloat RataH=35;
    CGFloat Margin_left=5;
    [self.imgView sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    self.imgView.parameterStr=model.msgkeyid;
    self.imgView.typeStr = model.type;
    self.imageLable.text= [NSString  stringWithFormat:@"   %@",model.title];;
    self.timeLable.text=model.indate;
    NSDictionary *dic=@{
                        NSFontAttributeName:[UIFont systemFontOfSize:13]
   
                        };
   NSString *str=@"成本是种付出，他不可能倍无限的降低。降低的成本不是一味的瘦身，是要从路程入手，改造企业的价值链";
    
    CGSize labelsize=[str boundingRectWithSize:CGSizeMake(self.frame.size.width-Margin_left*2, 100) options:0 attributes:dic context:nil].size;
    UIFont *font=[UIFont systemFontOfSize:13];
    CGRect rect=[str boundingRectWithSize:CGSizeMake(self.frame.size.width-Margin_left*2, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    labelsize=rect.size;

    self.imgView.frame= CGRectMake(0, 0, self.frame.size.width,self.frame.size.width*0.588);
    self.timeLable.frame=CGRectMake(0, CGRectGetMaxY(self.imgView.frame), 100, RataH);
    self.timeLable.textAlignment=NSTextAlignmentLeft;
    self.lable.frame=CGRectMake(10,CGRectGetMaxY(self.timeLable.frame), labelsize.width, labelsize.height);
    self.lable.text=model.content;
    
    self.imageLable.frame=CGRectMake(0, self.imgView.height-35, self.imgView.width, 35);

    self.typeLable.frame=CGRectMake(CGRectGetMaxX(self.timeLable.frame),  CGRectGetMaxY(self.imgView.frame)+10, 40, 20);
    
    NSString *temp=[ColorTypeTools getTypeStringWith:model.type];
    //类型分析
    self.typeLable.text = [ManyLanguageMag getHotTypeStrWith:temp];
    
    self.seeView.frame = CGRectMake(10, self.lable.frame.size.height+self.lable.frame.origin.y, 2, 15);
    self.whoSeeL.frame = CGRectMake(self.seeView.frame.origin.x+5, self.seeView.frame.origin.y, 4*40, whoSeeH);
    self.seeView.centerY = self.whoSeeL.centerY;

    self.scroll.frame=CGRectMake(0, CGRectGetMaxY(self.whoSeeL.frame)+5, self.frame.size.width, (double)self.frame.size.height*0.16-whoSeeH);
    
    self.recommedView.frame=CGRectMake(10, self.scroll.frame.size.height+self.scroll.frame.origin.y, 2, 15);
    self.recommedL.frame=CGRectMake(self.recommedView.frame.origin.x+5,self.recommedView.frame.origin.y, CGRectGetMaxY(self.scroll.frame), whoSeeH);
    self.recommedView.centerY=self.recommedL.centerY;
    self.timeLable.centerY=self.typeLable.centerY;
}


-(void)setRecommendArr:(NSMutableArray *)recommendArr{
  
      self.scroll.contentSize=CGSizeMake((ScroImgWid_each+space)*recommendArr.count, ScroImgWidth);
    for (int i=0; i<recommendArr.count; i++) {
        
        RecommedModel *model = recommendArr[i];
    
        CGFloat W=ScroImgWid_each;
        CGFloat H=ScroImgWid_each;
        CGFloat X=i*(W+space)+space;
        CGFloat Y=2.5;
        
        TapGestureRecognizer *btn=[[TapGestureRecognizer alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        //设置标题－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－＝＝＝＝＝＝＝－
        
        [btn sd_setImageWithURL:[NSURL URLWithString:model.headimgurl]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"hot_user_default"]];
        btn.layer.cornerRadius=W/2;
        btn.layer.masksToBounds=YES;
    
        btn.titleLabel.text=model.userid;

        btn.parameterStr=model.userid;
        
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=2;
        [self.scroll addSubview:btn];
    }
}
-(void)setMessageArr:(NSMutableArray *)messageArr{
  
//推荐的label
    NSInteger count=MIN(messageArr.count, 3);
    
    for (int i=0; i<count; i++) {
        AboutMessageModel *model=messageArr[i];
        //取出每个详细推荐
        TapGestureRecognizer *btn=[[TapGestureRecognizer alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.recommedL.frame)+i*22, self.width, 15)];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=3;
        btn.parameterStr=model.msgkey;
        btn.typeStr=model.type;
        [self addSubview:btn];
        
        UILabel *lable=[[UILabel  alloc]initWithFrame:CGRectMake(0,0,0,0)];
        [lable setNumberOfLines:0];  //必须是这组值
        UIFont *font = [UIFont systemFontOfSize:13];
        CGSize size = CGSizeMake(300,100);
        NSString *str=model.title;
        CGSize  labelsize=[str boundingRectWithSize:size options:0 attributes:@{NSFontAttributeName :font} context:nil].size;
        if (labelsize.width>(self.width-90)) {
            labelsize.width = self.width-90;
        }
        
        
        lable.frame = CGRectMake(10,0,labelsize.width,30);
        
        if (IS_IPHONE_4_OR_LESS) {
            lable.frame = CGRectMake(10,-25,labelsize.width,30);

        }
        lable.textColor=[UIColor grayColor];
        lable.textAlignment=NSTextAlignmentLeft;
        
        //文本对齐方式
        lable.text= model.title;
        lable.font = font;
        [btn addSubview:lable];
        

        UIButton *recommendBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable.frame)+10,0,40,20)];
        if (IS_IPHONE_4_OR_LESS) {
          recommendBtn.frame=CGRectMake(CGRectGetMaxX(lable.frame)+10,-25,40,20);
        }
        NSString *temp=[ColorTypeTools getTypeStringWith:model.type];
        [recommendBtn  setTitle:temp forState:UIControlStateNormal];
        lable.centerY=recommendBtn.centerY;
        recommendBtn.layer.cornerRadius=10;
        [recommendBtn setBackgroundColor:kColorGray240];
        [recommendBtn  setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        recommendBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        recommendBtn.userInteractionEnabled=NO;
        [btn addSubview:recommendBtn];
    }
}
//点击大图片 传过去massageKey tag:1  // 传过去userid   tag:2 //
-(void)click:(TapGestureRecognizer *)btn{
    [self.delegate iconClickAndRecommedListDelegate:btn];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.timeLable.x=self.timeLable.x+10;
    if (IS_IPHONE_4_OR_LESS) {
        
        self.boardView.frame=CGRectMake(0, 0, self.width,self.height+25);
        self.imgView.y =self.imgView.y -25;
        self.timeLable.y=self.timeLable.y-25;
        self.lable.y=self.lable.y-25;
        self.typeLable.y= self.typeLable.y-25;
        self.seeView.y= self.seeView.y-25;
        self.whoSeeL.y=self.whoSeeL.y-25;
        self.scroll.y=self.scroll.y-25;
        self.recommedView.y=self.recommedView.y-25;
        self.recommedL.y= self.recommedL.y-25;
    }
}

@end
