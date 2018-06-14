//
//  MainWebController.m
//  MoveSchool
//
//  Created by edz on 2017/4/21.
//
//  通用webView

#import "MainWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ZttApp.h"
#import "ManyLanguageMag.h"
#import <UMSocialCore/UMSocialCore.h>
#import "ShareButton.h"
#import "AFNetWW.h"
#import "CourseDetailController.h"
#import "CourseDetailArrayModel.h"
#import "MJExtension.h"
#import "CourseDetailModel.h"
#import "CCLiveModel.h"
#import <CCPush/CCPushUtil.h>
#import "PrePushViewController.h"
#import "IQTextView.h"
#import "NSString+Extension.h"
#import "ColorTypeTools.h"
#import "SearchViewControllerX.h"
#import "MainNavigationController.h"
#import "NewLoginController.h"
#import "WebViewJavascriptBridge.h"
#import "MOKORecordButton.h"
#import "MOKORecorderTool.h"
#import "MOKORecordHeaderDefine.h"
#import "MOKORecordShowManager.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "CreateVideoCourseController.h"
#import "NewH5CourseController.h"
#import "ZiXuntTool.h"
#import "ShaLongTool.h"

#define kFakeTimerDuration       1
#define kMaxRecordDuration       3600     //最长录音时长3600
#define kRemainCountingDuration  10     //剩余多少秒开始倒计时

typedef enum {
    /** 分享到网易足球 */
    ShareSchool,
    /** 分享到QQ */
    ShareToQQ,
    /** 分享到微信 */
    ShareToWechat,
    /** 分享到微博 */
    ShareToSina,
    /** 分享到QQ会话 */
    ShareToQQChat,
    /** 分享到微信朋友圈 */
    ShareToWechatTimeline
} ShareType;

//  types 1：网易足球朋友圈，2：网易足球好友（群）（暂无），3：QQ空间，4：新浪微博，5：微信朋友圈
typedef enum : int {
    ShareTypeNone,
    ShareTypeToYdxt,
    ShareTypeToYdxtFriend,
    ShareTypeToQQ,
    ShareTypeToSina,
    ShareTypeToWeiXin,
    ShareTypeToQQChat,
    ShareTypeToWeiXinChat
} NewShareType;

typedef enum
{
    Course = 1,
    Live,
    Shalong,
    Special,
    H5
} CourseType;

//   1课程，2 直播，3沙龙，4 专题，5 H5页面


@interface MainWebController ()<UIWebViewDelegate,GoToInfoViewControllerProtocol,CCPushUtilDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MOKOSecretTrainRecorderDelegate>

@property (nonatomic, assign) ShareType shareType;

//分享模块
@property(nonatomic, strong) UIView *templateView;

//分享title
@property(nonatomic, copy) NSString *shareTitle;

//分享描述
@property(nonatomic, copy) NSString *shareSummary;

//分享缩略图
@property(nonatomic, strong) id shareImage;

//分享地址URL
@property(nonatomic, copy) NSString *shareUrl;

//遮罩
@property(strong, nonatomic) UIView *maskView;

//分享ID
@property (nonatomic, copy) NSString *shareID;

@property (nonatomic, strong) UIView *commentView;

@property (nonatomic, strong) IQTextView *textView;

@property (nonatomic, strong) UIView *alertVeiw;

@property (nonatomic, strong) UIWebView *webView;

//录音遮罩
@property (nonatomic, strong) UIView *voiceView;

//按住录音按钮
@property (nonatomic, strong) MOKORecordButton *recordButton;

//录音工具
@property (nonatomic, strong) MOKORecorderTool *recorder;

//当前录音状态
@property (nonatomic, assign) MOKORecordState currentRecordState;

@property (nonatomic, assign) BOOL canceled;

@property (nonatomic, strong) MOKORecordShowManager *voiceRecordCtrl;

@property (nonatomic, strong) NSTimer *fakeTimer;

//倒计时计时器
@property (nonatomic, strong) NSTimer *countDownTimer;

@property (nonatomic, assign) float duration;

//开始录音倒计时
@property (nonatomic, assign) int kRemainCountingStart;

@property (nonatomic, strong) NSDictionary *zttAppDic;

@end

