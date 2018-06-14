//
//  MineController.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/18.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "MineController.h"
#import "TBCityIconFont.h"
#import "MineCell.h"
#import "MainNavigationController.h"
#import "NewLoginController.h"
#import "AFNetWW.h"
#import "MineModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "MineUser.h"
#import "MenusModel.h"
#import "MenusSubModel.h"
#import "UIImage+Extension.h"
#import "MyMessageController.h"
#import "NewMyStudyController.h"
#import "MenusModelTool.h"
#import "MyTestController.h"
#import "MyQuestionnaireController.h"
#import "CollectionController.h"
#import "MyFollowController.h"
#import "ApplyTeacherController.h"
#import "NewMyTeacherController.h"
#import "MyCustomizedController.h"
#import "MyFansController.h"
#import "SettingController.h"
#import "MainWebController.h"
#import "MineDataController.h"
#import "MyDownLoadsViewController.h"
#import "H5CourseController.h"
#import "AppDelegate.h"
#import "NewTeacherController.h"
#import "MianTabBarController.h"
#import "MyZiXunController.h"
#import "NewH5CourseController.h"
#import "MyShaLongController.h"
#import "MyZhuanTiController.h"

@interface MineController ()<UITableViewDataSource, UITableViewDelegate, SettingControllerDelegate>

//图标数组
@property (nonatomic, strong) NSString *images;

//头像
@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *lvLabel;

@property (nonatomic, strong) UIButton *profit;

@property (nonatomic, strong) UIButton *order;

//签到
@property (nonatomic, strong) UIButton *signButton;

//描述
@property (nonatomic, strong) UILabel *subTitleLabel;

//菜单标题列表
@property (nonatomic, strong) NSMutableArray *menusArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *titleLvView;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    //拉取我的信息
    [self getMyMessage];
    
    [self setUpData];

}

