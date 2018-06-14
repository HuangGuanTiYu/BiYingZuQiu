//
//  NewTeacherController.m
//  MoveSchool
//
//  Created by edz on 2017/10/12.
//
//

#import "NewTeacherController.h"
#import "AFNetWW.h"
#import "TBCityIconFont.h"
#import "NewTeacherModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "InformationListModel.h"
#import "HomePageModel.h"
#import "InformationListCell.h"
#import "HomePageCell.h"
#import "LiveListPastCell.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "ChatKeyBoard.h"
#import "IQKeyboardManager.h"
#import "MainWebController.h"
#import "NewCourseDetailController.h"
#import "NewTeacherInformationController.h"
#import "NewTeacherCourseController.h"
#import "NewTeacherLiveController.h"
#import "CCLiveModel.h"
#import <CCPush/CCPushUtil.h>
#import "PrePushViewController.h"
#import "NewCourseModel.h"
#import "NewVideoCourseController.h"
#import "CourseBean.h"

typedef enum {
    /** 资讯列表 */
    JumpToInformation,
    /** 课程 */
    JumpToCourse,
    /** 直播 */
    JumpToILive
} JumpType;

#define StatusBar_HEIGHT 20
#define NavigationBar_HEIGHT 44

@interface NewTeacherController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, ChatKeyBoardDelegate, CommentCellDelegate, LiveListPastCellDelegate, CCPushUtilDelegate>

@property(nonatomic,strong)UIView *navigationBackView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *navBarView;

@property (nonatomic, strong) NewTeacherModel *model;

@property (nonatomic, strong) UILabel *summaryLabel;

@property (nonatomic, strong) UIView *summaryView;

@property (nonatomic, strong) UIButton *summaryButton;

@property (nonatomic, strong) UITableView *informationView;

@property (nonatomic, strong) UITableView *courseTableView;

@property (nonatomic, strong) UITableView *liveTableView;

@property (nonatomic, strong) UITableView *problemTableView;

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) NSArray *informationModels;

@property (nonatomic, strong) NSArray *courseModels;

@property (nonatomic, strong) NSArray *liveModels;

@property (nonatomic, strong) NSMutableArray *commentModels;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;

//是否是回复
@property (nonatomic, assign) BOOL isReply;

@property (nonatomic, strong) UIView *maskView;

//点击回复的索引值
@property (nonatomic, assign) int replyIndex;

@end

@implementation NewTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpData];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiddenFrame:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyBoardWillHiddenFrame:(NSNotification *)notification
{
    [self maskViewClick];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc] init];
        _navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    }
    return _navBarView;
}

- (void) setUpData
{
    //讲师信息
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?teacherid=%@&token=%@",NetHeader,TeacherTeacher,self.teacherid,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NewTeacherModel *model = [NewTeacherModel objectWithKeyValues:responseDic[@"data"]];
             self.model = model;
             
             [self setUpUI];

             [self getNews];
         }
         
     }fail:^(NSError *error) {
         
     }];
    
}

