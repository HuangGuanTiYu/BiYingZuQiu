//
//  RegistController.m
//  MoveSchool
//
//  Created by edz on 2017/4/20.
//
//  注册

#import "RegistController.h"
#import "RemindTextField.h"
#import "AFNetWW.h"
#import "CountDownButton.h"
#import "UIButton+Extension.h"
#import "MainWebController.h"
#import "WebViewJavascriptBridge.h"
#import "AppDelegate.h"
#import "AFNetWW.h"
#import <AdSupport/AdSupport.h>

@interface RegistController ()<CountDownButtonDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *registButton;

@property (weak, nonatomic) IBOutlet RemindTextField *userIdFiledView;

@property (weak, nonatomic) IBOutlet CountDownButton *activeBtn;

@property(strong, nonatomic) NSTimer *activeTitleLabelTimer;

@property (weak, nonatomic) IBOutlet UILabel *schoolAgreement;

@property (weak, nonatomic) IBOutlet RemindTextField *emailFieldView;

@property (weak, nonatomic) IBOutlet UIView *titleSlideView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CheckViewHeight;

@property (weak, nonatomic) IBOutlet UIView *activeView;

@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@property (weak, nonatomic) IBOutlet UIButton *mobileBtn;

@property (weak, nonatomic) IBOutlet UIImageView *userIdImage;

@property(strong, nonatomic) WebViewJavascriptBridge *bridge;

@property (weak, nonatomic) IBOutlet RemindTextField *activeFieldView;

@property (weak, nonatomic) IBOutlet RemindTextField *pwdFieldView;

@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [ManyLanguageMag getLOginStrWith:@"快速注册"];

    self.view.backgroundColor = RGBCOLOR(240, 240, 240);

    [self setUpUI];

}

+ (instancetype)registController
{
    return [[UIStoryboard storyboardWithName:@"regist" bundle:nil] instantiateInitialViewController];
}

#pragma mark 初始化UI
- (void) setUpUI
{
    self.registButton.layer.masksToBounds = true;
    self.registButton.layer.cornerRadius = 10;
    self.activeBtn.delegate = self;
    self.schoolAgreement.userInteractionEnabled = YES;
    [self.schoolAgreement addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(schoolAgreementClick)]];
    
    //记载本地webview 加密
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webview.hidden = YES;
    [self.view addSubview:webview];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webview];
    [self.bridge setWebViewDelegate:self];
    [self loadRSAPage : webview];
}

- (void) loadRSAPage : (UIWebView *) webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *stingPath = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:stingPath baseURL:[NSURL fileURLWithPath:path]];
}

- (void) sendActiveCode : (NSString *) data
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_REG_ACTIVE_CODE];

    NSDictionary *dic=@{
                        @"mobile": data,
                        @"scene" : @1
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"发送成功"];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];

        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

#pragma mark 获取验证码
- (void)getMobileCode:(CountDownButton *)button
{
    if (self.userIdFiledView.text.length < 11) {
        [self.userIdFiledView remind:@"输入有误"];
        return;
    }
    
    [self sendActiveCode:self.userIdFiledView.text];
    [button startTime : 140];
}

#pragma mark 用户协议点击
- (void) schoolAgreementClick
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.url = [NSString stringWithFormat:@"%@%@",NetHeader,Treaty];
    webVc.webTitle = @"用户协议";
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark 去登录
- (IBAction)toLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 邮箱注册
- (IBAction)emailRegist:(UIButton *)sender {
    
    self.userIdFiledView.hidden = YES;
    self.emailFieldView.hidden = NO;

    self.titleSlideView.x = self.view.width * 0.5;

    self.CheckViewHeight.constant = 0;
    self.activeView.hidden = YES;
    
    self.emailBtn.selected = YES;
    self.mobileBtn.selected = NO;
    self.userIdImage.image = [UIImage imageNamed:@"icon_email"];
}