- (void) setToolBar : (NSArray *) menus
{
    for (MenusModel *model in menus) {

        if (model.ID == MyModular) { //我的
            
            MenusSubModel *subModel = [model.subs firstObject];
            self.profit.tag = subModel.ID;
            
            if (subModel.ID == MyCoin) { //积分
                NSString *allString = [NSString stringWithFormat:@"%@ %d",subModel.title,[UserInfoTool getUserInfo].coin];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].coin]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",subModel.title]]];
                
                [self.profit setAttributedTitle:string forState:UIControlStateNormal];
                
            }else if(subModel.ID == MyCert) //证书
            {
                NSString *allString = [NSString stringWithFormat:@"%@ %d",subModel.title,[UserInfoTool getUserInfo].cert];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].cert]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",subModel.title]]];
                
                [self.profit setAttributedTitle:string forState:UIControlStateNormal];
                
            }else
            {
                [self.profit setTitle:subModel.title forState:UIControlStateNormal];
                
                if (subModel.icon.length > 0) {
                    NSString * iconStr = [NSString stringWithFormat:@"0x%@",subModel.icon];
                    unichar icon = strtoul([iconStr UTF8String],0, 16);
                    NSString *name = [NSString stringWithCharacters:&icon length:1];
                    [self.profit setImage:[UIImage iconWithInfo:TBCityIconInfoMake(name, 16, MainTextColor)] forState:UIControlStateNormal];
                }else
                {
                    [self.profit setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
            
            MenusSubModel *orderModel = [model.subs objectAtIndex:1];
            self.order.tag = orderModel.ID;
            
            if (orderModel.ID == MyCoin) { //积分
                NSString *allString = [NSString stringWithFormat:@"%@ %d",orderModel.title,[UserInfoTool getUserInfo].coin];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].coin]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",orderModel.title]]];
                
                [self.order setAttributedTitle:string forState:UIControlStateNormal];                
            }else if(orderModel.ID == MyCert) //证书
            {
                NSString *allString = [NSString stringWithFormat:@"%@ %d",orderModel.title,[UserInfoTool getUserInfo].cert];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].cert]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",orderModel.title]]];
                [self.order setAttributedTitle:string forState:UIControlStateNormal];
                
            }else
            {
                [self.order setTitle:orderModel.title forState:UIControlStateNormal];
                
                if (orderModel.icon.length > 0) {
                    NSString * iconStr = [NSString stringWithFormat:@"0x%@",orderModel.icon];
                    unichar icon = strtoul([iconStr UTF8String],0, 16);
                    NSString *name = [NSString stringWithCharacters:&icon length:1];
                    [self.order setImage:[UIImage iconWithInfo:TBCityIconInfoMake(name, 16, MainTextColor)] forState:UIControlStateNormal];
                }else
                {
                    [self.profit setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
    }
}

#pragma mark 拉取我的信息
- (void) getMyMessage
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMy,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             MineModel *model = [MineModel objectWithKeyValues:responseDic[@"data"]];
             [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.user.headpic_path] placeholderImage:[UIImage imageNamed:@"my_touxiang"]];
             
             UserInfo *userInfo = [UserInfo objectWithKeyValues:responseDic[@"data"][@"user"]];
             userInfo.token = [UserInfoTool getUserInfo].token;
             [UserInfoTool saveUserInfo:userInfo];
             
             self.titleLabel.text = model.user.nickname;
             [self.titleLabel sizeToFit];

             self.lvLabel.text = [NSString stringWithFormat:@"LV%@",model.user.lv];
             self.lvLabel.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
             self.lvLabel.width = [NSString returnStringRect:self.lvLabel.text size:CGSizeMake(self.lvLabel.width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width + mainSpacing;
             self.lvLabel.centerY = self.titleLabel.centerY;
             
             self.titleLvView.width = CGRectGetMaxX(self.lvLabel.frame) - self.titleLabel.x;;
             self.titleLvView.centerX = self.view.width * 0.5;
             
             self.signButton.selected = [model.sign isEqualToString:@"2"];
             
             if (model.user.position.length > 0) {
                 self.subTitleLabel.text = model.user.position;
                 self.subTitleLabel.hidden = NO;
             }else
             {
                 self.subTitleLabel.hidden = YES;
             }

             NSArray *menus = [MenusModelTool menus];
             if (menus.count == 0) {
                 return;
             }
             
             [self setToolBar:menus];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) setUpUI
{
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIView *headerView = [self createHeaderView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = ViewBackColor;
    tableView.height = self.view.height - 49;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void) setUpData
{

    
    NSMutableArray *menusArray = [NSMutableArray array];
    MenusSubModel *m0 = [[MenusSubModel alloc] init];
    m0.title = @"我的消息";
    m0.icon = @"e626";
    [menusArray addObject:m0];
    
    MenusSubModel *m1 = [[MenusSubModel alloc] init];
    m1.title = @"我的资讯";
    m1.icon = @"e65b";
    [menusArray addObject:m1];
    
    MenusSubModel *m2 = [[MenusSubModel alloc] init];
    m2.title = @"我的沙龙";
    m2.icon = @"e643";
    [menusArray addObject:m2];
    
    MenusSubModel *m3 = [[MenusSubModel alloc] init];
    m3.title = @"我的专题";
    m3.icon = @"e808";
    [menusArray addObject:m3];
    
    
    MenusSubModel *m4 = [[MenusSubModel alloc] init];
    m4.title = @"我的定制";
    m4.icon = @"e656";
    [menusArray addObject:m4];
    
    MenusSubModel *m5 = [[MenusSubModel alloc] init];
    m5.title = @"设置";
    m5.icon = @"e654";
    [menusArray addObject:m5];
    
    self.menusArray = menusArray;
    [self.tableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menusArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenusSubModel *subModel = self.menusArray[indexPath.row];
    
    static NSString *ID = @"MineCell";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.title = subModel.title;
    NSString * iconStr = [NSString stringWithFormat:@"0x%@",subModel.icon];
    unichar icon = strtoul([iconStr UTF8String],0, 16);
    NSString *name = [NSString stringWithCharacters:&icon length:1];
    cell.iconText = name;
    
    //我的消息 并且有 消息 显示NEW
    if (subModel.ID == MyMessage) {
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,HomeGetMsgRecordCount,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 
                 int count = [responseDic[@"data"][@"count"] intValue];
                 if (count > 0) {
                     cell.newsLabel.hidden = NO;
                 }else
                 {
                     cell.newsLabel.hidden = YES;
                 }
             }
             
         }fail:^(NSError *error) {
             
         }];
    }else
    {
        cell.newsLabel.hidden = YES;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark 登录
- (void) login
{
    if ([UserInfoTool getUserInfo].token.length > 0) {
        MineDataController *mineDataVc = [[MineDataController alloc] init];
        [self.navigationController pushViewController:mineDataVc animated:YES];
        return;
    }
    
    MainNavigationController *mainVc = [[MainNavigationController alloc] initWithRootViewController:[[NewLoginController alloc] init]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mainVc animated:YES completion:nil];
}

#pragma mark 签到
- (void) signButtonClick : (UIButton *) button
{
    
    if ([UserInfoTool getUserInfo].token.length == 0) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate alertViewLogin];
        return;
    }
    
    //未签到
    if (!button.selected) {
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyCheckin,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 [MBProgressHUD showText:responseDic[@"msg"] inview:[[UIApplication sharedApplication].windows lastObject]];

                 button.selected = YES;
                 
                 //获取我的信息
                 NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMy,[UserInfoTool getUserInfo].token];
                 
                 [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
                  {
                      if ([responseDic[@"rescode"] intValue] == 10000) {
                          
                          MineModel *model = [MineModel objectWithKeyValues:responseDic[@"data"]];
                          [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.user.headpic_path] placeholderImage:[UIImage imageNamed:@"my_touxiang"]];
                          
                          UserInfo *userInfo = [UserInfo objectWithKeyValues:responseDic[@"data"][@"user"]];
                          userInfo.token = [UserInfoTool getUserInfo].token;
                          [UserInfoTool saveUserInfo:userInfo];
                          
                      }
                      
                  }fail:^(NSError *error) {
                      
                  }];
             }
             
         }fail:^(NSError *error) {
             
         }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    switch (indexPath.row) {
        //我的消息
        case 0:
        {
            MyMessageController *set = [[MyMessageController alloc] init];
            MenusSubModel *m0 = [[MenusSubModel alloc] init];
            m0.ID = MessageNotice;
            m0.title = @"通知";
            
            MenusSubModel *m1 = [[MenusSubModel alloc] init];
            m1.title = @"互动";
            m1.ID = MessageInteraction;

            set.subs = @[m0,m1];
            
            [self.navigationController pushViewController:set animated:YES];
            break;
        }
        //我的学习
        case 1:
        {
            MyZiXunController *set = [[MyZiXunController alloc] init];
            [self.navigationController pushViewController:set animated:YES];
            break;
        }
        //我的关注
        case 2:
        {
            MyShaLongController *set = [[MyShaLongController alloc] init];
            [self.navigationController pushViewController:set animated:YES];
            break;
        }
            
        //我的考试
        case 3:
        {
            MyZhuanTiController *testVc = [[MyZhuanTiController alloc] init];
            [self.navigationController pushViewController:testVc animated:YES];
            break;
        }
            
        //我的问卷
        case 4:
        {
            MyCustomizedController *teacherVc = [[MyCustomizedController alloc] init];
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //我的收藏
        case 5:
        {
            SettingController *teacherVc = [[SettingController alloc] init];
            teacherVc.delegate = self;
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
         
        //我是讲师
        case MyTeacher:
        {
            NSString *likeUrl = [NSString stringWithFormat:@"%@%@",NetHeader,TeacherStatus];
            
            NSDictionary *dic = @{@"userid":[UserInfoTool getUserInfo].ID,@"token" : [UserInfoTool getUserInfo].token};
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
             {
                 if ([responseDic[@"rescode"] intValue] == 10000) {
                     
                     int teacher = [responseDic[@"data"][@"teacher"] intValue];
                     
                     if(teacher == 1)
                     {
                         
                         NewTeacherController *newTeacherVc = [[NewTeacherController alloc] init];
                         newTeacherVc.teacherid = [UserInfoTool getUserInfo].ID;
                         newTeacherVc.nickname = [UserInfoTool getUserInfo].username;
                         newTeacherVc.userid = [UserInfoTool getUserInfo].ID;
                         [self.navigationController pushViewController:newTeacherVc animated:YES];
                     }else
                     {
                         NewMyTeacherController *teacherVc = [[NewMyTeacherController alloc] init];
                         [self.navigationController pushViewController:teacherVc animated:YES];
                     }
                 }
                 
             }fail:^(NSError *error) {
                 
             }];
            break;
        }
            
        //我的定制
        case MyCustomized:
        {
            MyCustomizedController *teacherVc = [[MyCustomizedController alloc] init];
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //我的定制
        case MyFans:
        {
            MyFansController *teacherVc = [[MyFansController alloc] init];
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //设置
        case Setting:
        {
            SettingController *teacherVc = [[SettingController alloc] init];
            teacherVc.delegate = self;
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //推广大使
        case MyExtension:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyExtensionUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"推广大使";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //我的下载
        case MyDownLoad:
        {
            MyDownLoadsViewController *vc = [[MyDownLoadsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //我的课件
        case MyCourse:
        {
            NewH5CourseController *h5CourseVc = [[NewH5CourseController alloc] init];
            [self.navigationController pushViewController:h5CourseVc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void) profitClick : (UIButton *) button
{

    switch (button.tag) {
        //积分
        case MyCoin:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyIntegral,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"我的积分";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //证书
        case MyCert:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyCertUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.backWebPage = YES;
            vc.url = uelStr;
            vc.webTitle = @"我的证书";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
          
        //订单
        case MyOrder:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyOrderUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"我的订单";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //收益
        case MyProfit:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyProfitUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"我的收益";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void)logoutClick
{

    UIView *headerView = [self createHeaderView];
    
    self.tableView.tableHeaderView = headerView;
    
}

- (UIView *) createHeaderView
{
    //tableview的 headerview
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 167 + 10)];
    
    UIView *meesageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 167)];
    
    //背景图
    UIImageView *headerBackView = [[UIImageView alloc] initWithFrame:meesageView.bounds];
    headerBackView.image = [UIImage imageNamed:@"mine_bg"];
    [meesageView addSubview:headerBackView];
    
    //头像
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 71, 71)];
    self.iconView = iconView;
    iconView.image = [UIImage imageNamed:@"my_touxiang"];
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    iconView.layer.borderWidth = 2;
    [iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)]];
    iconView.userInteractionEnabled = YES;
    iconView.layer.cornerRadius = iconView.width * 0.5;
    iconView.layer.masksToBounds = YES;
    iconView.centerX = meesageView.width * 0.5;
    iconView.centerY = meesageView.height * 0.5 - 10;
    [meesageView addSubview:iconView];
    
    //标题 + 等级
    UIView *titleLvView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame) + 5, meesageView.width, 20)];
    self.titleLvView = titleLvView;
    [meesageView addSubview:titleLvView];
    
    //标题文本
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLvView.bounds];
    self.titleLabel = titleLabel;
    titleLabel.height = 20;
    [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)]];
    titleLabel.text = @"登录";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:ys_28];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLvView addSubview:titleLabel];
    
    //等级
    UILabel *lvLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, 0, 100, 10)];
    lvLabel.layer.cornerRadius = fillet;
    lvLabel.layer.masksToBounds = YES;
    self.lvLabel = lvLabel;
    lvLabel.height = 14;
    lvLabel.textAlignment = NSTextAlignmentCenter;
    lvLabel.centerY = titleLabel.centerY;
    lvLabel.textColor = [UIColor whiteColor];
    lvLabel.font = [UIFont systemFontOfSize:ys_f24];
    lvLabel.backgroundColor = RGBCOLOR(255,174,0);
    [titleLvView addSubview:lvLabel];
    
    //副标题文本
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLvView.frame), meesageView.width, 20)];
    self.subTitleLabel = subTitleLabel;
    subTitleLabel.text = @"登录后可享受更多功能";
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = [UIFont systemFontOfSize:ys_f24];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [meesageView addSubview:subTitleLabel];
    
    //签到
    UIButton *signButton = [[UIButton alloc] initWithFrame:CGRectMake(meesageView.width - 57 -15, iconView.y, 57, 20)];
    self.signButton = signButton;
    [self.signButton addTarget:self action:@selector(signButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    signButton.layer.cornerRadius = signButton.height * 0.5;
    signButton.layer.masksToBounds = YES;
    [signButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [signButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [signButton setTitle:@"未签到" forState:UIControlStateNormal];
    [signButton setTitle:@"已签到" forState:UIControlStateSelected];
    signButton.titleLabel.font = [UIFont systemFontOfSize:ys_22];
    [signButton setTitleColor:MainColor forState:UIControlStateNormal];
    [meesageView addSubview:signButton];
    
    //工具条
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(meesageView.frame), headerView.width, 45)];
    toolView.backgroundColor = [UIColor whiteColor];
//    [headerView addSubview:toolView];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 13)];
    sepaView.backgroundColor = MainTextColor;
    sepaView.centerX = toolView.width * 0.5;
    sepaView.centerY = toolView.height * 0.5;
    [toolView addSubview:sepaView];
    
    //收益
    UIButton *profit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, toolView.width * 0.5, toolView.height)];
    self.profit = profit;
    [profit addTarget:self action:@selector(profitClick:) forControlEvents:UIControlEventTouchUpInside];
    profit.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [profit setTitle:@"收益" forState:UIControlStateNormal];
    profit.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
//    [toolView addSubview:profit];
    
    //订单
    UIButton *order = [[UIButton alloc] initWithFrame:CGRectMake(toolView.width * 0.5, 0, toolView.width * 0.5, toolView.height)];
    self.order = order;
    [order addTarget:self action:@selector(profitClick:) forControlEvents:UIControlEventTouchUpInside];
    order.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [order setTitle:@"订单" forState:UIControlStateNormal];
    order.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
    
//    [toolView addSubview:order];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(meesageView.frame), self.view.width, mainSpacing)];
    view.backgroundColor = ViewBackColor;
    [meesageView addSubview:view];
    
    [headerView addSubview:meesageView];
    
    return headerView;
}

@end
