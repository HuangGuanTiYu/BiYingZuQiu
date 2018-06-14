//
//  MainWebController.h
//  MoveSchool
//
//  Created by edz on 2017/4/21.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

@class HomePageModel,ShalonModel;

@interface MainWebController : UIViewController<XLPagerTabStripChildItem>

//URL
@property(copy, nonatomic) NSString *url;

//标题
@property(copy, nonatomic) NSString *webTitle;

//是否是从 我的学习进入的 上方有50的 滑动导航栏
@property(assign, nonatomic) BOOL isFromStudy;

//底部是否有tabbar 如果有 高度需要 -49的 tabbar高度
@property(assign, nonatomic) BOOL isTabbar;

//沙龙ID
@property(copy, nonatomic) NSString *shalongId;

//右上角是否需要添加 搜索按钮 🔍
@property(assign, nonatomic) BOOL needSearch;

//是否是 制作课件进入的 如果是 返回的时候 保存课件
@property(assign, nonatomic) BOOL isFromH5Course;

//返回webview的上一层界面
@property (nonatomic, assign) BOOL backWebPage;

//是否是 点击 加号 present出来的
@property (nonatomic, assign) BOOL isPresent;

@property (nonatomic, assign) BOOL isZiXun;

@property (nonatomic, strong) HomePageModel *model;

@property (nonatomic, assign) BOOL isShalong;

@property (nonatomic, strong) ShalonModel *shalongModel;


@end
