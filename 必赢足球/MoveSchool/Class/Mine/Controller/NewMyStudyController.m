//
//  NewMyStudyController.m
//  MoveSchool
//
//  Created by edz on 2017/9/12.
//
//

#import "NewMyStudyController.h"
#import "CourseListController.h"
#import "AFNetWW.h"
#import "BusinessCountModel.h"
#import "MJExtension.h"
#import "MyStudyCourseController.h"
#import "SpecialController.h"
#import "MyStudySpecialController.h"
#import "MyStudyShalongController.h"
#import "MyStudyLiveController.h"

@interface NewMyStudyController ()

@property (nonatomic, strong) BusinessCountModel *businessCountModel;

@property (nonatomic, strong) MyStudyCourseController *courseList;

@property (nonatomic, strong) MyStudySpecialController *specVc;

@property (nonatomic, strong) MyStudyShalongController *shalongVc;

@property (nonatomic, strong) MyStudyLiveController *liveVc;

@end

@implementation NewMyStudyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    //获取业务数量
    [self getCount];
    
    self.title = @"我的学习";
}

- (void) getCount
{
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,BusinessCount,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             BusinessCountModel *businessCountModel = [BusinessCountModel objectWithKeyValues:responseDic[@"data"]];
             self.courseList.studyTitle = [NSString stringWithFormat:@"课程(%@)",businessCountModel.courseCount];
             
             self.specVc.studyTitle = [NSString stringWithFormat:@"专题(%@)",businessCountModel.classesCount];
             
             self.shalongVc.studyTitle = [NSString stringWithFormat:@"沙龙(%@)",businessCountModel.shalongCount];
             
             self.liveVc.studyTitle = [NSString stringWithFormat:@"直播(%@)",businessCountModel.liveCount];

             
             [self.buttonBarView reloadData];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) setButtonBarView
{
    self.isProgressiveIndicator = YES;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:AuxiliaryColor];
            [newCell.label setTextColor:MainColor];
            
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
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    self.buttonBarView.selectedBarAlignment = XLSelectedBarAlignmentCenter;
    
    NSMutableArray *childVcArray = [NSMutableArray array];

    //课程
    MyStudyCourseController *courseList = [[MyStudyCourseController alloc] init];
    self.courseList = courseList;
    courseList.studyTitle = @"课程";
    [childVcArray addObject:courseList];
    
    //专题
    MyStudySpecialController *specVc = [[MyStudySpecialController alloc] init];
    self.specVc = specVc;
    specVc.studyTitle = @"专题";
    [childVcArray addObject:specVc];
    
    //沙龙
    MyStudyShalongController *shalongVc = [[MyStudyShalongController alloc] init];
    self.shalongVc = shalongVc;
    shalongVc.studyTitle = @"沙龙";
    [childVcArray addObject:shalongVc];
    
    //直播
    MyStudyLiveController *liveVc = [[MyStudyLiveController alloc] init];
    self.liveVc = liveVc;
    liveVc.studyTitle = @"直播";
    [childVcArray addObject:liveVc];
    
    return childVcArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
