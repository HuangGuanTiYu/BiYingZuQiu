//
//  MineStudyCourseViewController.m
//  Main
//
//  Created by yuhongtao on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//  课程列表

#import "MineStudyCourseViewController.h"
#import "AFNetWW.h"
#import "CourseView.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MainWebController.h"
#import "ManyLanguageMag.h"
#import "CourseDetailController.h"
#import "CourseDetailArrayModel.h"

@interface MineStudyCourseViewController ()<UITableViewDelegate, UITableViewDataSource>

//课程列表
@property(nonatomic, strong) UITableView *courseList;

//课程数组
@property(nonatomic,strong) NSMutableArray *courseArray;

//分页索引值
@property(nonatomic, assign) int index;

//是否是 加载更多
@property(nonatomic, assign) BOOL isMoreData;

@end

@implementation MineStudyCourseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    
    self.courseArray = [NSMutableArray array];

    //获取课程列表
    if (self.CourseSourceType == CourseSourceStudy) {
        [self getCourseList : @"0"];
    }else if (self.CourseSourceType == CourseSourceCollection)
    {
        [self getCollectionCourseList];
    }else if (self.CourseSourceType == CourseSourceCourseStudy)
    {
        [self getCourseStudyList];
    }else if (self.CourseSourceType == CourseSourceCause) {
        [self getCourseList : self.zttid];
    }
    
    [self setUpUI];
}

#pragma mark 获取课程-学习 课程列表
- (void) getCourseStudyList
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CollegeCourseList,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               @"instid": self.instname,
                               @"index": @(self.index),
                               @"count":@"10"
                               };
    
    [self getCoursesList:url Parameters:Parameters];
}

#pragma mark 获取我的收藏课程列表
- (void) getCollectionCourseList
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=%@&count=10&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,@(self.index),courseType];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *courseAll = [NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"课程"],responseDic[@"data"][@"all"]];
            self.pageTitle = courseAll;
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.courseArray addObjectsFromArray:(NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.courseArray = (NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.courseList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部课程"];
            }
            
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 获取我的课程列表
- (void) getCourseList : (NSString *) zttid
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MineCourseList,[UserInfoTool getUserInfo].token];
    
    NSDictionary *Parameters=@{
                               @"index": @(self.index),
                               @"count":@"10",
                               @"zttid":zttid
                               };
    [self getCoursesList:url Parameters:Parameters];
}

#pragma mark 获取课程列表
- (void) getCoursesList : (NSString *) url Parameters : (NSDictionary *) Parameters
{
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *courseAll = [NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"课程"],responseDic[@"data"][@"all"]];
            
            self.pageTitle = courseAll;
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.courseArray addObjectsFromArray:(NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.courseArray = (NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.courseList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部课程"];
            }
            
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];

}

- (void) setUpUI
{
    if (self.CourseSourceType == CourseSourceCourseStudy) {
        self.title = self.courseName;
    }
    
    self.courseList = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.courseList.height = self.view.height - 64 - (self.CourseSourceType == CourseSourceCourseStudy ? 0 : 41);
    self.courseList.delegate = self;
    self.courseList.dataSource = self;
    self.courseList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseList.showsHorizontalScrollIndicator = NO;
    self.courseList.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.courseList];
    
    __weak __typeof(self) weakSelf = self;

    //下拉刷新
    self.courseList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isMoreData = NO;
        weakSelf.index = 0;
        //获取课程列表
        if (weakSelf.CourseSourceType == CourseSourceStudy) {
            [weakSelf getCourseList : @"0"];
        }else if (self.CourseSourceType == CourseSourceCollection)
        {
            [weakSelf getCollectionCourseList];
        }else if (self.CourseSourceType == CourseSourceCourseStudy)
        {
            [weakSelf getCourseStudyList];
        }else if (self.CourseSourceType == CourseSourceCause) {
            [weakSelf getCourseList : self.zttid];
        }
    }];
    
    // 上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.courseList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isMoreData = YES;
        ++weakSelf.index;
        if (weakSelf.CourseSourceType == CourseSourceStudy) {
            [weakSelf getCourseList : @"0"];
        }else if (self.CourseSourceType == CourseSourceCollection)
        {
            [weakSelf getCollectionCourseList];
        }else if (self.CourseSourceType == CourseSourceCourseStudy)
        {
            [weakSelf getCourseStudyList];
        }else if (self.CourseSourceType == CourseSourceCause) {
            [weakSelf getCourseList : self.zttid];
        }
    }];
    
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.pageTitle;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.courseArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseView *cell = [tableView dequeueReusableCellWithIdentifier:
                        @"CourseView"];
    if (cell == nil) {
        cell = [[CourseView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CourseView"];
    }
    
    if (self.CourseSourceType == CourseSourceStudy) {
        cell.showState = YES;
    }
    cell.hiddenCourse = YES;
    cell.model = self.courseArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.width = self.view.width;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.width / 5 + 20;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailModel *model = self.courseArray[indexPath.row];
    if ([model.btnstatus isEqualToString:@"2"] || [model.btnstatus isEqualToString:@"3"]) { //考试详情
        MainWebController *examController = [[MainWebController alloc] init];
        examController.webTitle = @"考试详情";
        
        NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testid=%@",NetHeader,CourseTest,[UserInfoTool getUserInfo].token,model.mainid];

        examController.url = uelStr;
        [self.navigationController pushViewController:examController animated:YES];
    }else{ //课程详情
        if (model.mainid==nil) {
            model.mainid=@"";
        }
        
        NSString *chapterid = model.chapterid ? model.chapterid : model.course_id;
        NSString *mainid = model.mainid ? model.mainid: model.courseid;
        
        NSDictionary *parameter=@{
                                  @"chapterid":chapterid
                                  };
        NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
            NSInteger code=[responseDic[@"rescode"] integerValue];
            
            if (code == 10000)
            {
                NSDictionary *parameter=@{
                                          @"chapterid": chapterid,
                                          @"mainid" :mainid
                                          };
                
                NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDetail,[UserInfoTool getUserInfo].token];
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                    NSInteger code = [responseDic[@"rescode"] integerValue];
                    
                    if (code == 10000){
                        
                        CourseDetailArrayModel *courseDetail = [CourseDetailArrayModel objectWithKeyValues:responseDic[@"data"]];
                        NSArray *captions = [CourseDetailModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
                        
                        //到课程详情
                        CourseDetailController *courseDetailVc = [[CourseDetailController alloc] init];
                        courseDetailVc.courseDetail = courseDetail;
                        if (captions.count > 0) {
                            courseDetailVc.captions = captions;
                        }
                        [self.navigationController pushViewController:courseDetailVc animated:YES];
                    }
                } fail:^(NSError *error) {
                    [MBProgressHUD showText:@"请联系管理员" inview:self.view];
                }];
            }else if(code == 30030)
            {
                [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
            }
            
        } fail:^(NSError *error) {
            [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
        }];
    }
}

@end
