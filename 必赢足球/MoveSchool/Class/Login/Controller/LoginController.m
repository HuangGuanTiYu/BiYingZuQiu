//
//  LoginController.m
//  MoveSchool
//
//  Created by edz on 2017/4/20.
//
//  登录

#import "LoginController.h"
#import "ManyLanguageMag.h"
#import "RegistController.h"
#import "RemindTextField.h"
#import "ForgetPwdController.h"
#import "AFNetWW.h"
#import "WebViewJavascriptBridge.h"
#import "AppDelegate.h"
#import "MJExtension.h"
#import "ColorTypeTools.h"
#import "AccountPwd.h"
#import <UMSocialCore/UMSocialCore.h>
#import "TopImageButton.h"
#import <AdSupport/AdSupport.h>

#define spacing 10
#define PWD_CODE_KEY @"iglobalview"

typedef enum : int {
    ThirdLoginQQ,
    ThirdLoginWeChat,
    ThirdLoginSina
} ThirdLoginType;

@interface LoginController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welocomL;

@property (weak, nonatomic) IBOutlet RemindTextField *idTextField;

@property (weak, nonatomic) IBOutlet RemindTextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UILabel *remenberpasswordL;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UIButton *zhaohuimimaB;

@property (weak, nonatomic) IBOutlet UIButton *kuaisuzhuceB;

@property (weak, nonatomic) IBOutlet UILabel *thirdLogin;

@property (weak, nonatomic) IBOutlet UIButton *remberButton;

@property(strong, nonatomic) WebViewJavascriptBridge *bridge;

@property (weak, nonatomic) IBOutlet UIView *qqloginButton;

@property (weak, nonatomic) IBOutlet UIView *loginLeftView;

@property (weak, nonatomic) IBOutlet UIView *loginRightButton;

@property (weak, nonatomic) IBOutlet UIView *weiChatloginButton;

@property (weak, nonatomic) IBOutlet UIView *sinaloginButton;

@property (weak, nonatomic) IBOutlet UIView *otherView;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [ManyLanguageMag getLOginStrWith:@"用户登录"];
    
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"common_back" target:self selector:@selector(back)];

    [self setUpUI];
    
}

#pragma mark 返回
- (void) back
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 初始化UI
- (void) setUpUI
{
    self.welocomL.text = [ManyLanguageMag getLOginStrWith:@"欢迎登录网易足球"];
    
    self.idTextField.placeholder = [ManyLanguageMag getLOginStrWith:@"手机号/邮箱/工号"];
    
    self.pwdTextField.placeholder = [ManyLanguageMag getLOginStrWith:@"请输入密码"];
    
    [self.submitBtn setTitle:[ManyLanguageMag getLOginStrWith:@"登录"] forState:UIControlStateNormal];
    
    self.remenberpasswordL.text = [ManyLanguageMag getLOginStrWith:@"记住密码"];
    
    [self.kuaisuzhuceB setTitle:[ManyLanguageMag getLOginStrWith:@"快速注册"] forState:UIControlStateNormal];
    
    [self.zhaohuimimaB setTitle:[ManyLanguageMag getLOginStrWith:@"找回密码"] forState:UIControlStateNormal];
    
    self.thirdLogin.text = [ManyLanguageMag getLOginStrWith:@"社交账号登录"];
    
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 10;
    
    self.remberButton.selected = [MainUserDefaults boolForKey:remberPassword];
    
    if (self.remberButton.selected) { //记住密码
        self.idTextField.text = [UserInfoTool getAccount].loginId;
        NSString *pwd = [ColorTypeTools aes256_decrypt:PWD_CODE_KEY withString:[UserInfoTool getAccount].loginPwd];
        self.pwdTextField.text = pwd;
    }else
    {
        self.idTextField.text = [UserInfoTool getAccount].loginId;
    }
    
    //记载本地webview 加密
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webview.hidden = YES;
    [self.view addSubview:webview];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webview];
    [self.bridge setWebViewDelegate:self];
    [self loadRSAPage : webview];
    
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    
    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
    
    if (!isInstallQQ && !isInstallSina && !isInstallWecha) {
        self.thirdLogin.hidden = self.loginLeftView.hidden = self.loginRightButton.hidden = YES;
    }
    
    NSMutableArray *shareArray = [NSMutableArray array];
    
    if (isInstallQQ) {
        
        UIButton *qqButton = [[UIButton alloc] init];
        qqButton.tag = ThirdLoginQQ;
        [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
        [shareArray addObject:qqButton];
    }
    
    if (isInstallSina) {
        UIButton *sinaButton = [[UIButton alloc] init];
        sinaButton.tag = ThirdLoginSina;
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sinaButton setImage:[UIImage imageNamed:@"icon_sina"] forState:UIControlStateNormal];
        [shareArray addObject:sinaButton];
    }
    
    if (isInstallWecha) {
        
        UIButton *weChatButton = [[UIButton alloc] init];
        weChatButton.tag = ThirdLoginWeChat;
        [weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButton setImage:[UIImage imageNamed:@"icon_weixin"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButton];
    }
    
    if (shareArray.count > 0) {
        
        //按钮宽高
        CGFloat buttonSize = 55;
        
        int count = (int) shareArray.count + 1;
        
        for (int i = 0; i < shareArray.count; i ++) {
            UIButton *button = shareArray[i];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(0, 0, buttonSize, buttonSize * 2);
            button.centerY = self.otherView.height * 0.5 + mainSpacing;
            button.centerX = (self.view.width / count) * (i + 1);
            [self.otherView addSubview:button];
        }
    }
}