@implementation MainWebController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.webTitle;
    
    self.shareTitle = @"网易足球";
    self.shareSummary = @"致力于为客户提供专业化的在线培训服务及系统化的培训解决方案，网易足球聚合了最优质的课程资源、讲师资源，鼓励用户参与分享，打造具有持续学习能力的培训生态圈。";
    self.shareImage = [UIImage imageNamed:@"logo"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.y = - 120;
    webView.scrollView.bounces = NO;
    webView.scalesPageToFit = YES;
    
    self.webView = webView;
    webView.height = self.view.height - 64;
    if (self.isFromStudy) {
        webView.height = self.view.height - 64 - 50;
    }else if(self.isTabbar)
    {
        webView.height = self.view.height - 64 - 50 - 49;
    }
    
    webView.height = self.view.height + 120;

    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self appendUrl]]]];
    
    [self.view addSubview:webView];
        
    //注册 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiddenFrame:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreheing) name:@"HAVEPUSH" object:nil];

    
    if (self.needSearch) {
        self.navigationItem.rightBarButtonItem = [ColorTypeTools itemWithImageName:@"common_search_red" highImageName:@"" addTarget:self action:@selector(searchClick)];
    }
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor whiteColor] imageFont:18];

    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"more" target:self selector:@selector(more)];

}

- (void) more
{
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"收藏",@"举报",nil];
    actionSheet.tag = 0;
    [actionSheet showInView:self.view];
}


//拼接URL
- (NSString *) appendUrl
{
    
    if (![self.url containsString:@"token="]) {
        if ([self.url containsString:@"?"]) {
            self.url = [self.url stringByAppendingString:[NSString stringWithFormat:@"&token=%@",[UserInfoTool getUserInfo].token]];
        }else
        {
            self.url = [self.url stringByAppendingString:[NSString stringWithFormat:@"?token=%@",[UserInfoTool getUserInfo].token]];
        }
        
    }else if([self.url containsString:@"token=(null)"] && [UserInfoTool getUserInfo].token != nil)
    {
        self.url = [self.url stringByReplacingOccurrencesOfString:@"token=(null)" withString:[NSString stringWithFormat:@"token=%@",[UserInfoTool getUserInfo].token]];
    }
    
    if ([self.url containsString:@"?"]) {
        self.url = [self.url stringByAppendingString:@"&frombrower=ydxt-ios"];
    }else
    {
        self.url = [self.url stringByAppendingString:@"?frombrower=ydxt-ios"];
    }
    
    return self.url;
}

