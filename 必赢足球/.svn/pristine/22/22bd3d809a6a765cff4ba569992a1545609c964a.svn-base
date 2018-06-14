//
//  MultileHeadView.m
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "MultileHeadView.h"
#import "Fastbtn.h"
#import "AFNetWW.h"

#define kSize [[UIScreen mainScreen]bounds].size

#define lunbotuH 150

#define fastbtnH 130

#define marginLeft 10
#define marginMiddle 7

#import "UIView+Utils.h"
#import "SDCycleScrollView.h"

@implementation MultileHeadView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initlunbotu];
        [self initfastbtn];
       
        
    }
    return self;
}
-(void)initlunbotu{

    self.backgroundColor =[UIColor   whiteColor];
    [[AFNetWW sharedAFNetWorking]  AFWithPostORGet:@"get" withURLStr:[NSString stringWithFormat:@"%@%@",NetHeader,SheetImages] WithParameters:nil success:^(id responseDic) {
        
        NSMutableArray *tempArr =  [NSMutableArray array];
        self.tempArr = responseDic[@"rows"];
        
        for (int i=0; i<self.tempArr.count; i++) {
            
            NSDictionary *dic = self.tempArr[i];
            NSString *imgUrl = dic[@"picurl"];
            [tempArr addObject:imgUrl];
        }
        
        // 轮播图
        SDCycleScrollView *apView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, lunbotuH)];
        apView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        apView.currentPageDotColor = GreenColor; // 自定义分页控件小圆标颜色
        [self addSubview:apView];
        
        apView.imageURLStringsGroup = tempArr;
        
        
        apView.clickItemOperationBlock = ^(NSInteger index) {
            NSDictionary *dic = self.tempArr[index];
            NSString *type = dic[@"type"]; //type 1  webview打开  2  课程详情
            NSString *weburl = dic[@"weburl"];
            NSString *chapterid = dic[@"chapterid"];
            
            UIButton *btn=[[UIButton alloc]init];
            btn.tag = [type intValue];
            [self.delegate fastbtnclick:btn withType:type withID:chapterid withWebUrl:weburl];
        };


        
    } fail:^(NSError *error) {
        
    }];
}

-(void)initfastbtn{
    
    UIView *fastview=[[UIView alloc]initWithFrame:CGRectMake(0, marginMiddle+lunbotuH, kSize.width, fastbtnH)];
    [self addSubview:fastview];
    NSString * butOne=[ManyLanguageMag getHotTypeStrWith:@"专题"];
    NSString * butTwo=[ManyLanguageMag getHotTypeStrWith:@"直播"];
    NSString * butThere=[ManyLanguageMag getHotTypeStrWith:@"沙龙"];
    NSString * butFore=[ManyLanguageMag getHotTypeStrWith:@"学习"];
    NSArray *nameArray = @[butOne,butTwo,butThere,butFore];
    for (int i=0; i<4; i++) {
        
        CGFloat  width = self.frame.size.width/4;
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(i*width,lunbotuH , width, width)];
        [btn addTarget: self action:@selector(fastClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btn];

        UIButton *image = [[UIButton alloc]initWithFrame:CGRectMake(i*width-width/2, 10, 40, 40)];
        [image addTarget:self action:@selector(fastClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"course_%d",i+1]] forState:UIControlStateNormal];
        btn.tag = 1000+i;
        image.centerX = btn.centerX;
        [fastview addSubview:image];
        
        UILabel *  nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(i*width-width/2, 35, 40, 60)];
        nameLabel.centerX =  image.centerX+6;
        nameLabel.text = nameArray[i];
        nameLabel.font =[UIFont systemFontOfSize:13];
        nameLabel.textColor = kColorBlack;
        [fastview addSubview:nameLabel];
    }
    
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, kSize.width, 1)];
    line.backgroundColor=kColorGray240;
    [self addSubview:line];
}

-(void)fastClickBtn:(UIButton *)btn{
    [self.delegate fastbtnclick:btn withType:nil withID:nil withWebUrl:nil];
}

-(void)didSelectedLocalImageAtIndex:(NSInteger)index{
    


}
@end
