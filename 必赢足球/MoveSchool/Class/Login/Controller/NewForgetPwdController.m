//
//  NewForgetPwdController.m
//  MoveSchool
//
//  Created by edz on 2017/9/5.
//
//

#import "NewForgetPwdController.h"
#import "CountDownButton.h"
#import "TBCityIconFont.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "MainWebController.h"
#import "UIButton+Extension.h"
#import "AFNetWW.h"
#import "WebViewJavascriptBridge.h"


@interface NewForgetPwdController ()<CountDownButtonDelegate,UIWebViewDelegate>

//注册手机号
@property (nonatomic, strong) UITextField *registPhoneNumber;

//邮箱
@property (nonatomic, strong) UITextField *mailNumber;

//验证码
@property (nonatomic, strong) UITextField *translate;

//注册密码
@property (nonatomic,strong) UITextField *pwdPassword;

//邮箱View
@property (nonatomic,strong) UIView *mailView;

//手机号View
@property (nonatomic, strong) UIView *registView;

@property(strong, nonatomic) WebViewJavascriptBridge *bridge;


@end

@implementation NewForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"重置密码";
    
    [self setUpUI];
    
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZttRsa" ofType:@"html"];
    NSString *stingPath = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:stingPath baseURL:[NSURL fileURLWithPath:path]];
}

- (void) setUpUI
{
    
    //手机找回
    [self phoneGet];
    
    //邮箱找回
    [self mailGet];
}

#pragma mark 手机找回
- (void) phoneGet
{
    //注册View
    UIView *registView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.registView = registView;
    [self.view addSubview:registView];
    
    //中间内容View
    UIView *registContentView = [[UIView alloc] initWithFrame:CGRectMake(15, 25, registView.width - 30, 125)];
    [registView addSubview:registContentView];
    
    CGFloat textFieldHeight = 45;
    
    //手机号
    self.registPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, registContentView.width, textFieldHeight)];
    self.registPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.registPhoneNumber.placeholder = @"手机号";
    self.registPhoneNumber.font = [UIFont systemFontOfSize:ys_28];
    [self.registPhoneNumber setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.registPhoneNumber setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [registContentView addSubview:self.registPhoneNumber];
    
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.registPhoneNumber.frame), registContentView.width, 1)];
    sepaView.backgroundColor = SepaViewColor;
    [registContentView addSubview:sepaView];
    
    //验证码
    self.translate = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), registContentView.width - 20, textFieldHeight)];
    self.translate.secureTextEntry = YES;
    self.translate.placeholder = @"验证码";
    self.translate.font = [UIFont systemFontOfSize:ys_28];
    [self.translate setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.translate setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [registContentView addSubview:self.translate];
    
    //倒计时按钮
    CountDownButton *coutDown = [[CountDownButton alloc] initWithFrame:CGRectMake(registContentView.width - 90, 0, 100, textFieldHeight)];
    coutDown.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [coutDown setTitleColor:MainColor forState:UIControlStateNormal];
    [coutDown setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    coutDown.delegate = self;
    coutDown.centerY = self.translate.centerY;
    [registContentView addSubview:coutDown];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(coutDown.frame), registContentView.width, 1)];
    sepaView2.backgroundColor = SepaViewColor;
    [registContentView addSubview:sepaView2];
    
    //密码
    self.pwdPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView2.frame), registContentView.width - 20, textFieldHeight)];
    self.pwdPassword.secureTextEntry = YES;
    self.pwdPassword.placeholder = @"重置密码（6-16位数字或字母）";
    self.pwdPassword.font = [UIFont systemFontOfSize:ys_28];
    [self.pwdPassword setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdPassword setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [registContentView addSubview:self.pwdPassword];
    
    //查看隐藏密码按钮
    UIButton *lookPwd = [[UIButton alloc] initWithFrame:CGRectMake(registContentView.width - 20, 0, 30, 30)];
    [lookPwd addTarget:self action:@selector(pwdLookPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    lookPwd.centerY = self.pwdPassword.centerY;
    [lookPwd setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e67d", ys_28, AuxiliaryColor)] forState:UIControlStateNormal];
    [lookPwd setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e67e", ys_28, AuxiliaryColor)] forState:UIControlStateSelected];
    [registContentView addSubview:lookPwd];
    
    UIView *sepaView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pwdPassword.frame), registContentView.width, 1)];
    sepaView3.backgroundColor = SepaViewColor;
    [registContentView addSubview:sepaView3];
    
    registContentView.height = CGRectGetMaxY(registContentView.frame);
    
    //登录按钮
    UIButton *registLogin = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(registContentView.frame) + 25, self.view.width - 30, 40)];
    [registLogin addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    registLogin.layer.cornerRadius = 5;
    registLogin.layer.masksToBounds = YES;
    registLogin.backgroundColor = MainColor;
    [registLogin setTitle:@"确定" forState:UIControlStateNormal];
    [registLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registLogin.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [registView addSubview:registLogin];
    
    //邮箱找回
    UIButton *mailboxButton = [[UIButton alloc] initWithFrame:CGRectMake(registView.width - 100 - 15, CGRectGetMaxY(registLogin.frame) + 5, 100, 30)];
    mailboxButton.tag = 0;
    [mailboxButton addTarget:self action:@selector(mailboxButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    mailboxButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    mailboxButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [mailboxButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
    [mailboxButton setTitle:@"邮箱找回" forState:UIControlStateNormal];
    [registView addSubview:mailboxButton];
}

#pragma mark 邮箱找回
- (void) mailGet
{
    //注册View
    UIView *mailView = [[UIView alloc] initWithFrame:self.view.bounds];
    mailView.hidden = YES;
    self.mailView = mailView;
    [self.view addSubview:mailView];
    
    //中间内容View
    UIView *registContentView = [[UIView alloc] initWithFrame:CGRectMake(15, 25, mailView.width - 30, 55)];
    [mailView addSubview:registContentView];
    
    CGFloat textFieldHeight = 45;
    
    //手机号
    self.mailNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, registContentView.width, textFieldHeight)];
    self.mailNumber.placeholder = @"请输入注册的邮箱";
    self.mailNumber.font = [UIFont systemFontOfSize:ys_28];
    [self.mailNumber setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.mailNumber setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [registContentView addSubview:self.mailNumber];
    
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mailNumber.frame), registContentView.width, 1)];
    sepaView.backgroundColor = SepaViewColor;
    [registContentView addSubview:sepaView];
    
    //登录按钮
    UIButton *registLogin = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(registContentView.frame) + 25, self.view.width - 30, 40)];
    [registLogin addTarget:self action:@selector(mailRegistClick) forControlEvents:UIControlEventTouchUpInside];
    registLogin.layer.cornerRadius = 5;
    registLogin.layer.masksToBounds = YES;
    registLogin.backgroundColor = MainColor;
    [registLogin setTitle:@"确定" forState:UIControlStateNormal];
    [registLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registLogin.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [mailView addSubview:registLogin];
    
    //邮箱找回
    UIButton *mailboxButton = [[UIButton alloc] initWithFrame:CGRectMake(mailView.width - 100 - 15, CGRectGetMaxY(registLogin.frame) + 5, 100, 30)];
    mailboxButton.tag = 1;
    [mailboxButton addTarget:self action:@selector(mailboxButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    mailboxButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    mailboxButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [mailboxButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
    [mailboxButton setTitle:@"手机找回" forState:UIControlStateNormal];
    [mailView addSubview:mailboxButton];
}

#pragma mark 获取验证码
- (void)getMobileCode:(CountDownButton *)button
{
    [self.view endEditing:YES];
    
    if (self.registPhoneNumber.text.length > 0) {
        
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ValidateMobile,[UserInfoTool getUserInfo].token];
        
        NSDictionary *dic = @{@"mobile":self.registPhoneNumber.text};
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
            
            int code = [responseDic[@"rescode"] intValue];
            if (code == 10000) {
                
                int error = [responseDic[@"data"][@"err"] intValue]; //0 可用;1 不可用;
                if (error == 1) {
                    
                    //发送验证码
                    [self sendCode];
                    
                    [button startTime : 140];
                    
                }else
                {
                    [MBProgressHUD showText:responseDic[@"data"][@"msg"] inview:self.view];
                }
            }
        } fail:^(NSError *error) {
            
        }];
    }
}

