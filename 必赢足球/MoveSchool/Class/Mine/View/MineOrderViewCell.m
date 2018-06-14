//
//  MineOrderViewCell.m
//  我的定制
//
//  Created by yuhongtao on 16/7/9.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import "MineOrderViewCell.h"
//#import "SCButton.h"
#import "MineOrderLableModel.h"
#import "UIView+Extension.h"

#define  kSize [UIScreen mainScreen].bounds.size

@implementation MineOrderViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.btnArr=[NSMutableArray array];
        self.addBtnArr=[NSMutableArray array];
        self.addBtnArrBG=[NSMutableArray array];

      
    }
    return self;

}

-(void)setArry:(NSArray *)arry{

    if (self.isEnterprise==1) {
        
        while (self.subviews.count) {
            
            [self.subviews[0] removeFromSuperview];
        }

        self.btnArr=[NSMutableArray array];
        
        CGFloat orginY = 10;
        CGFloat oneLineBtnWidtnLimit = kSize.width-20;//每行btn占的最长长度，超出则换行
        CGFloat btnGap = 10;//btn的x间距
        CGFloat btnGapY = 10;
        NSInteger BtnlineNum = 0;
        CGFloat BtnHeight = 30;
        CGFloat minBtnLength =  50;//每个btn的最小长度
        CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
        CGFloat Btnx = 0;//每个btn的起始位置
        Btnx += btnGap;
        for (int i = 0; i < arry.count; i++) {
            CGFloat btnWidth ;
            NSString *str;
            MineOrderLableModel *model = arry[i];
            str=model.name;
            btnWidth = [self WidthWithString:str fontSize:13 height:1000];
            
            btnWidth += 20;//让文字两端留出间距
            if(btnWidth<minBtnLength)
                btnWidth = minBtnLength;
            if(btnWidth>maxBtnLength)
                btnWidth = maxBtnLength;
            if(Btnx + btnWidth > oneLineBtnWidtnLimit)
            {
                BtnlineNum ++;//长度超出换到下一行
                Btnx = btnGap;
            }
            
            UIButton *btn = [[UIButton alloc] init];//每一个动态显示的label
            CGFloat height =  (BtnlineNum*(BtnHeight+btnGapY))+orginY;
            btn.frame = CGRectMake(Btnx, height,
                                   btnWidth,BtnHeight );
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] CGColor];

            btn.layer.cornerRadius=5;
             [btn setTitle:str forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] forState:UIControlStateNormal];

            Btnx = btn.frame.origin.x + btn.frame.size.width + btnGap;
           btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [self addSubview:btn];
            
            [self.btnArr addObject:btn];
            
        }
        
    }else if(self.isEnterprise==2){
   
    while (self.subviews.count) {
    
        [self.subviews[0] removeFromSuperview];
    }


    self.addBtnArr =[NSMutableArray array];
    self.btnArr=[NSMutableArray array];
  
    CGFloat orginY = 10;
    CGFloat oneLineBtnWidtnLimit = kSize.width-20;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = 10;//btn的x间距
    CGFloat btnGapY = 10;
    NSInteger BtnlineNum = 0;
    CGFloat BtnHeight = 30;
    CGFloat minBtnLength =  50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0;//每个btn的起始位置
    Btnx += btnGap;
    for (int i = 0; i < arry.count+1; i++) {
        CGFloat btnWidth ;
        NSString *str;
        
        if(i==arry.count){
            btnWidth=20;
        }else{
           MineOrderLableModel *model =arry[i];
            str=model.name;
            btnWidth = [self WidthWithString:str fontSize:13 height:1000];
        }
        
       
        btnWidth += 20;//让文字两端留出间距
        if(btnWidth<minBtnLength)
            btnWidth = minBtnLength;
        if(btnWidth>maxBtnLength)
            btnWidth = maxBtnLength;
        if(Btnx + btnWidth > oneLineBtnWidtnLimit)
        {
            BtnlineNum ++;//长度超出换到下一行
            Btnx = btnGap;
        }
        
        
        UIButton *btn = [[UIButton alloc] init];//每一个动态显示的label
        CGFloat height =  (BtnlineNum*(BtnHeight+btnGapY))+orginY;
        btn.frame = CGRectMake(Btnx, height,
                               btnWidth,BtnHeight );
        btn.layer.borderWidth = 1;
         [btn setTitle:str forState:UIControlStateNormal];
        btn.layer.borderColor = [[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] CGColor];
        btn.layer.cornerRadius=5;
        [btn setTitleColor:[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        Btnx = btn.frame.origin.x + btn.frame.size.width + btnGap;
        //将btn防盗数组里面
        
        if(i == arry.count){
            [btn setImage:[UIImage imageNamed:@"my_design_add"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }else{
            UIButton *temptry = [[UIButton alloc] init];//每一个动态显示的label
            temptry.frame = CGRectMake(btn.frame.size.width-16, -5,
                                      22,22);
            [temptry setBackgroundColor:[UIColor whiteColor]];
            [temptry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           
            UIButton *addBtn = [[UIButton alloc] init];//每一个动态显示的label
            addBtn.frame = CGRectMake(btn.x+btn.frame.size.width-10,btn.y-10,
                                      20,20 );
            [addBtn setImage:[UIImage imageNamed:@"my_design_close" ] forState:UIControlStateNormal];
            addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            addBtn.tag=100+i;
            addBtn.hidden=YES;
            [self.addBtnArr addObject:addBtn];
            [self addSubview:btn];
            [self addSubview:addBtn];
        }
        [self.btnArr addObject:btn];
    }
    }
}
#pragma mark 根据文字计算长度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}
-(void)btnClick:(UIButton *)btn{
    [self.delegate passBtnClick:btn tableviewcell:self];
}

-(void)setIsHide:(BOOL)isHide{
    for (int i=0; i<self.addBtnArr.count; i++) {
        
        UIButton *btn=self.addBtnArr[i];
        btn.hidden=isHide;

    }
    for (int i=0; i<self.addBtnArrBG.count; i++) {
        
        UIButton *btn=self.addBtnArrBG[i];
        btn.hidden=isHide;
        
    }
    
}

-(void)setAttriName:(NSString *)attriName{

    self.attriName=attriName;
    
}
//======================有问题========================
-(void)add:(UIButton *)btn{
    
    [self.delegate add:self.tag];
}



@end
