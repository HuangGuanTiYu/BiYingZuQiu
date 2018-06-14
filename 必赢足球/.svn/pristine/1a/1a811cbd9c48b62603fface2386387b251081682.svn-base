
//
//  MainSecCell.m
//  Main
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainSecCell.h"

@implementation MainSecCell

#define  kWight [UIScreen mainScreen].bounds.size.width
#define  kHeight     self.frame.size.height


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWight,kHeight)];
    self.view = view;
    [self addSubview:view];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWight/2-2, 8, 1, kHeight-15)];
    //分割线的图片
    imgView.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [view addSubview:imgView];
   
    
    /* 积分  */
    UIButton *ScoreLabel=[[UIButton alloc]initWithFrame:CGRectMake(0, 11, kWight/2, 12)];
    NSString *ScoreLabelName=[ManyLanguageMag getMineMenuStrWith:@"积分"];
    [ScoreLabel setTitle:ScoreLabelName forState:UIControlStateNormal];
    [ScoreLabel setTitleColor:kColorGray154 forState:UIControlStateNormal];
    ScoreLabel.titleLabel.font=[UIFont  systemFontOfSize:12];
    ScoreLabel.titleLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:ScoreLabel];
    
    
    UIButton *scoreBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, kHeight/2, kWight/2, 14)];

    //数据积分
    scoreBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [scoreBtn  setTitle:@"0" forState:UIControlStateNormal];
    scoreBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [scoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scoreBtn.titleEdgeInsets = UIEdgeInsetsMake(-kHeight/4, 0, 0, 0);//上左下右
    self.scoreBtn=scoreBtn;
    [view addSubview:scoreBtn];
    
    UIButton *score = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.width * 0.5, view.height)];
    score.tag = 1;
    [score addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:score];
    
    /* 证书  */
    UIButton *cardLabel=[[UIButton alloc]initWithFrame:CGRectMake(kWight/2, 11, kWight/2, 12)];

        cardLabel.titleLabel.textAlignment=NSTextAlignmentCenter;
    NSString *cardLabelName = [ManyLanguageMag getMineMenuStrWith:@"证书"];;
    [cardLabel setTitle:cardLabelName forState:UIControlStateNormal];
    [cardLabel setTitleColor:kColorGray154 forState:UIControlStateNormal];
    cardLabel.titleLabel.text=cardLabelName;
    cardLabel.titleLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:cardLabel];
    
    
    UIButton *cardBtn=[[UIButton alloc]initWithFrame:CGRectMake(kWight/2, kHeight/2, kWight/2, 14)];
    [cardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cardBtn  setTitle:@"0" forState:UIControlStateNormal];
    cardBtn.titleEdgeInsets = UIEdgeInsetsMake(-kHeight/4, 0, 0, 0);//上左下右
    cardBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    self.cardBtn=cardBtn;
    [view addSubview:cardBtn];
    
    UIButton *card = [[UIButton alloc] initWithFrame:CGRectMake(view.width * 0.5, 0, view.width * 0.5, view.height)];
    card.tag = 2;
    [card addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:card];
   
    return self;
}
-(void)layoutSubviews{
    [super  layoutSubviews];
    self.view.frame=CGRectMake(0, 0, kWight,kHeight);
    self.scoreBtn.frame=CGRectMake(0, kHeight-11-14, kWight/2, kHeight/2);
    self.cardBtn.frame=CGRectMake(kWight/2, kHeight-11-14, kWight/2, kHeight/2);
}
-(void)click:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(scoreBtnClick:)]) {
        [self.delegate scoreBtnClick:btn];
    }
}

-(void)setModel:(MainSecCellModel *)model{
    
   [self.cardBtn setTitle:[NSString stringWithFormat:@"%ld",(long)model.cert] forState:UIControlStateNormal];
   [self.scoreBtn setTitle:[NSString stringWithFormat:@"%ld",(long)model.coin] forState:UIControlStateNormal];
}

@end