- (void) back
{
    
    [self.view endEditing:YES];
    
    if (self.isFromH5Course && self.zttAppDic != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self.zttAppDic options:NSJSONWritingPrettyPrinted error:nil];
        [self refushH5:data methodName:@"ZttApp.Event.beforeBack"];
        return;
    }else if(self.backWebPage)
    {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else
        {
            if (self.isPresent) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else
    {
        if (self.isPresent) {
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 界面加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"console"][@"log"] = ^(JSValue *msg)
    {
        NSLog(@"H5 log : %@", msg);
    };
    
    context[@"console"][@"warn"] = ^(JSValue *msg)
    {
        NSLog(@"H5 warn : %@", msg);
    };
    
    context[@"console"][@"error"] = ^(JSValue *msg)
    {
        NSLog(@"H5 error : %@", msg);
    };
    
    ZttApp *zttApp = [[ZttApp alloc] init];
    context[@"ZttApp"] = zttApp;
    zttApp.delegate = self;
}

#pragma mark 点击跳转的代理方法
-(void)passWebviewControllerWithtitle:(NSString *)title and:(NSString *)url{
    MainWebController *vc = [[MainWebController alloc] init];
    vc.webTitle = title;
    vc.url = [NSString stringWithFormat:@"%@",url];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)zttDelegateWith:(NSString *)url type:(int)type{
    switch (type) {
        case H5SavePhoto:
            [MBProgressHUD showSuccess:@"图片已保存到本地相册"];
            break;
        case PushToCourse:
        {
            //跳转到课程界面
            [self pushCourse:url];
        }
        default:
            break;
    }
}

#pragma mark 跳转到课程界面
- (void) pushCourse : (NSString *) courseid
{
    
    NSDictionary *parameter=@{
                              @"chapterid":courseid
                              };
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            NSDictionary *parameter=@{
                                      @"chapterid":courseid
                                      };
            NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDetail,[UserInfoTool getUserInfo].token];
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                NSInteger code = [responseDic[@"rescode"] integerValue];
                
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
                
            } fail:^(NSError *error) {
                [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
            }];
        }else if(code == 30030)
        {
            [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

/**
 *  沙龙分享
 */
#pragma mark 分享
- (void)shareWithId:(NSString *)shareId :(NSString *)type :(NSString *)title :(NSString *)summary :(NSString *)picurl
{
    self.shareTitle = title;
    self.shareSummary = summary;
    self.shareImage = picurl;
    self.shareID = shareId;
    
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];

    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];

    NSMutableArray *shareArray = [NSMutableArray array];
    
    ShareButton *schoolButton = [[ShareButton alloc] init];
    schoolButton.tag = ShareSchool;
    [schoolButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [schoolButton setTitle:@"网易足球" forState:UIControlStateNormal];
    [schoolButton setImage:[UIImage imageNamed:@"share_01"] forState:UIControlStateNormal];
    [shareArray addObject:schoolButton];
    
    if (isInstallWecha) {
        
        ShareButton *weChatButton = [[ShareButton alloc] init];
        weChatButton.tag = ShareToWechat;
        [weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButton setTitle:@"微信好友" forState:UIControlStateNormal];
        [weChatButton setImage:[UIImage imageNamed:@"share_02"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButton];
        
        ShareButton *weChatButtonTimeline = [[ShareButton alloc] init];
        weChatButtonTimeline.tag = ShareToWechatTimeline;
        [weChatButtonTimeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButtonTimeline setTitle:@"朋友圈" forState:UIControlStateNormal];
        [weChatButtonTimeline setImage:[UIImage imageNamed:@"share_03"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButtonTimeline];
    }
    
    if (isInstallQQ) {
        
        ShareButton *qqButton = [[ShareButton alloc] init];
        qqButton.tag = ShareToQQChat;
        [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqButton setTitle:@"QQ好友" forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"share_04"] forState:UIControlStateNormal];
        [shareArray addObject:qqButton];
        
        ShareButton *qqZoneButton = [[ShareButton alloc] init];
        qqZoneButton.tag = ShareToQQ;
        [qqZoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqZoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
        [qqZoneButton setImage:[UIImage imageNamed:@"share_05"] forState:UIControlStateNormal];
        [shareArray addObject:qqZoneButton];
    }
    
    if (isInstallSina) {
        ShareButton *sinaButton = [[ShareButton alloc] init];
        sinaButton.tag = ShareToSina;
        [sinaButton setTitle:@"微博" forState:UIControlStateNormal];
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sinaButton setImage:[UIImage imageNamed:@"share_06"] forState:UIControlStateNormal];
        [shareArray addObject:sinaButton];
    }
    
    if (shareArray.count > 0) {
    
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *shareView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView = shareView;
        [shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewClick)]];
        [window addSubview:shareView];
        
        //遮罩
        UIView *maskView = [[UIView alloc] initWithFrame:shareView.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.7;
        [shareView addSubview:maskView];
        
        //分享模块
        UIView *templateView = [[UIView alloc] initWithFrame:CGRectMake(0, shareView.height, shareView.width, 110)];
        self.templateView = templateView;
        templateView.backgroundColor = [UIColor whiteColor];
        [shareView addSubview:templateView];
        
        //按钮宽高
        CGFloat buttonSize = 55;
        
        //间距
        CGFloat spaing = (templateView.width - (shareArray.count) * buttonSize) / (shareArray.count + 1);
        
        for (int i = 0; i < shareArray.count; i ++) {
            ShareButton *button = shareArray[i];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i * (buttonSize + spaing) + spaing, 0, buttonSize, buttonSize * 2);
            button.centerY = templateView.height * 0.5;
            [templateView addSubview:button];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            templateView.y = shareView.height - templateView.height;
        }];
    }
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.webTitle;
}

- (void)passCourseid:(NSString *)courseid andType:(int)type
{
    switch (type) {
        case Shalong:
        {
            MainWebController *vc = [[MainWebController alloc] init];
            vc.webTitle = @"沙龙";
            vc.shalongId = courseid;
            NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@mh5/shalong/shalongdetail?id=%@&locale=%@",NetHeader,courseid,[ManyLanguageMag getTypeWithWebDiscript]]];
            vc.url = [NSString stringWithFormat:@"%@",url];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case Live:
        case 40300:
        {
            MainWebController *vc = [[MainWebController alloc] init];
            vc.webTitle = @"直播详情";
            NSString *url = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,courseid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
            vc.url = url;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark 遮罩点击
- (void) shareViewClick
{
    if (self.maskView!= nil && self.maskView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.templateView.y = self.maskView.height;
        } completion:^(BOOL finished) {
            [self.templateView removeFromSuperview];
            [self.maskView removeFromSuperview];
        }];
    }
}

#pragma mark 删除分享平台不加动画
- (void) shareViewClickWithNoAnimate
{
    if (self.maskView!= nil && self.maskView.superview != nil) {
        [self.templateView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }
}

#pragma mark 分享按钮点击
- (void) buttonClick : (UIButton *) button
{
    [self shareViewClickWithNoAnimate];
    
//    self.shareUrl = [NSString stringWithFormat:@"%@mh5/shalong/shalongdetail?id=%@",NetHeader,self.shareID];
    
    switch (button.tag) {
        case ShareSchool: //网易足球
            [self shareToSchool];
            break;
        case ShareToQQ:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case ShareToSina:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            break;
        case ShareToWechatTimeline:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case ShareToQQChat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
        case ShareToWechat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        default:
            break;
    }
}

#pragma mark 分享到平台
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareSummary thumImage:self.shareImage];
    
    //设置网页地址
    shareObject.webpageUrl = self.shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {

        }else{
            
        }
    }];
}

