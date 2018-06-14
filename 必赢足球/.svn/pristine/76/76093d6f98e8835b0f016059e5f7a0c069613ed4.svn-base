//
//  InteractionController.m
//  MoveSchool
//
//  Created by edz on 2017/5/6.
//
//

#import "InteractionController.h"
#import "MainWebController.h"
#import "StudyCircleController.h"
#import "MineStudyCourseViewController.h"

@interface InteractionController ()

@end

@implementation InteractionController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
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
    
    StudyCircleController *study = [[StudyCircleController alloc] init];
    study.studyTitle = [ManyLanguageMag gethExchangeStrWith:@"学习圈"];
    [childVcArray addObject:study];
    
    MainWebController *question = [[MainWebController alloc] init];
    question.isTabbar = YES;
    NSString *url = [NSString stringWithFormat:@"%@%@?locale=%@",NetHeader,Question,[ManyLanguageMag getTypeWithWebDiscript]];
    question.url = url;
    question.webTitle = [ManyLanguageMag gethExchangeStrWith:@"问答"];
    [childVcArray addObject:question];
    
    MainWebController *glory = [[MainWebController alloc] init];
    glory.isTabbar = YES;
    NSString *urlStr=[NSString stringWithFormat:@"%@%@?locale=%@",NetHeader,HonorRoll,[ManyLanguageMag getTypeWithWebDiscript]];
    glory.url = urlStr;
    glory.webTitle =[ManyLanguageMag gethExchangeStrWith:@"荣誉榜"];
    [childVcArray addObject:glory];
    
    return childVcArray;
}

@end
