//
//  MineStudyViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/2.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "MineStudyViewController.h"
#import "MineStudyCourseViewController.h"
#import "MainWebController.h"
#import "AFNetWW.h"
#import "MineStudyZhuantiViewController.h"

@interface MineStudyViewController ()<MineStudyCourseViewControllerDelegate, MineStudyZhuantiViewControllerDelegate>

//沙龙
@property(nonatomic, strong) MainWebController *shalong;

//直播
@property(nonatomic, strong) MainWebController *live;

@end

@implementation MineStudyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [ManyLanguageMag getMineMenuStrWith:@"我的学习"];

    if (self.SourceType == SourceCollection) {
        self.title = [ManyLanguageMag getMineMenuStrWith:@"我的收藏"];
    }else if(self.SourceType == SourceCause)
    {
        self.title = [ManyLanguageMag getMineMenuStrWith:@"我的事业部"];
    }
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    //获取数据
    if(self.SourceType == SourceCause)
    {
        [self setUpData : self.zttid];
    }else
    {
        [self setUpData : @"0"];
    }

}

- (void) setButtonBarView
{
    self.isProgressiveIndicator = YES;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:[UIColor grayColor]];
            [newCell.label setTextColor:GreenColor];
            
            if (animated) {
                [UIView animateWithDuration:0.1
                                 animations:^(){
                                     oldCell.label.font = [UIFont systemFontOfSize:14];
                                     newCell.label.font = [UIFont systemFontOfSize:14];
                                     
                                 }
                                 completion:nil];
            }
            else{
                oldCell.label.font = [UIFont systemFontOfSize:14];
                newCell.label.font = [UIFont systemFontOfSize:14];
            }
        }
    };
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    MineStudyCourseViewController *study = [[MineStudyCourseViewController alloc] init];
    study.CourseSourceType = self.SourceType;
    study.zttid = self.zttid;
    study.pageTitle = @"课程";
    study.delegate = self;
    [childVcArray addObject:study];
    
    MineStudyZhuantiViewController *special = [[MineStudyZhuantiViewController alloc] initWithType:self.SourceType];
    
    special.zttid = self.zttid;
    special.delegate = self;
    special.pageTitle = @"专题";
    [childVcArray addObject:special];
    
    MainWebController *shalong = [[MainWebController alloc] init];
    shalong.isFromStudy = YES;
    shalong.webTitle = @"沙龙";
    
    NSString *url = [NSString stringWithFormat:@"%@%@?zttid=%@",NetHeader,Myshalonglist,self.SourceType == SourceCause ? self.zttid : @"0"];
    if (self.SourceType == SourceCollection) { //我的收藏
        url = [NSString stringWithFormat:@"%@%@?zttid=%@&type=%@",NetHeader,MycollectionL,[UserInfoTool getUserInfo].zttid,shalongType];
    }
    shalong.url = url;
    self.shalong = shalong;
    [childVcArray addObject:shalong];
    
    MainWebController *live = [[MainWebController alloc] init];
    live.isFromStudy = YES;
    live.webTitle = @"直播";
    NSString *liveUrl = [NSString stringWithFormat:@"%@%@?appkey=%@&zttid=%@&locale=%@",NetHeader,Mylivelist,appkey,self.SourceType == SourceCause ? self.zttid : @"0",[ManyLanguageMag getTypeWithWebDiscript]];
    
    if (self.SourceType == SourceCollection) { //我的收藏
        liveUrl = [NSString stringWithFormat:@"%@%@?appkey=%@&zttid=%@&type=%@&locale=%@",NetHeader,MycollectionL,appkey,[UserInfoTool getUserInfo].zttid,liveType,[ManyLanguageMag getTypeWithWebDiscript]];
    }
    live.url = liveUrl;
    self.live = live;
    [childVcArray addObject:live];
    
    return childVcArray;
}

/**
 * zttid 如果是自己的传0
 */
#pragma mark 获取数据
- (void) setUpData : (NSString *) zttid
{
    //获取沙龙列表
    [self getSalongList:zttid];
    
    //获取直播列表
    [self getLiveList : zttid];
}


#pragma mark 获取沙龙列表
-(void) getSalongList : (NSString *) zttid
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=10&zttid=%@",NetHeader,Solonlist,[UserInfoTool getUserInfo].token,zttid];
    
    if (self.SourceType == SourceCollection) {
        url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=1000&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,shalongType];
    }
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        
        NSString *all = [NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"沙龙"],responseDic[@"data"][@"all"]];
        self.shalong.webTitle = all;
        [self.buttonBarView reloadData];
    } fail:^(NSError *error) {
        
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 获取直播列表
- (void) getLiveList : (NSString *) zttid
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=10&zttid=%@",NetHeader,Livelist,[UserInfoTool getUserInfo].token,zttid];
    
    if (self.SourceType == SourceCollection) {
        url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=1000&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,liveType];
    }
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSString *all=[NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"直播"],responseDic[@"data"][@"all"]];
        self.live.webTitle = all;
        [self.buttonBarView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 刷新标题课程数量
- (void) reloadButtonBarView
{
    [self.buttonBarView reloadData];
}

@end
