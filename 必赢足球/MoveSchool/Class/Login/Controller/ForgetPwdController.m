//
//  ForgetPwdController.m
//  MoveSchool
//
//  Created by edz on 2017/4/21.
//
//

#import "ForgetPwdController.h"
#import "CountDownButton.h"
#import "RemindTextField.h"
#import "UIButton+Extension.h"
#import "AFNetWW.h"
#import "WebViewJavascriptBridge.h"

@interface ForgetPwdController ()<CountDownButtonDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet CountDownButton *activeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *userIdImage;

@property (weak, nonatomic) IBOutlet UIButton *findPwdBtn;

@property (weak, nonatomic) IBOutlet UIButton *mobeleB;

@property (weak, nonatomic) IBOutlet UIButton *emailB;

@property (weak, nonatomic) IBOutlet CountDownButton *jihuomaB;

@property (weak, nonatomic) IBOutlet RemindTextField *pwdFieldView;

@property (weak, nonatomic) IBOutlet RemindTextField *activeFieldView;

@property (weak, nonatomic) IBOutlet RemindTextField *userIdFiledView;

@property (weak, nonatomic) IBOutlet RemindTextField *emailFieldView;

@property (weak, nonatomic) IBOutlet UIView *titleSlideView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activeViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *pwdView;

@property (weak, nonatomic) IBOutlet UIView *activeView;

@property(strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation ForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [ManyLanguageMag getSettingStrWith:@"重置密码"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);

    [self setUpUI];
    
}

- (void) setUpUI
{
    self.findPwdBtn.layer.masksToBounds = YES;
    self.findPwdBtn.layer.cornerRadius = 10.0;
    [self.findPwdBtn setTitle:[ManyLanguageMag getSettingStrWith:@"重置密码"] forState:UIControlStateNormal];
    
    [self.mobeleB setTitle:[ManyLanguageMag getSettingStrWith:@"手机找回"] forState:UIControlStateNormal];
    
    [self.emailB setTitle:[ManyLanguageMag getSettingStrWith:@"邮箱找回"] forState:UIControlStateNormal];

    [self.jihuomaB setTitle:[ManyLanguageMag getSettingStrWith:@"获取激活码"] forState:UIControlStateNormal];

    
    self.pwdFieldView.placeholder = [ManyLanguageMag getSettingStrWith:@"请输入密码(6-16位数字或字母)"];
    
    self.activeFieldView.placeholder = [ManyLanguageMag getSettingStrWith:@"请输入激活码"];
    
    self.userIdFiledView.placeholder = [ManyLanguageMag getSettingStrWith:@"请输入手机号码"];

    self.emailFieldView.placeholder = [ManyLanguageMag getSettingStrWith:@"请输入注册邮箱"];
    
    self.activeBtn.delegate = self;
    
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


+ (instancetype)forgetPwdController
{
    return [[UIStoryboard storyboardWithName:@"ForgetPwd" bundle:nil] instantiateInitialViewController];
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

#pragma mark 获取验证码
- (void) sendActiveCode : (NSString *) data
{
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_REG_ACTIVE_CODE];
    
    NSDictionary *dic=@{
                        @"mobile": data,
                        @"scene" : @2
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

#pragma mark 邮箱找回
- (IBAction)onEmailRegister:(UIButton *)sender {
    self.userIdFiledView.hidden = YES;
    self.emailFieldView.hidden = NO;
    
    self.titleSlideView.x = self.view.width * 0.5;
    self.activeViewHeightConstraint.constant = 0.0;
    self.emailB.selected = YES;
    self.mobeleB.selected = NO;
    self.pwdView.hidden = YES;
    self.activeView.hidden = YES;
    
    [self.findPwdBtn setTitle:[ManyLanguageMag getSettingStrWith:@"立即发送邮件"] forState:UIControlStateNormal];
    
    self.userIdImage.image = [UIImage imageNamed:@"icon_email"];
}

#pragma mark 手机找回
- (IBAction)onMobileRegister:(UIButton *)sender {
    self.emailFieldView.hidden = YES;
    self.userIdFiledView.hidden = NO;
    self.titleSlideView.x = self.view.x - 15;
    
    self.activeViewHeightConstraint.constant = 55.0;
    
    self.emailB.selected = NO;
    self.mobeleB.selected = YES;
    self.pwdView.hidden = NO;
    self.activeView.hidden = NO;
    [self.findPwdBtn setTitle:[ManyLanguageMag getSettingStrWith:@"重置密码"] forState:UIControlStateNormal];
    
    self.userIdImage.image = [UIImage imageNamed:@"user-id"];
    
}

#pragma mark 重置密码
- (IBAction)onSubmit:(id)sender {
    BOOL isMobile = self.mobeleB.selected;
    NSString *mobileNumber = self.userIdFiledView.text;
    NSString *emailAccount = self.emailFieldView.text;
    NSString *activeCode = self.activeFieldView.text;
    NSString *pwdValue = self.pwdFieldView.text;
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    if (isMobile){
        
        if (pwdValue.length < 6 || pwdValue.length > 16) {
            [self.pwdFieldView remind:@"6-16位数字或字母"];
            return;
        }
        
        if (mobileNumber.length < 11) {
            [self.userIdFiledView remind:@"请输入手机号码"];
            return ;
        }
        data[@"mobile"] = mobileNumber;
        if (activeCode.length < 4) {
            [self.activeFieldView remind:@"输入有误"];
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
                NSArray *dat = @[pwdValue,exponent,modulus];
                
                [self.bridge callHandler:@"testJavascriptHandler" data:dat responseCallback:^(id responseData) {
                    //RSA得到加密后的密码（jS文件中取到）
                    data[@"newpwd"] = responseData;
                    data[@"code"] = activeCode;
                    
                    [self commitRegister:[NSString stringWithFormat:@"%@%@",NetHeader,FindPwdMobild] data:data];

                }];
            }else
            {
                [MBProgressHUD hideHUD];
            }
            
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
    }else{
        if (emailAccount.length < 5) {
            [self.emailFieldView remind:[ManyLanguageMag getSettingStrWith:@"请输入正确的邮箱地址"]];
            return;
        }

        data[@"mail"] = emailAccount;
        [self commitRegister:[NSString stringWithFormat:@"%@%@",NetHeader,FindPwdEmail] data:data];
    }
}

#pragma mark 提交
- (void) commitRegister : (NSString *)url data : (NSDictionary *) data
{
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:data success:^(id responseDic) {
        
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            if (self.mobeleB.selected) {
                [MBProgressHUD showSuccess:[ManyLanguageMag getSettingStrWith:@"重置密码成功"]];
                [MainUserDefaults setBool:YES forKey:MOBILE_HAS_REGISTER];
                [MainUserDefaults synchronize];
            }else
            {
                [MBProgressHUD showSuccess:[ManyLanguageMag getSettingStrWith:@"找回密码邮件已发送到您的邮箱"]];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else if (rescode == 20501) {
            [MBProgressHUD showError:[ManyLanguageMag getSettingStrWith:@"邮箱不存在！"]];
        }else if (rescode == 20502) {
            [MBProgressHUD showError:[ManyLanguageMag getSettingStrWith:@"手机号码不存在"]];
        }else if (rescode == 20601) {
            [MBProgressHUD showError:[ManyLanguageMag getSettingStrWith:@"邮箱已存在"]];
        }else if (rescode == 20602) {
            [MBProgressHUD showError:[ManyLanguageMag getSettingStrWith:@"手机号已存在"]];
        }else if (rescode == 20300){
            [MBProgressHUD showError:[ManyLanguageMag getSettingStrWith:@"验证码错误"]];
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