#pragma mark 手机注册
- (IBAction)onMobileRegister:(UIButton *)sender {
    self.emailFieldView.hidden = YES;
    self.userIdFiledView.hidden = NO;
    self.titleSlideView.x = self.view.x - 15;
    self.CheckViewHeight.constant = 0.112*self.view.frame.size.width;
    
    self.activeView.hidden = NO;
    self.emailBtn.selected = NO;
    self.mobileBtn.selected = YES;
    self.userIdImage.image = [UIImage imageNamed:@"user-id"];
}

#pragma mark 提交注册
- (IBAction)onSubmit:(id)sender {
    BOOL isMobile = self.mobileBtn.selected;
    NSString *mobileNumber = self.userIdFiledView.text;
    NSString *emailAccount = self.emailFieldView.text;
    NSString *activeCode = self.activeFieldView.text;
    NSString *pwdValue = self.pwdFieldView.text;
    
    if (pwdValue.length < 6 || pwdValue.length > 16) {
        [self.pwdFieldView remind:@"6-16位数字或字母"];
        return;
    }
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    data[@"type"] = @"1";
    data[@"mac"] = @"";
    
    NSString *jpush_regid = [[NSUserDefaults standardUserDefaults] objectForKey:RegistrationID];
    
    NSString *imei = [[[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    data[@"imei"] = imei;
    data[@"jpush_regid"] = jpush_regid;
    data[@"os"] = @"";
    data[@"ver"] = @"";
    data[@"model"] = @"";
    data[@"ostype"] = @"2";
    //代理商KEY
    data[@"agentkey"] = AGENTKEY;
    
    [MBProgressHUD showMessage:@"请稍后"];

    //RSA取得秘钥
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_PASSWORDCODE];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {

        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            NSDictionary *dataX = responseDic[@"data"];
            NSString *exponent = dataX[@"exponent"];
            NSString *modulus = dataX[@"modulus"];
            NSArray *dat = @[pwdValue,exponent,modulus];
            [self.bridge callHandler:@"testJavascriptHandler" data:dat responseCallback:^(id responseData) {
                //RSA得到加密后的密码（jS文件中取到）
                data[@"password"] = [NSString stringWithFormat:@"%@",responseData];
                if (isMobile){
                    if (mobileNumber.length < 11) {
                        [self.userIdFiledView remind:@"请输入手机号码"];
                        [MBProgressHUD hideHUD];
                        return ;
                    }                    
                    data[@"mobile"] = mobileNumber;
                    if (activeCode.length < 4) {
                        [self.activeFieldView remind:@"输入有误"];
                        [MBProgressHUD hideHUD];
                        return;
                    }
                    
                    data[@"activecode"] = activeCode;
                    
                    [self commitRegister:[NSString stringWithFormat:@"%@%@",NetHeader,URL_REG_MOBILE] data:data];
                }else{
                    if (emailAccount.length < 5) {
                        [self.emailFieldView remind:@"请输入正确的邮箱地址"];
                        [MBProgressHUD hideHUD];
                        return;
                    }
                    data[@"mail"] = emailAccount;
                    [self commitRegister:[NSString stringWithFormat:@"%@%@",NetHeader,URL_REG_EMAIL] data:data];
                }
            }];
        }else
        {
            [MBProgressHUD hideHUD];
        }

    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark 提交
- (void) commitRegister : (NSString *)url data : (NSDictionary *) data
{
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:data success:^(id responseDic) {
        
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            if (self.mobileBtn.selected) {
                [MBProgressHUD showSuccess:@"注册成功"];
                [MainUserDefaults setBool:YES forKey:MOBILE_HAS_REGISTER];
                [MainUserDefaults synchronize];
            }else
            {
                [MBProgressHUD showSuccess:@"激活邮件已发送到您的邮箱"];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else if (rescode == 20300) {
            [MBProgressHUD showError:@"激活码验证失败"];
        }else if (rescode == 20301) {
            [MBProgressHUD showError:@"邮箱已经存在"];
        }else if (rescode == 20311) {
            [MBProgressHUD showError:@"手机号已经存在"];
        }else
        {
            [MBProgressHUD hideHUD];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

@end