#pragma mark 开启直播
- (void) startLive : (NSString *) liveId
{
    if (liveId.length > 0) {
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&liveid=%@",NetHeader,StartLive,[UserInfoTool getUserInfo].token,liveId];
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
}

#pragma mark CCPush登录回调
-(void)requestLoginSucceedWithViewerId:(NSString *)viewerId {
    PrePushViewController *prePushViewController = [[PrePushViewController alloc] init];
    [self.navigationController pushViewController:prePushViewController animated:YES];
}

/**
 *	@brief	登录请求失败
 */
-(void)requestLoginFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 咨询分享
- (void)shareNews:(NSString *)newid :(NSString *)types :(NSString *)title :(NSString *)summary :(NSString *)picurl
{
    self.shareTitle = title;
    self.shareSummary = summary;
    self.shareImage = picurl;
    self.shareUrl = [NSString stringWithFormat:@"%@case/hotdetail?caseId=%@",NetHeader,newid];
    
    switch ([types intValue]) {
        case ShareTypeToQQ:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case ShareTypeToSina:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            break;
        case ShareTypeToWeiXin:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case ShareTypeToQQChat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            break;
        case ShareTypeToWeiXinChat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        default:
            break;
    }
}

#pragma mark 分享到网易足球
- (void) shareToSchool
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *commentView = [[UIView alloc] initWithFrame:window.bounds];
    self.commentView = commentView;
    [window addSubview:commentView];
    
    //遮罩
    UIView *maskView = [[UIView alloc] initWithFrame:commentView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    [commentView addSubview:maskView];
    
    UIView *alertVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.9, self.view.height * 0.4)];
    self.alertVeiw = alertVeiw;
    alertVeiw.centerX = maskView.width * 0.5;
    alertVeiw.centerY = maskView.height * 0.5;
    alertVeiw.layer.cornerRadius = 5;
    alertVeiw.layer.masksToBounds = YES;
    alertVeiw.backgroundColor = [UIColor whiteColor];
    [commentView addSubview:alertVeiw];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertVeiw.width, 50)];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"分享到圈子";
    
    title.font = [UIFont systemFontOfSize:16];
    [alertVeiw addSubview:title];
    
    //输入框
    IQTextView *textView = [[IQTextView alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(title.frame), alertVeiw.width - 2 * mainSpacing, alertVeiw.height - 50 * 2 - 2 * mainSpacing)];
    self.textView = textView;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.backgroundColor = DivisionDivColor;
    textView.font = [UIFont systemFontOfSize:16];
    
    textView.placeholder = @"不错的沙龙,值得参加!";

    [alertVeiw addSubview:textView];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame) + mainSpacing * 2, alertVeiw.width, 0.5)];
    sepaView.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, sepaView.y, 0.5, alertVeiw.height)];
    sepaView2.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView2];
    
    //按钮
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), alertVeiw.width * 0.5, alertVeiw.height - CGRectGetMaxY(sepaView.frame))];
    [cancleButton addTarget:self action:@selector(commentViewClick) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertVeiw addSubview:cancleButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, cancleButton.y, cancleButton.width, cancleButton.height)];
    
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];

    [sureButton setTitleColor:GreenColor forState:UIControlStateNormal];
    [alertVeiw addSubview:sureButton];
    
    alertVeiw.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        alertVeiw.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark 发表评论点击