- (void) getNews
{
    //资讯
    NSString *newsUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,TeacherNews,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"teacherid" : self.teacherid,
                          @"index" : @0,
                          @"count" : @3
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:newsUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [InformationListModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             self.informationModels = models;
             
             if (models.count > 0) {
                 UITableView *informationView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableHeaderView.frame), self.view.width, 93 * models.count + 54)];
                 informationView.scrollEnabled = NO;
                 informationView.separatorStyle = UITableViewCellSeparatorStyleNone;
                 self.informationView = informationView;
                 informationView.delegate = self;
                 informationView.dataSource = self;
                 [self.scrollView addSubview:informationView];
                 
                 UIView *informationHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
                 UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, informationHeaderView.width, mainSpacing)];
                 sepaView.backgroundColor = ViewBackColor;
                 [informationHeaderView addSubview:sepaView];
                 
                 UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, mainSpacing, informationHeaderView.width, 44)];
                 contentView.tag = JumpToInformation;
                 [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewClick:)]];
                 [informationHeaderView addSubview:contentView];
                 
                 UIImageView *nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(informationHeaderView.width - 30, 0, 15, 15)];
                 nextImage.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", ys_f24, AuxiliaryColor)];
                 nextImage.centerY = contentView.height * 0.5;
                 [contentView addSubview:nextImage];
                 
                 UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, informationHeaderView.width - nextImage.x, contentView.height)];
                 titleLabel.text = @"资讯";
                 titleLabel.textColor = MainTextColor;
                 titleLabel.font = [UIFont systemFontOfSize:ys_28];
                 titleLabel.centerY = contentView.height * 0.5;
                 [contentView addSubview:titleLabel];
                 
                 UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame), informationHeaderView.width, 1)];
                 sepaView2.backgroundColor = ViewBackColor;
                 [informationHeaderView addSubview:sepaView2];
                 
                 informationView.tableHeaderView = informationHeaderView;
                 
                 self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(informationView.frame));
             }
             
             //课程
             [self getCouse];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) getCouse
{

    //课程
    NSString *newsUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,TeacherCourse,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"teacherid" : self.teacherid,
                          @"index" : @0,
                          @"count" : @3
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:newsUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [HomePageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             self.courseModels = models;
             
             if (models.count > 0) {
                 UITableView *informationView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.informationModels.count > 0 ? CGRectGetMaxY(self.informationView.frame) : CGRectGetMaxY(self.tableHeaderView.frame), self.view.width, 107 * models.count + 54)];
                 informationView.scrollEnabled = NO;
                 informationView.separatorStyle = UITableViewCellSeparatorStyleNone;
                 self.courseTableView = informationView;
                 informationView.delegate = self;
                 informationView.dataSource = self;
                 [self.scrollView addSubview:informationView];
                 
                 UIView *informationHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
                 UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, informationHeaderView.width, mainSpacing)];
                 sepaView.backgroundColor = ViewBackColor;
                 [informationHeaderView addSubview:sepaView];
                 
                 UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, mainSpacing, informationHeaderView.width, 44)];
                 contentView.tag = JumpToCourse;
                 [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewClick:)]];
                 [informationHeaderView addSubview:contentView];
                 
                 UIImageView *nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(informationHeaderView.width - 30, 0, 15, 15)];
                 nextImage.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", ys_f24, AuxiliaryColor)];
                 nextImage.centerY = contentView.height * 0.5;
                 [contentView addSubview:nextImage];
                 
                 UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, informationHeaderView.width - nextImage.x, contentView.height)];
                 titleLabel.text = @"课程";
                 titleLabel.textColor = MainTextColor;
                 titleLabel.font = [UIFont systemFontOfSize:ys_28];
                 titleLabel.centerY = contentView.height * 0.5;
                 [contentView addSubview:titleLabel];
                 
                 UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame), informationHeaderView.width, 1)];
                 sepaView2.backgroundColor = ViewBackColor;
                 [informationHeaderView addSubview:sepaView2];
                 
                 informationView.tableHeaderView = informationHeaderView;
                 
                 self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(informationView.frame));

             }
             
             //直播
             [self getLive];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

 - (void) getLive
{

    NSString *newsUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,TeacherLive,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"teacherid" : self.teacherid,
                          @"index" : @0,
                          @"count" : @3
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:newsUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [HomePageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             self.liveModels = models;
             
             if (models.count > 0) {
                 
                 CGFloat informationViewY = CGRectGetMaxY(self.tableHeaderView.frame);
                 
                 if (self.informationModels.count > 0) {
                     informationViewY = CGRectGetMaxY(self.informationView.frame);
                 }
                 
                 if (self.courseModels.count > 0) {
                     informationViewY = CGRectGetMaxY(self.courseTableView.frame);
                 }
                 
                 UITableView *informationView = [[UITableView alloc] initWithFrame:CGRectMake(0, informationViewY, self.view.width, 107 * models.count + 54)];
                 informationView.scrollEnabled = NO;
                 informationView.separatorStyle = UITableViewCellSeparatorStyleNone;
                 self.liveTableView = informationView;
                 informationView.delegate = self;
                 informationView.dataSource = self;
                 [self.scrollView addSubview:informationView];
                 
                 UIView *informationHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
                 UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, informationHeaderView.width, mainSpacing)];
                 sepaView.backgroundColor = ViewBackColor;
                 [informationHeaderView addSubview:sepaView];
                 
                 UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, mainSpacing, informationHeaderView.width, 44)];
                 contentView.tag = JumpToILive;
                 [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewClick:)]];
                 [informationHeaderView addSubview:contentView];
                 
                 UIImageView *nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(informationHeaderView.width - 30, 0, 15, 15)];
                 nextImage.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", ys_f24, AuxiliaryColor)];
                 nextImage.centerY = contentView.height * 0.5;
                 [contentView addSubview:nextImage];
                 
                 UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, informationHeaderView.width - nextImage.x, contentView.height)];
                 titleLabel.text = @"直播";
                 titleLabel.textColor = MainTextColor;
                 titleLabel.font = [UIFont systemFontOfSize:ys_28];
                 titleLabel.centerY = contentView.height * 0.5;
                 [contentView addSubview:titleLabel];
                 
                 UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame), informationHeaderView.width, 1)];
                 sepaView2.backgroundColor = ViewBackColor;
                 [informationHeaderView addSubview:sepaView2];
                 
                 informationView.tableHeaderView = informationHeaderView;
                 
                 self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(informationView.frame));
                 
             }
             
             //获取提问
             [self getProblem];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) getProblem
{

    //获取评论
    NSString *url = [NSString stringWithFormat:@"%@%@?businessid=%@&businesscode=%@&token=%@&count=1000",NetHeader,GetCommentList,self.teacherid,teacherType,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *comments = (NSMutableArray *)[CommentModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             self.commentModels = [NSMutableArray arrayWithArray:comments];

             CGFloat informationViewY = CGRectGetMaxY(self.tableHeaderView.frame);
             
             if (self.informationModels.count > 0) {
                 informationViewY = CGRectGetMaxY(self.informationView.frame);
             }
             
             if (self.courseModels.count > 0) {
                 informationViewY = CGRectGetMaxY(self.courseTableView.frame);
             }
             
             if (self.liveModels.count > 0) {
                 informationViewY = CGRectGetMaxY(self.liveTableView.frame);
             }
             
             UITableView *informationView = [[UITableView alloc] initWithFrame:CGRectMake(0, informationViewY, self.view.width, 0)];
             informationView.scrollEnabled = NO;
             informationView.separatorStyle = UITableViewCellSeparatorStyleNone;
             self.problemTableView = informationView;
             informationView.delegate = self;
             informationView.dataSource = self;
             [self.scrollView addSubview:informationView];
             
             UIView *informationHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
             UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, informationHeaderView.width, mainSpacing)];
             sepaView.backgroundColor = ViewBackColor;
             [informationHeaderView addSubview:sepaView];
             
             UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, mainSpacing, informationHeaderView.width, 44)];
             [informationHeaderView addSubview:contentView];
             
             UIImageView *nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(informationHeaderView.width - 30, 0, 15, 15)];
             nextImage.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", ys_f24, AuxiliaryColor)];
             nextImage.centerY = contentView.height * 0.5;
             [contentView addSubview:nextImage];
             
             UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, informationHeaderView.width - nextImage.x, contentView.height)];
             titleLabel.text = @"问答";
             titleLabel.textColor = MainTextColor;
             titleLabel.font = [UIFont systemFontOfSize:ys_28];
             titleLabel.centerY = contentView.height * 0.5;
             [contentView addSubview:titleLabel];
             
             UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame), informationHeaderView.width, 1)];
             sepaView2.backgroundColor = ViewBackColor;
             [informationHeaderView addSubview:sepaView2];
             
             informationView.tableHeaderView = informationHeaderView;
             
             //我要提问
             UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 144)];
             UIButton *problemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
             [problemButton addTarget:self action:@selector(writeCommentClick) forControlEvents:UIControlEventTouchUpInside];
             problemButton.centerX = footView.width * 0.5;
             problemButton.centerY = footView.height * 0.5;
             [problemButton setTitle:@"我要提问" forState:UIControlStateNormal];
             [problemButton setTitleColor:MainColor forState:UIControlStateNormal];
             problemButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
             problemButton.layer.borderColor = MainColor.CGColor;
             problemButton.layer.borderWidth = 1;
             problemButton.layer.cornerRadius = 2.5;
             problemButton.layer.masksToBounds = YES;
             [footView addSubview:problemButton];
             informationView.tableFooterView = footView;
             
             informationView.height = informationView.contentSize.height;
             
             self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(informationView.frame));
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) setUpUI
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    self.tableHeaderView = tableHeaderView;
    
    UIImageView *bjImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.model.applyjob.length > 0 ? 210 : 190)];
    bjImageView.image = [UIImage imageNamed:@"jiangshi_bg"];
    [tableHeaderView addSubview:bjImageView];
    
    //头像
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 60, 60)];
    headerView.centerX = self.view.width * 0.5;
    headerView.layer.cornerRadius = 30;
    headerView.layer.masksToBounds = YES;
    [headerView sd_setImageWithURL:[NSURL URLWithString:self.model.teacherpic] placeholderImage:[UIImage imageNamed:@"my_touxiang"]];
    [tableHeaderView addSubview:headerView];
    
    //名字
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame) + mainSpacing, self.view.width, 20)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:ys_28];
    nameLabel.text = self.model.nickname;
    [nameLabel sizeToFit];
    nameLabel.centerX = self.view.width * 0.5;
    [tableHeaderView addSubview:nameLabel];
    
    //课程
    UILabel *applyjobLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame) + mainSpacing, self.view.width, 20)];
    applyjobLabel.textColor = [UIColor whiteColor];
    applyjobLabel.font = [UIFont systemFontOfSize:ys_f24];
    if (self.model.applyjob.length > 0) {
        applyjobLabel.text = [NSString stringWithFormat:@"主讲课程：%@",self.model.applyjob];
    }
    [applyjobLabel sizeToFit];
    applyjobLabel.centerX = self.view.width * 0.5;
    [tableHeaderView addSubview:applyjobLabel];
    
    //关注
    UIButton *friendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(applyjobLabel.frame) + mainSpacing, 50, 20)];
    [friendButton addTarget:self action:@selector(friendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    friendButton.centerX = self.view.width * 0.5;
    friendButton.layer.borderColor = [UIColor whiteColor].CGColor;
    friendButton.layer.borderWidth = 1;
    friendButton.layer.cornerRadius = 2.5;
    friendButton.layer.masksToBounds = YES;
    [friendButton setTitle:self.model.friends == 0 ? @"关注" : @"已关注" forState:UIControlStateNormal];
    friendButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [tableHeaderView addSubview:friendButton];
    
    if ([self.userid isEqualToString:[UserInfoTool getUserInfo].zttid]) {
        friendButton.hidden = YES;
        bjImageView.height = bjImageView.height - 30;
    }else
    {
        friendButton.hidden = NO;
    }
    
    //描述View
    UIView *summaryView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bjImageView.frame), self.view.width, 103)];
    self.summaryView = summaryView;
    summaryView.backgroundColor = [UIColor whiteColor];
    
    summaryView.hidden = self.model.summary.length == 0;
    
    CGFloat summayLabelH = [NSString returnStringRect:self.model.summary size:CGSizeMake(summaryView.width - 30, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]].height;
    UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, summaryView.width - 30, summayLabelH > 52 ? 52 : summayLabelH)];
    self.summaryLabel = summaryLabel;
    summaryLabel.textColor = MainTextColor;
    summaryLabel.font = [UIFont systemFontOfSize:ys_28];
    summaryLabel.textColor = MainTextColor;
    summaryLabel.numberOfLines = 0;
    summaryLabel.text = self.model.summary;
    [summaryView addSubview:summaryLabel];
    
    //展开
    UIButton *summaryButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(summaryLabel.frame) + 5, 30, 20)];
    [summaryButton setTitle:@"展开" forState:UIControlStateNormal];
    self.summaryButton = summaryButton;
    [summaryButton addTarget:self action:@selector(summaryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [summaryButton setTitleColor:MainColor forState:UIControlStateNormal];
    summaryButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [summaryView addSubview:summaryButton];
    
    summaryView.height = CGRectGetMaxY(summaryButton.frame) + 15;
    
    if (self.model.summary.length > 0) {
        tableHeaderView.height = CGRectGetMaxY(summaryView.frame);
    }else
    {
        tableHeaderView.height = CGRectGetMaxY(bjImageView.frame);
    }
    
    [tableHeaderView addSubview:summaryView];
    
    [scrollView addSubview:tableHeaderView];
    
    
    // 初始化导航栏
    [self setupNavigationBar];
    
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
    self.chatKeyBoard.delegate = self;
    [self.chatKeyBoard.chatToolBar.faceBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.chatKeyBoard.chatToolBar.faceBtn.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [self.chatKeyBoard.chatToolBar.faceBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    self.chatKeyBoard.y = self.chatKeyBoard.y + 20;
    self.chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
    self.chatKeyBoard.allowVoice = NO;
    self.chatKeyBoard.allowMore = NO;
    self.chatKeyBoard.allowSwitchBar = NO;
    self.chatKeyBoard.backgroundColor = [UIColor whiteColor];
    self.chatKeyBoard.chatToolBar.textView.backgroundColor = ViewBackColor;
    self.chatKeyBoard.chatToolBar.textView.textColor = MainTextColor;
    self.chatKeyBoard.chatToolBar.textView.layer.borderColor = [UIColor clearColor].CGColor;
    self.chatKeyBoard.placeHolder = @"写评论...";
    
    [self.view addSubview:self.chatKeyBoard];
}

#pragma mark -初始化导航栏
- (void)setupNavigationBar {
    
    // 导航栏背景view
    _navigationBackView = [[UIView alloc] init];
    _navigationBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, StatusBar_HEIGHT + NavigationBar_HEIGHT);
    [self.view addSubview:_navigationBackView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:_navigationBackView.bounds];
    titleLabel.alpha = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:ys_f36];
    titleLabel.width = _navigationBackView.width * 0.6;
    titleLabel.centerX = _navigationBackView.width * 0.5;
    titleLabel.centerY = (_navigationBackView.height + 20) * 0.5;
    titleLabel.text = self.model.nickname;
    [_navigationBackView addSubview:titleLabel];
    
    //返回按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e807", 18, [UIColor whiteColor])] forState:UIControlStateNormal];
    rightButton.size = CGSizeMake(25, 25);
    [rightButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    rightButton.centerY = titleLabel.centerY;
    rightButton.x = 15;
    [_navigationBackView addSubview:rightButton];
}

- (void) back
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void) summaryButtonClick : (UIButton *) button
{

    if ([button.titleLabel.text isEqualToString:@"展开"]) {
        [self.summaryButton setTitle:@"收起" forState:UIControlStateNormal];
        
        CGFloat summaryHeight = [NSString returnStringRect:self.model.summary size:CGSizeMake(self.summaryLabel.width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]].height;
        self.summaryLabel.height = summaryHeight;
    }else
    {
        
        [self.summaryButton setTitle:@"展开" forState:UIControlStateNormal];
        
        CGFloat summayLabelH = [NSString returnStringRect:self.model.summary size:CGSizeMake(self.summaryView.width - 30, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]].height;

        self.summaryLabel.height = summayLabelH > 52 ? 52 : summayLabelH;
    }
    
    self.summaryButton.y = CGRectGetMaxY(self.summaryLabel.frame) + 5;
    
    self.summaryView.height = CGRectGetMaxY(self.summaryButton.frame) + 15;
    
    self.tableHeaderView.height = CGRectGetMaxY(self.summaryView.frame);
    
    if (self.informationView != nil) {
        self.informationView.y = CGRectGetMaxY(self.tableHeaderView.frame);
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.informationView.frame));
    }
    
    if (self.courseTableView != nil) {
        self.courseTableView.y = self.informationModels.count > 0 ? CGRectGetMaxY(self.informationView.frame) : CGRectGetMaxY(self.tableHeaderView.frame);
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.courseTableView.frame));
    }
    
    if (self.liveTableView != nil) {
        
        
        CGFloat informationViewY = CGRectGetMaxY(self.tableHeaderView.frame);
        
        if (self.informationModels.count > 0) {
            informationViewY = CGRectGetMaxY(self.informationView.frame);
        }
        
        if (self.courseModels.count > 0) {
            informationViewY = CGRectGetMaxY(self.courseTableView.frame);
        }
        
        self.liveTableView.y = informationViewY;
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.liveTableView.frame));
    }
    
    if (self.problemTableView != nil) {
        CGFloat informationViewY = CGRectGetMaxY(self.tableHeaderView.frame);
        
        if (self.informationModels.count > 0) {
            informationViewY = CGRectGetMaxY(self.informationView.frame);
        }
        
        if (self.courseModels.count > 0) {
            informationViewY = CGRectGetMaxY(self.courseTableView.frame);
        }
        
        if (self.liveModels.count > 0) {
            informationViewY = CGRectGetMaxY(self.liveTableView.frame);
        }
        
        self.problemTableView.y = informationViewY;
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.problemTableView.frame));

    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.informationView) {
        return self.informationModels.count;
    }else if(tableView == self.courseTableView)
    {
        return self.courseModels.count;
    }else if(tableView == self.liveTableView)
    {
        return self.liveModels.count;
    }else if(tableView == self.problemTableView)
    {
        return self.commentModels.count;
    }
    
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.informationView) {
        static NSString *ID = @"InformationListCell";
        InformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[InformationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        InformationListModel *model = self.informationModels[indexPath.row];
        cell.model = model;
        
        if (indexPath.row == self.informationModels.count - 1) {
            cell.sepaView.hidden = YES;
        }else
        {
            cell.sepaView.hidden = NO;
        }
        
        return cell;
    }else if(tableView == self.courseTableView)
    {
        static NSString *ID = @"HomePageCell";
        HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[HomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isCourse = YES;
        HomePageModel *model = self.courseModels[indexPath.row];
        cell.model = model;
        
        if (indexPath.row == self.courseModels.count - 1) {
            cell.sepaView.hidden = YES;
        }else
        {
            cell.sepaView.hidden = NO;
        }
        return cell;
    }else if(tableView == self.liveTableView)
    {
        HomePageModel *model = self.liveModels[indexPath.row];

        static NSString *ID = @"LiveCell";
        LiveListPastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[LiveListPastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.delegate = self;
        cell.isFromStudyDetail = YES;
        cell.isFromStudy = YES;
        cell.teacherid = self.teacherid;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        if (indexPath.row == self.liveModels.count - 1) {
            cell.sepaView.hidden = YES;
        }else
        {
            cell.sepaView.hidden = NO;
        }
        return cell;
    }else if(tableView == self.problemTableView)
    {
        static NSString *ID = @"CommentCell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        CommentModel *model = self.commentModels[indexPath.row];
        cell.model = model;
        
        return cell;
    }
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.informationView) {
        return 93;
    }else if(tableView == self.courseTableView || tableView == self.liveTableView)
    {
        return 107;
    }else if(tableView == self.problemTableView)
    {
        CommentModel *model = self.commentModels[indexPath.row];
        if (model.touserid > 0) { //有回复
            if ([model.userid isEqualToString:[UserInfoTool getUserInfo].zttid]) { //自己评论的 有删除
                return model.contentHeight + 51 + 50 + 20 + mainSpacing;
            }else
            {
                return model.contentHeight + 51 + 50;
            }
        }else
        {
            if ([model.userid isEqualToString:[UserInfoTool getUserInfo].zttid]) { //自己评论的 有删除
                return model.contentHeight + 51 + 20 + mainSpacing;
            }else
            {
                return model.contentHeight + 51;
            }
        }
    }
    
    return 0;
}

#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y)/300.0f;
    
    self.navigationBackView.backgroundColor = [MainColor colorWithAlphaComponent:alpha];
    self.titleLabel.alpha = alpha;
}