#pragma mark 第三方登录
- (void) buttonClick : (UIButton *) button
{
    if (button.tag == ThirdLoginQQ) {
        [self qqLogin:button];
    }else if(button.tag == ThirdLoginWeChat)
    {
        [self wechatLogin:button];
    }else if(button.tag == ThirdLoginSina)
    {
        [self weiboLogin:button];
    }
}

- (void) loadRSAPage : (UIWebView *) webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *stingPath = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:stingPath baseURL:[NSURL fileURLWithPath:path]];
}

+ (instancetype)loginController
{
    return [[UIStoryboard storyboardWithName:@"LoginX" bundle:nil] instantiateInitialViewController];
}

#pragma mark 记住密码点击
- (IBAction)remberPwd:(UIButton *) button {
    button.selected = !button.selected;
    
    [MainUserDefaults setBool:button.selected forKey:remberPassword];
    [MainUserDefaults synchronize];
}

#pragma mark 快速注册点击
- (IBAction)registerClick:(id)sender {
    RegistController *registVc = [RegistController registController];
    [self.navigationController pushViewController:registVc animated:YES];
}

#pragma mark 忘记密码点击
- (IBAction)backPwd:(id)sender {
    ForgetPwdController *foregetVc = [ForgetPwdController forgetPwdController];
    [self.navigationController pushViewController:foregetVc animated:YES];
}

#pragma mark 登录点击
- (IBAction)onLogin:(id)sender {
    NSString *idText = self.idTextField.text;
    NSString *pwd = self.pwdTextField.text;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]{11}"];
    BOOL isMobile = [predicate evaluateWithObject:idText];
    if (pwd.length < 6 || pwd.length > 16) {
        [self.pwdTextField remind:[ManyLanguageMag getSettingStrWith:@"6-16位数字或字母"]];
        return;
    }
    
    [MBProgressHUD showMessage:@"请稍后"];
    
    //RSA取得秘钥
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_PASSWORDCODE];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
            NSDictionary *dataX = responseDic[@"data"];
            NSString *exponent = dataX[@"exponent"];
            NSString *modulus = dataX[@"modulus"];
            
            NSArray *dat = @[pwd,exponent,modulus];
            
            [self.bridge callHandler:@"testJavascriptHandler" data:dat responseCallback:^(id responseData) {
                //RSA得到加密后的密码（jS文件中取到）
                NSString *password = [NSString stringWithFormat:@"%@",responseData];
                
                NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,Login];
                
                NSString *jpush_regid = [[NSUserDefaults standardUserDefaults] objectForKey:RegistrationID];
                
                NSString *imei = [[[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                NSDictionary *dic=@{@"username":idText, @"password" : password,@"mobileinfo" : @{@"imei" : imei, @"ver" : [[UIDevice currentDevice] systemVersion], @"ostype" : @"2",@"jpush_regid" : jpush_regid}};
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
                    
                    int code = [responseDic[@"rescode"] intValue];
                    
                    if (code == 10000) {
                        //保存用户登录信息
                        UserInfo *userInfo = [UserInfo objectWithKeyValues:responseDic[@"data"]];
                        userInfo.loginId = idText;
                        userInfo.loginPwd = [ColorTypeTools aes256_encrypt:PWD_CODE_KEY withString:pwd];
                        
                        if (isMobile) {
                            userInfo.loginType = LOGIN_TYPE_MOBILE;
                        }else{
                            userInfo.loginType = LOGIN_TYPE_EMAIL;
                        }
                        
                        [UserInfoTool saveUserInfo:userInfo];
                        
                        AccountPwd *account = [[AccountPwd alloc] init];
                        account.loginId = userInfo.loginId;
                        account.loginPwd = userInfo.loginPwd;
                        [UserInfoTool saveAccount:account];
                        
                        [self.view endEditing:YES];
                        [MBProgressHUD showSuccess:[ManyLanguageMag getLOginStrWith:@"登录成功"]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"HAVEPUSH" object:nil];
                        
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }else if (code == 20001) {
                        [MBProgressHUD showError:[ManyLanguageMag getLOginStrWith:@"网络卡顿或用户密码错误"]];
                    }else if (code == 20002) {
                        [MBProgressHUD showError:[ManyLanguageMag getLOginStrWith:@"您还未登录或登录超时，请登录!"]];

                    }else if (code == 20003) {
                        [MBProgressHUD showError:[ManyLanguageMag getLOginStrWith:@"无访问权限"]];
                    }else if (code == 20004) {
                        [MBProgressHUD showError:[ManyLanguageMag getLOginStrWith:@"邮箱未激活"]];
                    }else if (code == 20005){
                        [MBProgressHUD showError:[ManyLanguageMag getLOginStrWith:@"帐号已经冻结"]];
                    }else{
                        [MBProgressHUD hideHUD];
                    }
                } fail:^(NSError *error) {
                    [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"发送请求失败"]];
                }];
            }];
        }else
        {
            [MBProgressHUD hideHUD];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark QQ登录
- (IBAction)qqLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,QQLogin];

            NSString *sex = @"1";
            if ([@"女" isEqualToString:resp.gender]) {
                sex = @"2";
            }
            
            NSString *jpush_regid = [[NSUserDefaults standardUserDefaults] objectForKey:RegistrationID];
            
            NSString *imei = [[[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            NSDictionary *dic = @{@"openid":resp.openid, @"headimgurl" : resp.iconurl,@"nickname" : resp.name, @"sex":sex,  @"mobileinfo" : @{@"imei" : imei,@"ver" : [[UIDevice currentDevice] systemVersion], @"ostype" : @"2",@"jpush_regid" : jpush_regid}};
            
            [self loginWithUrl:url dic:dic];
        }
    }];
}

