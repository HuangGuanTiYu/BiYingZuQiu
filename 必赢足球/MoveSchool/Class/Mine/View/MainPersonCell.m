//
//  MainPersonCell.m
//  Main
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainPersonCell.h"
#import "UIButton+WebCache.h"
#import "AFNetWW.h"
#import "UIView+Extension.h"
#import "ManyLanguageMag.h"
#import "UIImageView+WebCache.h"

#define kSize [[UIScreen mainScreen]bounds].size

@implementation MainPersonCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景
        UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSize.width, 160)];
        UIImage *img = [UIImage imageNamed:@"mine_setting_bg"];
        view.image = img;
        view.userInteractionEnabled = YES;
        self.view = view;
        [self addSubview:view];
        
        UIImageView *ve = [[UIImageView alloc]initWithFrame:CGRectMake(25, self.height-17-52, 52, 52)];
        ve.backgroundColor = RGBACOLOR(0, 0, 0, 0.08);
        ve.layer.masksToBounds = YES;
        ve.layer.cornerRadius = ve.width/2;
        
        self.ve = ve;
        [self.view addSubview:ve];
        
        
        UIButton *icon=[[UIButton alloc]initWithFrame:CGRectMake(30,view.frame.size.height/3,65,65)];
        icon.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
        //设置为圆形
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius=icon.frame.size.width/2;//    按钮宽的一半;变成圆形的
        icon.tag=1;
    
        [icon sd_setBackgroundImageWithURL:[NSURL URLWithString:[UserInfoTool getUserInfo].headimgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"hot_user_default"]];
        
        [icon addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.icon=icon;
        [view addSubview:icon];
        
        //根据字体设置长度
        UIButton *nameL=[[UIButton  alloc]initWithFrame:CGRectMake(0,0,100,50)];
        nameL.frame = CGRectMake(CGRectGetMaxX(icon.frame)+30,view.frame.size.height/2-10, view.frame.size.width/4, view.frame.size.height/8);
        nameL.titleLabel.textColor=[UIColor whiteColor];
        nameL.titleLabel.textAlignment=NSTextAlignmentLeft;  //无效
        
        nameL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nameL.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);//两句左对齐
        //文本对齐方式
        NSString *temp=[ManyLanguageMag  getMineMenuStrWith:@"登录"];
        [nameL setTitle:temp forState:UIControlStateNormal];
        nameL.titleLabel.font =[UIFont systemFontOfSize:15];
        self.nameL=nameL;
        [nameL addTarget:self action:@selector(nameClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:nameL];
        
        
        UILabel *IDL = [[UILabel  alloc]initWithFrame:CGRectMake(nameL.frame.origin.x,nameL.frame.size.height+nameL.frame.origin.y+10,nameL.frame.size.width,nameL.frame.size.height)];
    
        IDL.textColor = [UIColor whiteColor];
        IDL.textAlignment = NSTextAlignmentLeft;
        //文本对齐方式
        IDL.text = @"";
        IDL.font = [UIFont systemFontOfSize:11];
        self.IDL = IDL;
        [view addSubview:IDL];
        
        UILabel *vip=[[UILabel  alloc]initWithFrame:CGRectMake(0,0,0,0)];
        //必须是这组值,这个frame是初设的，没关系，后面还会重新设置其size。
        [vip setNumberOfLines:0];  //必须是这组值
        UIFont *font1 =[UIFont systemFontOfSize:9];
        //计算字体的高度
        CGSize FontHeight=[@"LV1"  boundingRectWithSize:CGSizeMake(200, 3000) options:0 attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:9]} context:nil].size;
        
        CGFloat iconBottomY=icon.frame.size.height+icon.frame.origin.y;
        CGFloat iconBottomX=icon.frame.size.width/2+icon.frame.origin.x;
        vip.frame = CGRectMake(iconBottomX,iconBottomY-20,FontHeight.width,FontHeight.height);
        vip.textColor=kColorBlack;
        vip.textAlignment=NSTextAlignmentCenter;
        //文本对齐方式  235 205 52
        vip.backgroundColor=[UIColor colorWithRed:235/255.0f green:205/255.0f blue:52/255.0f alpha:1];
        vip.layer.masksToBounds = YES;
        vip.layer.cornerRadius=vip.frame.size.height/2;//
        vip.text=@"LV1";
        vip.font = font1;
        self.vip=vip;
        [view addSubview:vip];
        
        //打卡
        
        UIButton *doCard=[[UIButton  alloc]initWithFrame:CGRectMake(view.frame.size.width-view.frame.size.width/6+5,iconBottomY-view.frame.size.height/4,view.frame.size.width/5+5,FontHeight.height+10)];
        [doCard  setTitleColor:GreenColor forState:UIControlStateNormal];
        doCard.backgroundColor=[UIColor whiteColor];
        doCard.titleLabel.textAlignment=NSTextAlignmentLeft;
        doCard.layer.masksToBounds = YES;
        doCard.layer.cornerRadius=doCard.frame.size.height/2;
        doCard.titleLabel.font=[UIFont systemFontOfSize:13];
         NSString *doCardName=[ManyLanguageMag  getMineMenuStrWith:@"打卡"];
        [doCard setTitle:doCardName forState:UIControlStateNormal];
        self.doCard=doCard;
        [doCard setTitleColor:kColorGray154 forState:UIControlStateDisabled];
        
        NSString *cardA=[ManyLanguageMag getMineMenuStrWith:@"已打卡"];
        [doCard setTitle:cardA forState:UIControlStateDisabled];
        doCard.titleLabel.textAlignment=NSTextAlignmentCenter;
        doCard.tag=3;
        [doCard addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        doCard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        doCard.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [view addSubview:doCard];
        
        
        //加号//必须是图片
        UIButton *addBtn=[[UIButton  alloc]initWithFrame:CGRectMake(view.frame.size.width-view.frame.size.width/6,30,view.frame.size.width/5,FontHeight.height+10)];
        [addBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.layer.masksToBounds = YES;
        addBtn.layer.cornerRadius=doCard.frame.size.height/2;
        addBtn.titleLabel.font=[UIFont systemFontOfSize:40];
        addBtn.tag=2;
        [addBtn setImage:[UIImage imageNamed:@"common_add_menu"] forState:UIControlStateNormal];
        self.addBtn=addBtn;
        addBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        self.doCard=doCard;
        [addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];        
        [view addSubview:addBtn];
        
        _cardBtnenabled=YES;


    }
    return self;
}

