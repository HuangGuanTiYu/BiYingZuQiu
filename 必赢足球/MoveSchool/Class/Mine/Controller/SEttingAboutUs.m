//
//  SEttingAboutUs.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/2.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "SEttingAboutUs.h"
#import "LanguageSettingViewController.h"
#import "ColorTypeTools.h"
#import "UIView+Extension.h"
#import "ManyLanguageMag.h"

@interface SEttingAboutUs ()

@end

@implementation SEttingAboutUs

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [ManyLanguageMag getSettingStrWith:@"关于我们"];

    [self setUpSubView];
}

-(void)setUpSubView{
    
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.width/3, 37, self.view.width/3, self.view.width/3)];
    
    view.image = [UIImage imageNamed:@"Image"];
    [self.view addSubview:view];
    
    
    UILabel *titleL=[[UILabel alloc]init];
    
    NSString *tem=[self getCurrentLocalVersion];
    
    titleL.text = [NSString  stringWithFormat:@"%@app%@",[ManyLanguageMag  getSettingStrWith:@"网易足球"],tem];
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.textColor=kColorBlack64;
    titleL.frame=CGRectMake(self.view.width/3+5, CGRectGetMaxY(view.frame)+15, self.view.width/3+20, 30);
    [self.view addSubview:titleL];
    
    NSString * str  = [ManyLanguageMag getIntroduceDicStr];

    UILabel *labelL = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(titleL.frame), self.view.width-60, 300)];
    
    labelL.numberOfLines = 0;
    
    labelL.lineBreakMode = NSLineBreakByWordWrapping;
    
    labelL.text = str;
    
    labelL.textColor = kColorGray154;
    
    CGSize size = [labelL sizeThatFits:CGSizeMake(labelL.frame.size.width, MAXFLOAT)];
    
    labelL.frame =CGRectMake(40, CGRectGetMaxY(view.frame)+5, self.view.width-80, size.height);
    
    labelL.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:labelL];
}

#pragma mark 根据文字计算长度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  (CGFloat)[string boundingRectWithSize:CGSizeMake(0, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}

#pragma mark-获取当前app版本
- (NSString *)getCurrentLocalVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];    
    NSString *version=[NSString stringWithFormat:@"%@",app_Version];
    return version;
}
@end