- (void) sureButtonClick : (UIButton *) button
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,BroadcastAdd,[UserInfoTool getUserInfo].token];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"type"] = shalongType;
    
    NSString *content = @"不错的沙龙,值得参加!";
    if (self.textView.text.length > 0) {
        content = self.textView.text;
    }
    dict[@"content"] = [NSString encodeBase64:content];
    NSMutableArray *newAttachs = [NSMutableArray array];
    NSMutableDictionary *attachsDict = [NSMutableDictionary dictionary];
    
    attachsDict[@"title"] = self.shareTitle;
    attachsDict[@"url"] = self.shareImage;
    attachsDict[@"thumbnail"] = self.shareImage;
    attachsDict[@"attach_businessid"] = self.shareID;
    attachsDict[@"attach_businesscode"] = shalongType;
    
    [newAttachs addObject:attachsDict];
    dict[@"attachs"] = newAttachs;
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dict success:^(id responseDic) {
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            [MBProgressHUD showSuccess:@"分享成功"];
            [self commentViewClick];
            
        }else
        {
            [MBProgressHUD showError:@"分享失败"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}


#pragma mark 评论遮罩点击
- (void) commentViewClick
{
    if (self.commentView != nil && self.commentView.superview != nil) {
        [self.commentView removeAllSubviews];
        [self.commentView removeFromSuperview];
    }
}

- (void)keyBoardWillShowFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.3;
}

- (void) keyBoardWillHiddenFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.5;
}

- (void)dealloc
{
    if (self.webView != nil) {
        [self.webView reload];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 关闭网页
- (void)close:(NSString *)type
{
    [self.view endEditing:YES];
    
    if ([type isEqualToString:@"h5Course"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }else if([type isEqualToString:@"audioCourse"])
    {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[NewH5CourseController class]]) {
                NewH5CourseController *A =(NewH5CourseController *)controller;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popToViewController:A animated:YES];
                });
            }
        }
    }
}

#pragma mark 荣誉榜点击
- (void)gloryClick:(int)gloryListType
{
    NSString *urlString = @"";
    NSString *title = @"";
    
    if (gloryListType == coinRoll) {
        urlString = CoinRoll;
        title = @"积分排行榜";
    }else if(gloryListType == interactionRoll)
    {
        urlString = InteractionRoll;
        title = @"互动排行榜";
    }else if(gloryListType == studyRoll)
    {
        urlString = StudyRoll;
        title = @"学霸排行榜";
    }
    
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.url = [NSString stringWithFormat:@"%@%@",NetHeader,urlString];
    webVc.webTitle = title;
    [self.navigationController pushViewController:webVc animated:YES];
    
}

#pragma mark 搜索按钮点击
-(void)searchClick{
    SearchViewControllerX *vc = [[SearchViewControllerX alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark H5登录
- (void)showlogin
{
    MainNavigationController *mainVc = [[MainNavigationController alloc] initWithRootViewController:[[NewLoginController alloc] init]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mainVc animated:YES completion:nil];
}

#pragma mark 登录成功刷新
- (void) refreheing
{
    NSString *url = [self appendUrl];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

//    [self.webView reload];
}

#pragma mark 上传图片或者拍照
- (void) selectPic
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [sheet showInView:self.view];
    });
}

#pragma mark 选取录音
- (void)selectVoice
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *voiceView = [[UIView alloc] initWithFrame:window.bounds];
    self.voiceView = voiceView;
    [voiceView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voiceViewClick)]];
    [window addSubview:voiceView];
    
    //遮罩
    UIView *maskView = [[UIView alloc] initWithFrame:voiceView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.7;
    [voiceView addSubview:maskView];
    
    //按住说话
    MOKORecordButton *button = [[MOKORecordButton alloc] init];
    self.recordButton = button;
    button.frame = CGRectMake(0, self.view.height - 118, 54, 118);
    button.centerX = self.view.width * 0.5;
    [button setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"voice_end"] forState:UIControlStateSelected];
    [button setTitle:@"开始录音" forState:UIControlStateNormal];
    [button setTitle:@"结束录音" forState:UIControlStateSelected];
    [voiceView addSubview:button];
    
    //关闭 按钮
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 53, self.view.height, 43, 43)];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [voiceView addSubview:closeButton];
    
    self.recorder = [MOKORecorderTool sharedRecorder];
    self.recorder.delegate = self;
    
    //录音相关
    [self toDoRecord];
    
}

