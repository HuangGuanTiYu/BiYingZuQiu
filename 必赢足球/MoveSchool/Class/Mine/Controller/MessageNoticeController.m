//
//  MessageNoticeController.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "MessageNoticeController.h"
#import "AFNetWW.h"
#import "MessageModel.h"
#import "MJExtension.h"
#import "MessageTaskNoticeCell.h"
#import "MJRefresh.h"
#import "MainWebController.h"
#import "CourseSpecialDetailViewController.h"
#import "UIViewController+Extension.h"
#import "MJChiBaoZiHeader.h"
#import "NewCourseDetailController.h"
#import "NewTeacherController.h"
#import "SpecialDetailModel.h"
#import "SpecialDetailTitleModel.h"
#import "SpecialDetailController.h"
#import "NewCourseModel.h"
#import "NewVideoCourseController.h"
#import "CourseBean.h"

@interface MessageNoticeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messageModels;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL hasRole;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MessageNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.messageModels = [NSMutableArray array];

}

- (void) setUpData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMsgRecord,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               @"msgtype"  : @"2",
                               @"index":[NSString stringWithFormat:@"%d",self.index],
                               @"count":@"10"
                               };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([self.delegate respondsToSelector:@selector(setRedNoticePoint:)]) {
            [self.delegate setRedNoticePoint:[responseDic[@"data"][@"count"] intValue]];
        }
        
        NSArray *models = [MessageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
        if (models.count > 0) {
            if (self.isMoreData) {
                [self.messageModels addObjectsFromArray:models];
            }else
            {
                self.messageModels = (NSMutableArray *)models;
            }
            
            //没有内容
            if (self.messageModels.count == 0) {
                self.tableView.hidden = YES;
                self.noCommentView.hidden = NO;
            }else
            {
                self.noCommentView.hidden = YES;
                self.tableView.hidden = NO;
            }
            
            [self.tableView reloadData];
        }else if(self.isMoreData)
        {
           
            --self.index;
            [MBProgressHUD showError:@"已加载全部信息"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }else
        {
            //没有内容
            if (self.messageModels.count == 0) {
                self.tableView.hidden = YES;
                self.noCommentView.hidden = NO;
            }else
            {
                self.noCommentView.hidden = YES;
                self.tableView.hidden = NO;
            }
        }
        
        
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"通知";
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    tableView.y = self.hasRole ? 70 : 0;
    tableView.height = self.hasRole ? self.view.height - 140: self.view.height - 70;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 设置header
    self.tableView.mj_header = header;
    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    tableView.mj_footer = footer;
    
    //没有评论
    UIView *noCommentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.noCommentView = noCommentView;
    noCommentView.hidden = YES;
    [self.view addSubview:noCommentView];
    
    //图片 + 文字
    UIView *imageTexgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, noCommentView.width, 129)];
    imageTexgView.centerY = self.view.height * 0.5 - 45 - 64;
    [noCommentView addSubview:imageTexgView];
    
    //背景图
    UIImageView *noImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 121, 90)];
    noImage.image = [UIImage imageNamed:@"kong"];
    noImage.centerX = noCommentView.width * 0.5;
    [imageTexgView addSubview:noImage];
    
    UILabel *toTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noImage.frame) + 5, noCommentView.width, 20)];
    toTestLabel.textAlignment = NSTextAlignmentCenter;
    toTestLabel.text = @"还没有内容呀~";
    toTestLabel.textColor = AuxiliaryColor;
    toTestLabel.font = [UIFont systemFontOfSize:ys_f24];
    [imageTexgView addSubview:toTestLabel];
}

- (void) loadMoreData
{
    self.isMoreData = YES;
    ++self.index;
    [self setUpData];
}

