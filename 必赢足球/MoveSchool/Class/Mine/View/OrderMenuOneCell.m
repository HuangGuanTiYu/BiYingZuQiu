
//
//  OrderMenuOneCell.m
//  zhitongti
//
//  Created by edianzu on 16/9/6.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "OrderMenuOneCell.h"
#import "MineOrderLableModel.h"
#define  ksize [UIScreen mainScreen].bounds.size
#import "UIView+Extension.h"
#import "UIImageView+CornerRadius.h"
#import "UIImage+Extension.h"

@implementation OrderMenuOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
    
}


-(void)setRecommedArr:(NSArray *)recommedArr{
    _recommedArr=recommedArr;
    
    self.tempArr=[NSMutableArray array];
    self.contentArr=[NSMutableArray array];
    
    
    while (self.subviews.count) {
        
        [self.subviews[0] removeFromSuperview];
    }
    CGFloat orginY = 15;
    CGFloat oneLineBtnWidtnLimit = SCREEN_WIDTH - 70;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = 10;//btn的x间距
    CGFloat btnGapY = 10;
    NSInteger BtnlineNum = 0;
    CGFloat BtnHeight = 30;
    CGFloat minBtnLength =  50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0;//每个btn的起始位置
    Btnx += btnGap;
    
    
    for (int i = 0; i < recommedArr.count; i++) {
        
        MineOrderLableModel *model=recommedArr[i];
        
        NSString *str =model.name;
        CGFloat btnWidth = [self WidthWithString:str fontSize:13 height:1000];
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
        btn.frame = CGRectMake(Btnx, height,btnWidth,BtnHeight);
        [btn setTitle:str forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] CGColor];
        
        [btn setTitleColor:[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1]  forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        UIImageView *normalImage = [[UIImageView alloc] initWithFrame:btn.bounds];
        [normalImage zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
        normalImage.image = [UIImage createImageWithColor:GreenColor];
        [btn setBackgroundImage:normalImage.image forState:UIControlStateSelected];
        
        UIImageView *selectedImage = [[UIImageView alloc] initWithFrame:btn.bounds];
        [selectedImage zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
        selectedImage.image = [UIImage createImageWithColor:[UIColor whiteColor]];
        [btn setBackgroundImage:selectedImage.image forState:UIControlStateNormal];
        
        btn.layer.cornerRadius = 5;
        
        btn.selected = model.selected;
        
        if (btn.selected) {
            btn.layer.borderColor = [UIColor clearColor].CGColor;
        }else
        {
            btn.layer.borderColor = [[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] CGColor];
        }
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = i;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        Btnx = btn.frame.origin.x + btn.frame.size.width + btnGap;
        
        UIButton *addBtn = [[UIButton alloc] init];//每一个动态显示的label
        addBtn.frame = CGRectMake(btn.x+btn.frame.size.width-10,btn.y-10,
                                  20,20 );
        //        [addBtn setImage:[UIImage imageNamed:@"my_deign_sel" ] forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        addBtn.hidden=!model.selected;
        addBtn.tag=i;
        [self.tempArr addObject:addBtn];
        [self bringSubviewToFront:addBtn];
        [self addSubview:btn];
        [self addSubview:addBtn];
        [self bringSubviewToFront:addBtn];
        
    }
}

-(void)btnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        btn.layer.borderColor = [UIColor clearColor].CGColor;
    }else
    {
        btn.layer.borderColor = [[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] CGColor];
    }
    
    for (int i=0; i<self.tempArr.count; i++) {
        UIButton *addBtn = self.tempArr[i];
        
        if (addBtn.tag == btn.tag) {
            addBtn.hidden = !btn.selected;
        }
    }
}

-(void)cancleClick{
    [self removeFromSuperview];
}

-(void)addclick{
    
    for (int i=0; i<self.tempArr.count; i++) {
        UIButton *btn=self.tempArr[i];
        if (!btn.hidden) {
            MineOrderLableModel *model= self.recommedArr[btn.tag];
            
            NSDictionary *dic=@{
                                @"id":model.ID,
                                @"name":model.name,
                                @"type":[NSString stringWithFormat:@"%ld",(long)model.type]
                                };
            [self.contentArr addObject:dic];
        }
    }
    if (self.contentArr.count>0) {
        [self.delegate addArr:self.contentArr];
        
    }
    [self removeFromSuperview];
}

#pragma mark 根据文字计算长度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