#pragma mark ---- 录音全部状态的监听 以及视图的构建 切换
-(void)toDoRecord
{
    __weak typeof(self) weak_self = self;
    
    //按钮点击
    self.recordButton.recordTouchUpInsideAction = ^(MOKORecordButton *sender){
        if (sender.selected) {
            NSLog(@"完成录音");
            
            [weak_self.recorder stopRecording];
            weak_self.currentRecordState = MOKORecordState_Normal;
            [weak_self dispatchVoiceState];
            
            NSString *url = weak_self.recorder.mp3FilePath;
            
            NSData *voiceData = [NSData dataWithContentsOfFile:url];
            
            NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
            NSString *requestUrl = [NSString stringWithFormat:@"%@/%@?token=%@",header,UploadVoice,[UserInfoTool getUserInfo].token];
            
            AFHTTPRequestOperationManager *manager = [[AFNetWW sharedAFNetWorking] getAFNManager];
            
            [manager POST:requestUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
                [formData appendPartWithFileData:voiceData name:@"file" fileName:[weak_self.recorder.mp3FilePath lastPathComponent] mimeType:@"application/octet-stream;charset=utf-8"];
            
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
                NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
                NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
            
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
                if ([jsonDict[@"err"] intValue] == 0) {
                    [weak_self closeButtonClick];
                    
                    [weak_self refushH5:responseObject methodName:@"ZttApp.selectVoice"];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [MBProgressHUD showError:@"发送失败"];
            }];
        }else
        {

            if (![weak_self canRecord]) return;
            
            if (weak_self.countDownTimer) {
                [weak_self.countDownTimer invalidate];
                weak_self.countDownTimer = nil;
            }
            
            weak_self.kRemainCountingStart = 3;
            
            weak_self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:weak_self selector:@selector(countDownTimerStart) userInfo:nil repeats:YES];
            [weak_self.countDownTimer fire];
        
        }
        
        sender.selected = !sender.selected;
    };
    
    //手指滑出按钮
    self.recordButton.recordTouchUpOutsideAction = ^(MOKORecordButton *sender){
        NSLog(@"取消录音");
        weak_self.currentRecordState = MOKORecordState_Normal;
        [weak_self dispatchVoiceState];
    };
    
    //中间状态  从 TouchDragInside ---> TouchDragOutside
    self.recordButton.recordTouchDragExitAction = ^(MOKORecordButton *sender){
        weak_self.currentRecordState = MOKORecordState_ReleaseToCancel;
        [weak_self dispatchVoiceState];
    };
    
    //中间状态  从 TouchDragOutside ---> TouchDragInside
    self.recordButton.recordTouchDragEnterAction = ^(MOKORecordButton *sender){
        NSLog(@"继续录音");
        weak_self.currentRecordState = MOKORecordState_Recording;
        [weak_self dispatchVoiceState];
    };
}

#pragma mark 开始倒计时
- (void) countDownTimerStart
{
    [self.voiceRecordCtrl updateUIWithRecordState:MOKORecordState_RecordCounting];
    [self.voiceRecordCtrl showRecordCounting:self.kRemainCountingStart];
    
    if (self.kRemainCountingStart == -1) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        
        [self.recorder startRecording];
        self.currentRecordState = MOKORecordState_Recording;
        [self dispatchVoiceState];
        return;
    }
    
    self.kRemainCountingStart -= 1;
}

- (void)dispatchVoiceState
{
    if (_currentRecordState == MOKORecordState_Recording) {
        self.canceled = NO;
        [self startFakeTimer];
    }
    else if (_currentRecordState == MOKORecordState_Normal)
    {
        [self resetState];
    }
    [self.voiceRecordCtrl updateUIWithRecordState:_currentRecordState];
}

- (MOKORecordShowManager *)voiceRecordCtrl
{
    if (_voiceRecordCtrl == nil) {
        _voiceRecordCtrl = [MOKORecordShowManager new];
    }
    return _voiceRecordCtrl;
}

- (void)startFakeTimer
{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
    self.fakeTimer = [NSTimer scheduledTimerWithTimeInterval:kFakeTimerDuration target:self selector:@selector(onFakeTimerTimeOut) userInfo:nil repeats:YES];
    [_fakeTimer fire];
}

- (void)onFakeTimerTimeOut
{
    self.duration += kFakeTimerDuration;
    
    float remainTime = kMaxRecordDuration - self.duration;
    if ((int)remainTime == 0) {
        self.currentRecordState = MOKORecordState_Normal;
        [self dispatchVoiceState];
    }
    else if ([self shouldShowCounting]) {
        self.currentRecordState = MOKORecordState_RecordCounting;
        [self dispatchVoiceState];
        [self.voiceRecordCtrl showRecordCounting:remainTime];
    }
    else
    {
        [self.recorder.recorder updateMeters];
        float   level = 0.0f;                // The linear 0.0 .. 1.0 value we need.
        
        float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
        float decibels = [self.recorder.recorder peakPowerForChannel:0];
        if (decibels < minDecibels)
        {
            level = 0.0f;
        }
        else if (decibels >= 0.0f)
        {
            level = 1.0f;
        }
        else
        {
            float   root            = 2.0f;
            float   minAmp          = powf(10.0f, 0.05f * minDecibels);
            float   inverseAmpRange = 1.0f / (1.0f - minAmp);
            float   amp             = powf(10.0f, 0.05f * decibels);
            float   adjAmp          = (amp - minAmp) * inverseAmpRange;
            level = powf(adjAmp, 1.0f / root);
        }
        
        
        [self.voiceRecordCtrl updatePower:level];
    }
}

