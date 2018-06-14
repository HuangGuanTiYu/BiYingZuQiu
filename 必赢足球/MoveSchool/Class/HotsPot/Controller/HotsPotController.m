//
//  HotsPotController.m
//  MoveSchool
//
//  Created by edz on 2017/4/19.
//
//  热点

#import "HotsPotController.h"
#import "CalendarViewController.h"
#import "AHReach.h"
#import "MBProgressHUD.h"
#import "AFNetWW.h"
#import "HotPointModel.h"
#import "MJExtension.h"
#import "YSLDraggableCardContainer.h"
#import "HotPointView.h"
#import "RecommedModel.h"
#import "AboutMessageModel.h"
#import "AppDelegate.h"
#import "FriendModel.h"
#import "MainWebController.h"
#import "CourseSpecialDetailViewController.h"
#import "CourseDetailArrayModel.h"
#import "CourseDetailModel.h"
#import "CourseDetailController.h"
#import "FriendInfoShowHotViewController.h"

@interface HotsPotController ()<CalendarViewControllerDelegate,YSLDraggableCardContainerDelegate, YSLDraggableCardContainerDataSource, iconClickAndRecommedListDelegate>

@property(nonatomic,strong)NSDate *ClickDate;

@property(nonatomic,strong)UILabel * timeLable;

@property(nonatomic,strong)NSMutableArray *VCModelArr;

@property (nonatomic, strong) NSDate *lastedData;

@property(nonatomic,copy)NSString  *LTime;

@property (nonatomic, strong) YSLDraggableCardContainer *container;

@end

@implementation HotsPotController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title=[ManyLanguageMag gethotStrWith:@"热点"];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"timeChoice" target:self selector:@selector(timeChoice)];
    
    //判断网络状态
    [self netReach];
    
    //收到推送刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreheing) name:@"HAVEPUSH" object:nil];
    
    [self setTimeLa];
    
    if (self.VCModelArr.count == 0) {
        [self netWork];
    }
    
    [self setupBgView];
    
}

#pragma mark 设置背景
-(void)setupBgView{
    //设置背景
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 43)];
    imageview.image=[UIImage imageNamed:@"hot_bg"];
    [self.view addSubview:imageview];
    self.view.backgroundColor=[UIColor whiteColor];
}

/**
 *  得到热点详细信息(最新)
 */
