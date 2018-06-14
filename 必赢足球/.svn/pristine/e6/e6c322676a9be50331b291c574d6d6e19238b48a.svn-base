//
//  NewTeacherLiveController.m
//  MoveSchool
//
//  Created by edz on 2017/10/14.
//
//

#import "NewTeacherLiveController.h"
#import "AFNetWW.h"
#import "HomePageModel.h"
#import "MJExtension.h"
#import "LiveListCell.h"
#import "LiveListPastCell.h"
#import "MainWebController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "SearchResultController.h"
#import "CCLiveModel.h"
#import <CCPush/CCPushUtil.h>
#import "PrePushViewController.h"

@interface NewTeacherLiveController ()<UITableViewDelegate, UITableViewDataSource, LiveListPastCellDelegate, CCPushUtilDelegate>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, assign) BOOL isMoreData;

@property(nonatomic, assign) int index;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation NewTeacherLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"直播";

    self.index = 0;
    
    [self setUpUI];
    
    self.datas = [NSMutableArray array];
    
    [self setUpData];
}

- (void) headerRefresh
{
    self.index = 0;
    self.isMoreData = NO;
    [self setUpData];
}

- (void) setUpUI
{

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e627" target:self selector:@selector(test) imageColor:[UIColor whiteColor] imageFont:18];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.height = self.view.height - 64;
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 设置header
    self.tableView.mj_header = header;
    
    __weak __typeof(self) weakSelf = self;
    
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

- (void) test
{
    SearchResultController *searchVc = [[SearchResultController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void) setUpData
{
    NSString *newsUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,TeacherLive,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"teacherid" : self.teacherid,
                          @"index" : [NSString stringWithFormat:@"%d",self.index],
                          @"count" : @10
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:newsUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             NSArray *models = [HomePageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             if (models.count > 0) {
                 if (self.isMoreData) {
                     [self.datas addObjectsFromArray:models];
                     
                 }else
                 {
                     self.datas = (NSMutableArray *)models;
                 }
             }
             [self.tableView.mj_header endRefreshing];
             [self.tableView.mj_footer endRefreshing];
             
             //没有内容
             if (self.datas.count == 0) {
                 self.tableView.hidden = YES;
                 self.noCommentView.hidden = NO;
             }else
             {
                 self.noCommentView.hidden = YES;
                 self.tableView.hidden = NO;
             }
             
             [self.tableView reloadData];
             
         }
         
     }fail:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
     }];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageModel *model = self.datas[indexPath.row];
    
    static NSString *ID = @"LiveListPastCell";
    LiveListPastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LiveListPastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.delegate = self;
    cell.isFromStudyDetail = YES;
    cell.isFromStudy = YES;
    cell.teacherid = self.teacherid;
    cell.model = model;
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    HomePageModel *model = self.datas[indexPath.row];
    
    NSString *uelStr = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,model.businessid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
    
    MainWebController *vc = [[MainWebController alloc] init];
    vc.url = uelStr;
    vc.webTitle = model.title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)liveButtonClick:(LiveListPastCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    HomePageModel *model = self.datas[indexPath.row];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&liveid=%@",NetHeader,StartLive,[UserInfoTool getUserInfo].token,model.businessid];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        if ([responseDic[@"rescode"] intValue] == 10000) {
            CCLiveModel *liveModel = [CCLiveModel objectWithKeyValues:responseDic[@"data"]];
            
            //CCPush登录
            [[CCPushUtil sharedInstanceWithDelegate:self] loginWithUserId:CCPushUserId RoomId:liveModel.roomid ViewerName:liveModel.roomName ViewerToken:liveModel.publisherPass];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark CCPush登录回调
-(void)requestLoginSucceedWithViewerId:(NSString *)viewerId {
    PrePushViewController *prePushViewController = [[PrePushViewController alloc] init];
    [self.navigationController pushViewController:prePushViewController animated:YES];
}

@end
