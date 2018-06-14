//
//  MainNavigationController.m
//  MoveSchool
//
//  Created by edz on 2017/4/19.
//
//

#import "MainNavigationController.h"
#import "NewMyTeacherController.h"
#import "SettingController.h"
#import "SearchController.h"
#import "SearchResultController.h"
#import "MyDownLoadsViewController.h"
#import "AboutMineController.h"
#import "MainWebController.h"
#import "CreateVideoCourseController.h"
#import "CutMusicController.h"
#import "UploadListController.h"
#import "VideoPreviewController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

#pragma mark 项目生命周期中只执行一次
+ (void)initialize
{
    //tabBar主题 title文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSMutableDictionary *tabBarItemDict = [NSMutableDictionary dictionary];
    tabBarItemDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [tabBarItem setTitleTextAttributes:tabBarItemDict forState:UIControlStateNormal];
    
    NSMutableDictionary *tabBarItemDictSelect = [NSMutableDictionary dictionary];
    tabBarItemDictSelect[NSForegroundColorAttributeName] = MainColor;
    tabBarItemDictSelect[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [tabBarItem setTitleTextAttributes:tabBarItemDictSelect forState:UIControlStateSelected];
    
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarTintColor:[UIColor whiteColor]];
    tabBar.translucent = NO;
    
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = MainColor;
    navBar.translucent = NO;
    NSMutableDictionary *navBarDict = [NSMutableDictionary dictionary];
    navBarDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    navBarDict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:ys_f36];
    [navBar setTitleTextAttributes:navBarDict];
    
    //导航栏左右文字主题
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    NSMutableDictionary *batButtonDict = [NSMutableDictionary dictionary];
    batButtonDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    batButtonDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [barButtonItem setTitleTextAttributes:batButtonDict forState:UIControlStateNormal];
}

/*
 * viewController 需要跳转到的目标控制器
 * animated 跳转时是否需要动画
 */
#pragma mark 拦截push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[NewMyTeacherController class]] || [viewController isKindOfClass:[SearchResultController class]] || [viewController isKindOfClass:[MyDownLoadsViewController class]] || [viewController isKindOfClass:[AboutMineController class]]) {
        viewController.view.backgroundColor = [UIColor whiteColor];
    }else
    {
        viewController.view.backgroundColor = ViewBackColor;
    }
    
    if (self.viewControllers.count > 0) {
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.hidesBottomBarWhenPushed = YES;
        
        if (![viewController isKindOfClass:[SearchResultController class]] && ![viewController isKindOfClass:[MainWebController class]] && ![viewController isKindOfClass:[CreateVideoCourseController class]] && ![viewController isKindOfClass:[CutMusicController class]] && ![viewController isKindOfClass:[UploadListController class]] && ![viewController isKindOfClass:[VideoPreviewController class]]) {
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor whiteColor] imageFont:18];
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark 返回按钮点击
- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}


@end