#pragma mark 微博登录
- (IBAction)weiboLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,SinaLogin];
            
            NSString *sex = @"1";
            if ([@"女" isEqualToString:resp.gender]) {
                sex = @"2";
            }
                        
            NSString *jpush_regid = [[NSUserDefaults standardUserDefaults] objectForKey:RegistrationID];
            
            NSString *imei = [[[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            NSDictionary *dic = @{@"weiboid":resp.uid, @"headimgurl" : resp.iconurl,@"nickname" : resp.name, @"sex":sex,  @"mobileinfo" : @{@"imei" : imei, @"ver" : [[UIDevice currentDevice] systemVersion], @"ostype" : @"2",@"jpush_regid" : jpush_regid}};
            
            [self loginWithUrl:url dic:dic];
        }
    }];
}

#pragma mark 微信登录
- (IBAction)wechatLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {        
        
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,WeiXinLogin];
            
            NSString *sex = @"1";
            if ([@"女" isEqualToString:resp.gender]) {
                sex = @"2";
            }
            
            NSString *jpush_regid = [[NSUserDefaults standardUserDefaults] objectForKey:RegistrationID];
            
            NSString *imei = [[[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            NSDictionary *dic = @{@"openid":resp.openid,@"unionid" : resp.uid, @"headimgurl" : resp.iconurl,@"nickname" : resp.name, @"sex":sex,  @"mobileinfo" : @{@"imei" : imei,@"ver" : [[UIDevice currentDevice] systemVersion], @"ostype" : @"2",@"jpush_regid" : jpush_regid}};
            
            [self loginWithUrl:url dic:dic];

        }
    }];
}

#pragma mark 第三方登录成功后 调用服务器接口
- (void) loginWithUrl : (NSString *) url dic : (NSDictionary *) dic
{
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        int code = [responseDic[@"rescode"] intValue];
        if (code == 10000) {
            UserInfo *userInfo = [UserInfo objectWithKeyValues:responseDic[@"data"]];
            [UserInfoTool saveUserInfo:userInfo];
            
            AccountPwd *account = [[AccountPwd alloc] init];
            account.loginId = userInfo.loginId;
            account.loginPwd = userInfo.loginPwd;
            [UserInfoTool saveAccount:account];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HAVEPUSH" object:nil];
            [MBProgressHUD showSuccess:[ManyLanguageMag getLOginStrWith:@"登录成功"]];
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"发送请求失败"]];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

@end