#pragma mark 写评论点击
- (void) writeCommentClick
{
    
    self.chatKeyBoard.placeHolder = @"我要提问...";
    
    self.isReply = NO;
    UIView *maskView = [[UIView alloc] initLineWithFrame:self.view.bounds];
    [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick)]];
    self.maskView = maskView;
    maskView.alpha = 0.5;
    maskView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskView];
    
    [self.view bringSubviewToFront:self.chatKeyBoard];
    
    [self.chatKeyBoard keyboardUpforComment];
}

- (void) maskViewClick
{
    self.chatKeyBoard.chatToolBar.textView.text = @"";
    
    [self.chatKeyBoard keyboardDownForComment];
    if (self.maskView != nil) {
        [self.maskView removeFromSuperview];
    }
}

#pragma mark 发送评论
- (void) sendComment
{
    [self maskViewClick];
    [self sendCommentWithText:self.chatKeyBoard.chatToolBar.textView.text];
}

#pragma mark 发送评论
- (void) sendCommentWithText : (NSString *) text
{
 
    NSDictionary *dic=@{
                        @"businessid" : self.userid,
                        @"businesscode" : teacherType,
                        @"toid" : @"0",
                        @"content" : text
                        };
    
    if (self.isProxy && self.courseModels.count > 0) {
        CommentModel *model = self.commentModels[self.replyIndex];
        
        dic=@{
              @"businessid" : self.userid,
              @"businesscode" : teacherType,
              @"toid" : model.ID,
              @"content" : text
              };
    }

    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CommentAdd,[UserInfoTool getUserInfo].token];
    
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"提问成功"];
            
            self.chatKeyBoard.chatToolBar.textView.text = @"";
            
            CommentModel *model = [CommentModel objectWithKeyValues:responseDic[@"data"]];
            [self.commentModels insertObject:model atIndex:0];
            
            //刷新评论列表
            [self.problemTableView reloadData];
        
            self.problemTableView.height = self.problemTableView.contentSize.height;
            
            self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.problemTableView.frame));
            
        }else if(rescode != 20002)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:responseDic[@"msg"]];
            });
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void) friendButtonClick : (UIButton *) button
{

    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,TeacherFocus,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"teacherid" : self.userid
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000)
         {
             int firend = [responseDic[@"data"][@"firend"] intValue]; //0未关注，1关注
             [button setTitle:firend == 0 ? @"关注" : @"已关注" forState:UIControlStateNormal];

         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (tableView == self.informationView) {
        
        InformationListModel *model = self.informationModels[indexPath.row];
        MainWebController *webVc = [[MainWebController alloc] init];
        webVc.webTitle = @"资讯详情";
        webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",NetHeader,NewsDetail,model.ID];
        [self.navigationController pushViewController:webVc animated:YES];
    }else if(tableView == self.courseTableView)
    {
        HomePageModel *model = self.courseModels[indexPath.row];

        //根据format判断是课程 还是 音频课程
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&courseid=%@&token=%@",NetHeader,GetCoursesDetail,model.businessid,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 
                 NewCourseModel *model = [NewCourseModel objectWithKeyValues:responseDic[@"data"]];
                 if (model.courseBean.format != 3) {
                     NewCourseDetailController *newCourseVc = [[NewCourseDetailController alloc] init];
                     newCourseVc.courseid = model.courseBean.mainid;
                     [self.navigationController pushViewController:newCourseVc animated:YES];
                 }else
                 {
                     NewVideoCourseController *newCourseVc = [[NewVideoCourseController alloc] init];
                     newCourseVc.courseid = model.courseBean.mainid;
                     [self.navigationController pushViewController:newCourseVc animated:YES];
                 }
             }else
             {
                 [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
             }
             
         }fail:^(NSError *error) {
             [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
         }];
    }else if(tableView == self.liveTableView)
    {
    
        HomePageModel *model = self.liveModels[indexPath.row];
        
        NSString *uelStr = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,model.businessid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
        
        MainWebController *vc = [[MainWebController alloc] init];
        vc.url = uelStr;
        vc.webTitle = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(tableView == self.problemTableView)
    {
        //回复评论
        [self writeCommentClick];
        
        self.replyIndex = (int)indexPath.row;

        CommentModel *model = self.commentModels[indexPath.row];
        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复%@",model.nickname];
        
        self.isReply = YES;
    }
}

