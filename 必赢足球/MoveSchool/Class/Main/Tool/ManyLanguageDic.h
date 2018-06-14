//
//  ManyLanguageDic.h
//  Main
//
//  Created by yuhongtao on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//
/**
 *  所有多语言字典分为两类
 *
 *  @param NSDictionary 直接type查询  的字典
 *
 *  @return 根据中文字符串得到可食用type查询的第一类字典
 */

#import <Foundation/Foundation.h>

@interface ManyLanguageDic : NSObject
//   0中文	1英文	2韩文	3日文	4荷兰语

@property(nonatomic,copy)NSString *language;
@property(nonatomic,strong)NSDictionary *dic;
+ (ManyLanguageDic *)sharedManager;
@property(nonatomic,copy)NSString *type;  //就是什么语言
@property(nonatomic,strong)NSDictionary *introduceDic;  //设置介绍界面  的介绍
@property(nonatomic,strong)NSDictionary *SettingDic;  //设置界面
@property(nonatomic,strong)NSDictionary *tabbarDic;   //返回tabbar的语言组
@property(nonatomic,strong)NSDictionary *hotTypeDic;   //热点推荐类型
@property(nonatomic,strong)NSDictionary *mineMuneDic;   //热点推荐类型
@property(nonatomic,strong)NSDictionary *hotDic;   //热点所有
@property(nonatomic,strong)NSDictionary *courseDic;   //课程所有
@property(nonatomic,strong)NSDictionary *exchangeDic;   //课程所有
@property(nonatomic,strong)NSDictionary *MineDic;   //我的所有
@property(nonatomic,strong)NSDictionary *logoutDic;   //我的所有
@property(nonatomic,strong)NSDictionary *loginDic;//登录界面所有
@property(nonatomic,strong)NSDictionary *tipDic;//登录界面所有
@property(nonatomic,strong)NSDictionary *hotTabbarDic;
@property(nonatomic,strong)NSDictionary *refreshDic;  //刷新控件多语言。

@end