- (void) netWork{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,HotDetail,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSArray *rows = responseDic[@"rows"];
        
        self.VCModelArr = (NSMutableArray *)[HotPointModel objectArrayWithKeyValuesArray:rows];
        
        [self setSlide];
        
        //设置日期标签
        if(self.VCModelArr.count!=0){
            HotPointModel *model = self.VCModelArr[0];  
            NSDate *date = [NSDate dateFromString:model.indate withFormat:@"YYYY-MM-dd"];
            self.lastedData = date;
            self.timeLable.text =  model.indate;
            self.LTime = model.indate;
        }else{
            NSDate *date = [NSDate date];
            self.LTime=[date stringWithFormat:@"YYYY-MM-dd"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
    
}

/**
 *  重新建立所有的视图
 *  @param modelArr 数据模型
 */
#pragma mark 重新建立所有的视图
-(void)setChildVcWithModelArr:(NSArray *)modelArr{
    self.VCModelArr = (NSMutableArray *)modelArr;
    [self setupBgView];//设置背景视图
    [self setSlide];//设置子视图
    
}

#pragma mark 选择时间
- (void) timeChoice
{
    
    CalendarViewController *vc=[[CalendarViewController alloc]init];
    vc.delegate = self;
    [self presentViewController:vc animated:1 completion:nil];
}

#pragma mark canlendarDelEgate
/**
 *  点击事件代理
 *
 *  @param arr 数据源arr
 */
-(void)passAmodelArr:(NSArray *)arr{
    [self.view removeAllSubviews];
    [self setChildVcWithModelArr:arr];
}

/**
 *  点击事件代理
 *
 *  @param date 日期
 */
-(void)passClickDateWith:(NSDate *)date{
    self.ClickDate = date;
}

/**
 *  网络状态监控
 */
#pragma mark 网络状态监控
-(void)netReach{
    AHReach *defaultHostReach = [AHReach reachForDefaultHost];
    [defaultHostReach startUpdatingWithBlock:^(AHReach *reach) {
        if([reach isReachableViaWWAN]){
            [MBProgressHUD showText:@"当前为移动蜂窝数据" inview:[[UIApplication sharedApplication].windows lastObject]];
        }
        else if ([reach isReachableViaWiFi]){
            [MBProgressHUD showText:@"当前为Wi-Fi状态" inview:[[UIApplication sharedApplication].windows lastObject]];
        }
        else{
            [MBProgressHUD showText:@"没有连接网络" inview:[[UIApplication sharedApplication].windows lastObject]];
        }
    }];
}

#pragma mark 设置时间标题
-(void)setTimeLa{
    
    CGRect tmpRect = [@"2012-12-31" boundingRectWithSize:CGSizeMake(self.view.frame.size.width/3, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
    
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = tmpRect.size.width+200;
    CGFloat H = tmpRect.size.height;
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(X,Y,W,H)];
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.centerX = self.view.centerX;
    timeLable.centerY = 22 + 45 + 10;
    timeLable.textColor = kColorBlack;
    timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable = timeLable;
    [self.view addSubview:timeLable];
}

#pragma mark 设置子视图
-(void)setSlide{
    //整页
    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight | YSLDraggableDirectionUp;
    [self.view addSubview:_container];
    [self.view bringSubviewToFront:self.timeLable];
    [_container reloadCardContainer];
}

/**
 *  如果有点击事件  数据来源于上一个界面
 *  否则就是本界面的刷新。
 */
#pragma mark 刷新数据
-(void)refreheing{
    
    self.timeLable.hidden = NO;
    
    /**点击事件刷新存在数据源已经*/
    if (self.ClickDate != nil) {
        [_container reloadCardContainer];
        
    }else{
        /**不存在数据源的刷新*/
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,HotDetail,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
            NSArray *rows = responseDic[@"rows"];
            self.VCModelArr = (NSMutableArray *)[HotPointModel objectArrayWithKeyValuesArray:rows];
            [_container reloadCardContainer];
            if (self.timeLable.text == nil) {
                if(self.VCModelArr.count!=0){
                    HotPointModel *model =self.VCModelArr[0];
                    NSDate *date = [NSDate dateFromString:model.indate withFormat:@"YYYY-MM-dd"];
                    self.lastedData = date;
                    self.timeLable.text =  model.indate;
                    self.LTime = model.indate;
                }
            }
        } fail:^(NSError *error) {
            [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
        }];
    }

    if(self.ClickDate == nil){
        NSString *currentTime = self.LTime;
        self.timeLable.text = currentTime;
        [self.view reloadInputViews];
    }else{
        NSString *currentTime = [self getTimeStrWithDate:self.ClickDate];
        self.timeLable.text = currentTime;
        [self.view reloadInputViews];
    }
}

/*取得系统时间*/
#pragma mark 取得系统时间
-(NSString *)getTimeStrWithDate:(NSDate *) date{
    
    if (!date) {
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        return dateString;
    }else{
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        return dateString;
    }
}

#pragma mark -- YSLDraggableCardContainer DataSource
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return self.VCModelArr.count;
}

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    HotPointView *view = [[HotPointView alloc]initWithFrame:CGRectMake(28, 64 + 28, self.view.frame.size.width - 55, self.view.frame.size.height - 2 * (64 + 18))];
    view.model = self.VCModelArr[index];
    view.delegate = self;
    
    HotPointModel *pointModel = self.VCModelArr[index];
    NSString *msgKey = pointModel.msgkeyid;
    NSString *msgType = pointModel.type;
    [self getRecommedIconArrWithMsgkey:msgKey andMessageType:msgType WithView:view];
    [self getAboutMessageWithMsgkey:msgKey andMessageType:msgType WithView:view];
    return view;
}

#pragma mark -- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
    });
}

/*得到评论头像urlstring数组*/
-(void)getRecommedIconArrWithMsgkey:(NSString *)msgkey andMessageType:(NSString *)type WithView:(HotPointView *)view{
    //取出评论头像数组
    NSString *token = [UserInfoTool getUserInfo].token;
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&msgkey=%@&type=%@",NetHeader,PushHotPerson,token,msgkey,type];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSArray *arr = responseDic[@"rows"];
        NSArray* iconArr = [RecommedModel objectArrayWithKeyValuesArray:arr];
        
        if (iconArr.count>0) {
            view.recommendArr = (NSMutableArray *)iconArr;
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

/*获取相关消息*/
-(void)getAboutMessageWithMsgkey:(NSString *)msgkey andMessageType:(NSString *)type WithView:(HotPointView *)view{
    
    NSString *token = [UserInfoTool getUserInfo].token;
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&msgkey=%@&type=%@",NetHeader,PushHotInfo,token,msgkey,type];

    //取出评论头像数组
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        NSArray *arr = responseDic[@"rows"];
        NSMutableArray *messageArr = (NSMutableArray *)[AboutMessageModel objectArrayWithKeyValuesArray:arr];
        
        if (messageArr.count>0) {
            view.messageArr = messageArr;
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];    
}

/**
 *设置icon的点击事件
 */
-(void)iconClickAndRecommedListDelegate:(TapGestureRecognizer *)btn
{
    switch (btn.tag) {
        //大图点击
        case 1:{
            [self pushViewWithtype:btn.typeStr WithID:btn.parameterStr];
            break;
        }
            
        case 2:{
            NSString *token = [UserInfoTool getUserInfo].token;
            if (!token) {
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate alertViewLogin];
            }else{
                
                NSDictionary *dic = @{
                                    @"token":token,
                                    @"zttid" :btn.parameterStr
                                    };
                
                NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,HotIcoClick];
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
                    if([responseDic[@"rescode"] integerValue] == 20002)
                    {
                        [MBProgressHUD showText:@"您还未登录或登录超时，请登录!" inview:self.view];
                    }else{
                        NSDictionary  *tempDic=responseDic[@"data"];
                        FriendModel *model=[FriendModel objectWithKeyValues:tempDic];
                        [self showFriendInfo:model];
                    }
                } fail:^(NSError *error) {
                    [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
                }];
            }
            
            
        } break;
        case 3:{
            [self pushViewWithtype:btn.typeStr WithID:btn.parameterStr];
        }break;
        default:
            break;
    }
}