#pragma mark 下拉刷新
- (void) headerRefresh
{
    self.isMoreData = NO;
    self.index = 0;
    [self setUpData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageModels.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    MessageTaskNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageTaskNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.type = Notice;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageModel *model = self.messageModels[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = self.messageModels[indexPath.row];
    return model.noticeInfoHeight + 50;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setUpData];

}

- (void)setTableViewHeight: (BOOL) hasRole
{
    self.hasRole = hasRole;
    
    [self setUpUI];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MessageModel *model = self.messageModels[indexPath.row];
//
//    //考试
//    if ([model.businesscode isEqualToString:testType]){
//        NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testid=%@",NetHeader,CourseTest,[UserInfoTool getUserInfo].token,model.businessid];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//
//    //沙龙
//    if ([model.businesscode isEqualToString:shalongType]) {
//        MainWebController *shalong = [[MainWebController alloc] init];
//        NSString *url = [NSString stringWithFormat:@"%@%@?id=%@&locale=%@",NetHeader,Shalongdetail,model.businessid,[ManyLanguageMag getTypeWithWebDiscript]];
//        shalong.url = url;
//        shalong.webTitle = model.title;
//        [self.navigationController pushViewController:shalong animated:YES];
//    }else
//
//    //问卷
//    if ([model.businesscode isEqualToString:voteType]) {
//        NSString *uelStr = [NSString stringWithFormat:@"%@/mh5/vote/votetags?id=%@",NetHeader,model.businessid];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//
//    //专题
//    if ([model.businesscode isEqualToString:specialType]) {
//        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ClassesInfo,[UserInfoTool getUserInfo].token];
//
//        NSDictionary *dic = @{
//                              @"classesid" : model.businessid
//                              };
//
//        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
//            int rescode = [responseDic[@"rescode"] intValue];
//            if (rescode == 10000) {
//
//                SpecialDetailModel *detailModel = [SpecialDetailModel objectWithKeyValues:responseDic[@"data"]];
//                NSArray *titles = [SpecialDetailTitleModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
//
//                SpecialDetailController *specialDetailVc = [[SpecialDetailController alloc] init];
//                specialDetailVc.detailModel = detailModel;
//                specialDetailVc.titles = titles;
//                [self.navigationController pushViewController:specialDetailVc animated:YES];
//            }
//        } fail:^(NSError *error) {
//            [MBProgressHUD showError:@"发送请求失败"];
//        }];
//
//    }else
//
//    //直播
//    if ([model.businesscode isEqualToString:liveType]) {
//        NSString *uelStr = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,model.businessid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//
//    //课程
//    if ([model.businesscode isEqualToString:courseType]) {
//
//        //根据format判断是课程 还是 音频课程
//        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&courseid=%@&token=%@",NetHeader,GetCoursesDetail,model.businessid,[UserInfoTool getUserInfo].token];
//
//        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
//         {
//             if ([responseDic[@"rescode"] intValue] == 10000) {
//
//                 NewCourseModel *model = [NewCourseModel objectWithKeyValues:responseDic[@"data"]];
//                 if (model.courseBean.format != 3) {
//                     NewCourseDetailController *newCourseVc = [[NewCourseDetailController alloc] init];
//                     newCourseVc.courseid = model.courseBean.mainid;
//                     [self.navigationController pushViewController:newCourseVc animated:YES];
//                 }else
//                 {
//                     NewVideoCourseController *newCourseVc = [[NewVideoCourseController alloc] init];
//                     newCourseVc.courseid = model.courseBean.mainid;
//                     [self.navigationController pushViewController:newCourseVc animated:YES];
//                 }
//             }else
//             {
//                 [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
//             }
//
//         }fail:^(NSError *error) {
//             [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
//         }];
//    }else
//
//    //资讯
//    if ([model.businesscode isEqualToString:newsType]) {
//        MainWebController *webVc = [[MainWebController alloc] init];
//        webVc.webTitle = @"资讯详情";
//        webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",NetHeader,NewsDetail,model.businessid];
//        [self.navigationController pushViewController:webVc animated:YES];
//    }else
//
//    //讲师
//    if ([model.businesscode isEqualToString:teacherType]) {
//        NewTeacherController *newTeacherVc = [[NewTeacherController alloc] init];
//        newTeacherVc.teacherid = model.businessid;
//        newTeacherVc.nickname = model.title;
//        newTeacherVc.userid = model.businessid;
//        [self.navigationController pushViewController:newTeacherVc animated:YES];
//    }
}

@end