-(void)addBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(addViewWithAddWith:)]) {
        [self.delegate addViewWithAddWith:btn];
    }
}

#pragma mark 昵称点击
- (void) nameClick
{
    if ([self.delegate respondsToSelector:@selector(nameClick)]) {
        [self.delegate nameClick];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.view.frame=CGRectMake(0, 0, self.width, self.height);
    
    //加光晕效果
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(25, self.height-17-52, 52, 52)];
    view.backgroundColor=RGBACOLOR(0, 0, 0, 0.08);
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=view.width/2;
    self.ve.frame=CGRectMake(25, self.height-17-52, 52, 52);
    self.icon.frame=CGRectMake(30, self.height-20-57, 48, 48);
    self.icon.layer.cornerRadius= self.icon.frame.size.width/2;//按钮宽的一半;变成圆
    self.icon.center=view.center;
    
   self.nameL.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+20,self.icon.y+6, self.view.width/4, self.view.height/8);
    self.nameL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.nameL.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);//两句左对齐
    CGSize FontHeight=[@"LV11"  boundingRectWithSize:CGSizeMake(200, 3000) options:0 attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:11]} context:nil].size;


    CGFloat iconBottomX=self.icon.width/2+self.icon.x;
      self.vip.frame = CGRectMake(iconBottomX+2,self.icon.maxY-FontHeight.height,FontHeight.width+2,FontHeight.height-2);
    
    self.IDL.frame=CGRectMake(self.nameL.x,self.nameL.height+self.nameL.y+3,self.nameL.width,self.nameL.height);

    
    self.addBtn.frame=CGRectMake(self.view.width-11-18,32,18,18);
    CGFloat CardW =self.view.width/5;
    
    self.doCard.frame=CGRectMake( self.view.width+18-CardW,self.height-23-30, CardW+15,23);
    self.doCard.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    
}

-(void)setModel:(FriendModel *)model{
    _model = model;
    
    if ([UserInfoTool isLogin]) {
        if ([UserInfoTool getUserInfo].nickname == nil) {
            [self.nameL setTitle:@"" forState:UIControlStateNormal];
        }else{
            [self.nameL setTitle:[UserInfoTool getUserInfo].nickname forState:UIControlStateNormal];
        }
        
        [self.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:[UserInfoTool getUserInfo].headimgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"hot_user_default"]];
        
        self.vip.text = [NSString stringWithFormat:@"LV%ld",(long)[UserInfoTool getUserInfo].lv];
        
        if ([UserInfoTool getUserInfo].username == nil) {
            self.IDL.text = @"";
        }else{
            self.IDL.text = [UserInfoTool getUserInfo].username;
        }
    }
}

-(void)setCardBtnenabled:(BOOL)cardBtnenabled{

    self.doCard.enabled = cardBtnenabled;
}
@end