#pragma mark 头像点击
-(void)showFriendInfo:(FriendModel *)friend
{
    FriendInfoShowHotViewController *infoVc = [[FriendInfoShowHotViewController alloc] init];
    infoVc.friendM = friend;
    [self.navigationController pushViewController:infoVc animated:YES];
}

/**
 *  type类型
 *  CourseId ID
 *  imageUrL 分享需要用的图片
 */
#pragma mark 大图点击跳转
-(void)pushViewWithtype:(NSString *)type WithID:(NSString *)CourseId{
    
    if ([UserInfoTool isLogin]) {
        if([type isEqualToString:testType]){
            MainWebController *examController = [[MainWebController alloc] init];
            NSString *str = [NSString stringWithFormat:@"%@%@?locale=%@&testid=%@",NetHeader,TestDesc,[ManyLanguageMag getTypeWithWebDiscript],CourseId];
            examController.url = str;
            examController.webTitle = @"考试详情";
            [self.navigationController pushViewController:examController animated:YES];
        }
        else if ([type isEqualToString:newsType]){

            MainWebController *vc= [[MainWebController alloc] init];
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?id=%@&locale=%@",NetHeader,AdvisoryOnly,CourseId,[ManyLanguageMag getTypeWithWebDiscript]];
            vc.webTitle = @"资讯";
            vc.url = uelStr;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([type isEqualToString:specialType]){
            CourseSpecialDetailViewController *vc = [[CourseSpecialDetailViewController alloc] init];
            vc.ID = CourseId;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([type isEqualToString:shalongType]){

            MainWebController *shalong = [[MainWebController alloc] init];
            NSString *url = [NSString stringWithFormat:@"%@mh5/shalong/shalongdetail?id=%@&locale=%@",NetHeader,CourseId,[ManyLanguageMag getTypeWithWebDiscript]];
            shalong.url = url;
            shalong.webTitle = @"沙龙详情";
            [self.navigationController pushViewController:shalong animated:YES];
            
        }
        else if ([type isEqualToString:voteType]){
            NSString *uelStr = [NSString stringWithFormat:@"%@mh5/vote/votetags?id=%@",NetHeader,CourseId];

            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = [ManyLanguageMag getMineMenuStrWith:@"我的问卷"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([type isEqualToString:liveType]){

            NSString *uelStr=[NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,CourseId,appkey,[ManyLanguageMag getTypeWithWebDiscript]];

            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.title = @"直播详情";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([type isEqualToString:teacherType]){
            MainWebController *vc= [[MainWebController alloc] init];
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?id=%@",NetHeader,Teacher,CourseId];
            vc.webTitle = @"讲师详情";
            vc.url = uelStr;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([type isEqualToString:courseType]){

            NSDictionary *parameter=@{
                                      @"chapterid":CourseId
                                      };
            NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,[UserInfoTool getUserInfo].token];
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                NSInteger code=[responseDic[@"rescode"] integerValue];
                
                if (code == 10000)
                {
                    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDetail,[UserInfoTool getUserInfo].token];
                    NSDictionary *parameter=@{
                                              @"chapterid":CourseId
                                              };
                    
                    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                        
                        NSDictionary *dic = responseDic[@"data"];
                        
                        if (dic.allKeys.count!=0) {
                            NSInteger code=[responseDic[@"rescode"] integerValue];
                            if (code==10000) {
                                //到课程详情
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
                            
                        }else{
                            [MBProgressHUD showText:@"课程已被删除" inview:self.view];
                        }
                        
                    } fail:^(NSError *error) {
                        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
                    }];
                }else if(code == 30030)
                {
                    [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
                }
                
            } fail:^(NSError *error) {
                [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
            }];
        }
    }else{//没有登录
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate alertViewLogin];
    }
}

@end