- (BOOL)shouldShowCounting
{
    if (self.duration >= (kMaxRecordDuration-kRemainCountingDuration) && self.duration < kMaxRecordDuration && self.currentRecordState != MOKORecordState_ReleaseToCancel) {
        
        return YES;
    }
    return NO;
}

- (void)resetState
{
    [self stopFakeTimer];
    self.duration = 0;
    self.canceled = YES;
}

- (void)stopFakeTimer
{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
}

#pragma mark 录音遮罩点击
- (void) voiceViewClick
{
//    [self closeButtonClick];
}

#pragma mark 关闭按钮点击
- (void) closeButtonClick
{
    if (self.voiceView != nil && self.voiceView.superview != nil) {
        [self.recorder stopRecording];
        self.currentRecordState = MOKORecordState_Normal;
        [self dispatchVoiceState];
        [self.voiceView removeFromSuperview];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 0) {
        //收藏
        if (buttonIndex == 0) {
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:@"https://api.kv.meixiumeike.com/api/kv?K=text" WithParameters:nil success:^(id responseDic)
             {
                 
                 
             }fail:^(NSError *error) {
                 
             }];
            
            [MBProgressHUD showSuccess:@"收藏成功"];
            
            if (self.isZiXun) {
                [ZiXuntTool saving:self.model];
            }else if(self.isShalong)
            {
                [ShaLongTool saving:self.shalongModel];
            }
            
        }else if (buttonIndex == 1) {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:nil
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"标题党",@"内容低俗",@"虚假欺诈",@"其他问题",nil];
            actionSheet.tag = 1;
            [actionSheet showInView:self.view];
        }
    }else
    {
        if (buttonIndex == 4) {
            return;
        }
        [MBProgressHUD showSuccess:@"举报成功"];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    NSString *url = [NSString stringWithFormat:@"%@/%@?token=%@",header,UploadOneImage,[UserInfoTool getUserInfo].token];
    
    AFHTTPRequestOperationManager *manager = [[AFNetWW sharedAFNetWorking] getAFNManager];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];

        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"file" fileName:@"test.jpg" mimeType:@"image/jpg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refushH5:responseObject methodName:@"ZttApp.selectPic"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                bCanRecord = YES;
            }
            else {
                bCanRecord = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:nil
                                                message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                               delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil] show];
                });
            }
        }];
    }
    return bCanRecord;
}

#pragma mark 回调给H5 让H5刷新
//methodName 方法名
- (void) refushH5 : (id) responseObject methodName : (NSString *) methodName
{
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseObject
                          options:kNilOptions
                          error:nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"rescode"] = @"10000";
    dict[@"msg"] = @"";
    dict[@"data"] = json;
    dict[@"rows"] = [NSArray array];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *string = [NSString stringWithFormat:@"ZttWeb.onCallBack('%@',%@)",methodName,jsString];
    
    [self.webView stringByEvaluatingJavaScriptFromString:string];
}

#pragma mark 网页右上角 按钮
- (void)setMenus:(NSString *)menuJson
{
    NSDictionary *dict = [self dictionaryWithJsonString:menuJson];
    NSArray *itmes = dict[@"items"];
    if (itmes.count > 0) {
        NSDictionary *first = [itmes firstObject];
        self.zttAppDic = first;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:first[@"title"] style:UIBarButtonItemStyleDone target:self action:@selector(nextClick)];

    }
}