- (void) chatKeyBoardSendText:(NSString *)text
{
    [self maskViewClick];
    [self sendCommentWithText:text];
}

- (void)goodButtonClick:(CommentCell *)cell
{
    
    NSIndexPath *indexPath = [self.problemTableView indexPathForCell:cell];
    CommentModel *model = self.commentModels[indexPath.row];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,PraiseAdd,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"businessid" : model.ID,
                          @"businesscode" : teacherQuestionType
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            
            if ([responseDic[@"data"][@"err"] intValue] == 0) {// 1取消点赞 0点赞成功
                [cell.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62d", 15, MainColor)] forState:UIControlStateNormal];
                [cell.goodButton setTitleColor:MainColor forState:UIControlStateNormal];

            }else
            {
                [cell.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", 15, AuxiliaryColor)] forState:UIControlStateNormal];
                [cell.goodButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
            }
            
            [cell.goodButton setTitle:responseDic[@"data"][@"num"] forState:UIControlStateNormal];
            
        }else if(code != 20002)
        {
            [MBProgressHUD showError:@"网络错误"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
    
}

- (void) contentViewClick : (UIGestureRecognizer *) gestureRecognizer
{

    UIView *view = gestureRecognizer.view;
    if (view.tag == JumpToInformation) {
        NewTeacherInformationController *informationController = [[NewTeacherInformationController alloc] init];
        informationController.teacherid = self.teacherid;
        informationController.nickname = self.nickname;
        [self.navigationController pushViewController:informationController animated:YES];
    }else if(view.tag == JumpToCourse)
    {
        NewTeacherCourseController *informationController = [[NewTeacherCourseController alloc] init];
        informationController.teacherid = self.teacherid;
        informationController.nickname = self.nickname;
        [self.navigationController pushViewController:informationController animated:YES];
        
    }else if(view.tag == JumpToILive)
    {
        NewTeacherLiveController *informationController = [[NewTeacherLiveController alloc] init];
        informationController.teacherid = self.teacherid;
        informationController.nickname = self.nickname;
        [self.navigationController pushViewController:informationController animated:YES];
    
    }
}

- (void)liveButtonClick:(LiveListPastCell *)cell
{
    NSIndexPath *indexPath = [self.liveTableView indexPathForCell:cell];
    HomePageModel *model = self.liveModels[indexPath.row];

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

- (void)deleteComment:(CommentCell *)cell
{

    NSIndexPath *indexPath = [self.commentTableView indexPathForCell:cell];
    CommentModel *model = self.commentModels[indexPath.row];
    NSDictionary *dic=@{
                        @"id" : model.ID
                        };
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CommentDel,[UserInfoTool getUserInfo].token];
    
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"删除成功"];
            [self.commentModels removeObject:model];
            
            //刷新评论列表
            [self.problemTableView reloadData];
            
            self.problemTableView.height = self.problemTableView.contentSize.height;
            
            self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.problemTableView.frame));
            
        }else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:responseDic[@"msg"]];
            });
        }
    } fail:^(NSError *error) {
        
    }];
}

@end