#pragma mark 发送验证码
- (void) sendCode
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,SendMobileCode,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{@"mobile":self.registPhoneNumber.text};
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        [MBProgressHUD showText:responseDic[@"msg"] inview:self.view];
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark 注册显示隐藏
- (void) pwdLookPwdClick : (UIButton *) button
{
    [self.view endEditing:YES];

    button.selected = !button.selected;
    
    self.pwdPassword.secureTextEntry = !button.selected;
}

#pragma mark 重置确定
- (void) registClick
{
    [self.view endEditing:YES];

    if (self.pwdPassword.text.length == 0 || self.registPhoneNumber.text.length == 0 || self.translate.text.length == 0) {
        return;
    }

    //RSA取得秘钥
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_PASSWORDCODE];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
            NSDictionary *dataX = responseDic[@"data"];
            NSString *pem = dataX[@"pem"];
            
            NSArray *dat = @[self.pwdPassword.text,pem];
            
            [self.bridge callHandler:@"testJavascriptHandler" data:dat responseCallback:^(id responseData) {
                //RSA得到加密后的密码（jS文件中取到）
                NSString *password = [NSString stringWithFormat:@"%@",responseData];
                                
                NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ResetPwdActionByMobile,[UserInfoTool getUserInfo].token];
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"password"] = password;
                dic[@"mobile"] = self.registPhoneNumber.text;
                dic[@"code"] = self.translate.text;
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
                    
                    [MBProgressHUD showText:responseDic[@"data"][@"msg"] inview:self.view];
                    
                    int rescode = [responseDic[@"rescode"] intValue];
                    if (rescode == 10000) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    }
                    
                    
                } fail:^(NSError *error) {
                    
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

#pragma mark 邮箱找回点击
- (void) mailboxButtonClick : (UIButton *) button
{
    [self.view endEditing:YES];

    self.mailView.hidden = button.tag == 1;
    self.registView.hidden = button.tag != 1;
}

#pragma mark 邮箱找回确定
- (void) mailRegistClick
{
    //判断邮箱是否存在
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ValidateEmail,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{@"email":self.mailNumber.text};
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        int error = [responseDic[@"data"][@"err"] intValue];
        if (error == 1) {
        
            NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,SendPwdEmail,[UserInfoTool getUserInfo].token];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"email"] = self.mailNumber.text;
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
                
                [MBProgressHUD showText:responseDic[@"data"][@"msg"] inview:self.view];
                
                int rescode = [responseDic[@"rescode"] intValue];
                if (rescode == 10000) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
                
                
            } fail:^(NSError *error) {
                
            }];
            
        }else
        {
            [MBProgressHUD showText:responseDic[@"data"][@"msg"] inview:self.view];
        }
        
    } fail:^(NSError *error) {
        
    }];
}

@end