#pragma mark 制作课件返回
- (void) autoSave:(NSString *)menuJson
{
    if (self.isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark 下一步点击
- (void) nextClick
{
    if (self.zttAppDic != nil) {
        [self.view endEditing:YES];
        NSString *title = self.zttAppDic[@"title"];
        if ([title isEqualToString:@"保存"]) {
            self.isFromH5Course = NO;
        }
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:self.zttAppDic options:NSJSONWritingPrettyPrinted error:nil];
        [self refushH5:data methodName:@"ZttApp.setMenus"];
    }
}

#pragma mark 隐藏保存
- (void)hideMenus : (NSString *) menuJson
{
    if (self.isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    if (self.webTitle.length == 0) {
        self.title = @"预览课件";
    }

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil];
}

#pragma mark 证书分享
- (void)shareCert :(NSString *)type :(NSString *)title :(NSString *)picurl
{

    self.shareTitle = title;
    self.shareImage = [UIImage imageNamed:@"logo"];
    self.shareUrl = picurl;
    
    switch ([type intValue]) {
        case ShareTypeToQQ:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case ShareTypeToSina:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            break;
        case ShareTypeToWeiXin:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        default:
            break;
    }
}

- (void) pullRefreshEnable:(BOOL)refreshEnable
{
    if (!refreshEnable) {
        self.webView.scrollView.mj_header = nil;
    }
}

- (void)shareUrl:(NSString *)url :(NSString *)title :(NSString *)summary :(NSString *)picurl
{

    self.shareSummary = summary;
    self.shareTitle = title;
    self.shareImage = picurl;
    self.shareUrl = url;
    
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    
    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
    
    NSMutableArray *shareArray = [NSMutableArray array];
    
//    ShareButton *schoolButton = [[ShareButton alloc] init];
//    schoolButton.tag = ShareSchool;
//    [schoolButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [schoolButton setTitle:@"网易足球" forState:UIControlStateNormal];
//    [schoolButton setImage:[UIImage imageNamed:@"share_01"] forState:UIControlStateNormal];
//    [shareArray addObject:schoolButton];
    
    if (isInstallWecha) {
        
        ShareButton *weChatButton = [[ShareButton alloc] init];
        weChatButton.tag = ShareToWechat;
        [weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButton setTitle:@"微信好友" forState:UIControlStateNormal];
        [weChatButton setImage:[UIImage imageNamed:@"share_02"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButton];
        
        ShareButton *weChatButtonTimeline = [[ShareButton alloc] init];
        weChatButtonTimeline.tag = ShareToWechatTimeline;
        [weChatButtonTimeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButtonTimeline setTitle:@"朋友圈" forState:UIControlStateNormal];
        [weChatButtonTimeline setImage:[UIImage imageNamed:@"share_03"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButtonTimeline];
    }
    
    if (isInstallQQ) {
        
        ShareButton *qqButton = [[ShareButton alloc] init];
        qqButton.tag = ShareToQQChat;
        [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqButton setTitle:@"QQ好友" forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"share_04"] forState:UIControlStateNormal];
        [shareArray addObject:qqButton];
        
        ShareButton *qqZoneButton = [[ShareButton alloc] init];
        qqZoneButton.tag = ShareToQQ;
        [qqZoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqZoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
        [qqZoneButton setImage:[UIImage imageNamed:@"share_05"] forState:UIControlStateNormal];
        [shareArray addObject:qqZoneButton];
    }
    
    if (isInstallSina) {
        ShareButton *sinaButton = [[ShareButton alloc] init];
        sinaButton.tag = ShareToSina;
        [sinaButton setTitle:@"微博" forState:UIControlStateNormal];
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sinaButton setImage:[UIImage imageNamed:@"share_06"] forState:UIControlStateNormal];
        [shareArray addObject:sinaButton];
    }
    
    if (shareArray.count > 0) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *shareView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView = shareView;
        [shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewClick)]];
        [window addSubview:shareView];
        
        //遮罩
        UIView *maskView = [[UIView alloc] initWithFrame:shareView.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.7;
        [shareView addSubview:maskView];
        
        //分享模块
        UIView *templateView = [[UIView alloc] initWithFrame:CGRectMake(0, shareView.height, shareView.width, 110)];
        self.templateView = templateView;
        templateView.backgroundColor = [UIColor whiteColor];
        [shareView addSubview:templateView];
        
        //按钮宽高
        CGFloat buttonSize = 55;
        
        //间距
        CGFloat spaing = (templateView.width - (shareArray.count) * buttonSize) / (shareArray.count + 1);
        
        for (int i = 0; i < shareArray.count; i ++) {
            ShareButton *button = shareArray[i];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i * (buttonSize + spaing) + spaing, 0, buttonSize, buttonSize * 2);
            button.centerY = templateView.height * 0.5;
            [templateView addSubview:button];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            templateView.y = shareView.height - templateView.height;
        }];
    }
}

- (void)remindLogin
{
    [UserInfoTool delegateUserInfo];
    
    MainNavigationController *mainVc = [[MainNavigationController alloc] initWithRootViewController:[[NewLoginController alloc] init]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mainVc animated:YES completion:nil];
}

- (void) returnLastPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

//创建音频课件
- (void) createAudioCourse
{

    CreateVideoCourseController *vc = [[CreateVideoCourseController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
