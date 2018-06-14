//
//  ChangeMobileController.m
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import "ChangeMobileController.h"
#import "CountDownButton.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"
#import "UIButton+Extension.h"

@interface ChangeMobileController ()<CountDownButtonDelegate>

@property (nonatomic, strong) UITextField *registPhoneNumber;

@property (nonatomic, strong) UITextField *translate;

@end

@implementation ChangeMobileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改手机号";
    
    //手机号
    UITextField *registPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
    self.registPhoneNumber = registPhoneNumber;
    [registPhoneNumber setLefSpacing:15];
    registPhoneNumber.backgroundColor = [UIColor whiteColor];
    registPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    registPhoneNumber.placeholder = @"请输入手机号";
    registPhoneNumber.font = [UIFont systemFontOfSize:ys_28];
    [registPhoneNumber setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [registPhoneNumber setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:registPhoneNumber];
    
    if ([UserInfoTool getUserInfo].mobile.length > 0) {
        registPhoneNumber.text = [UserInfoTool getUserInfo].mobile;
    }
    
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(registPhoneNumber.frame) - 0.5, self.view.width - 15, 0.5)];
    sepaView.backgroundColor = SepaViewColor;
    [self.view addSubview:sepaView];
    
    //验证码
    UITextField *translate = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), self.view.width, 45)];
    self.translate = translate;
    [translate setLefSpacing:15];
    translate.backgroundColor = [UIColor whiteColor];
    translate.secureTextEntry = YES;
    translate.placeholder = @"验证码";
    translate.font = [UIFont systemFontOfSize:ys_28];
    [translate setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [translate setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:translate];
    
    //倒计时按钮
    CountDownButton *coutDown = [[CountDownButton alloc] initWithFrame:CGRectMake(self.view.width - 110, 0, 100, 45)];
    coutDown.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [coutDown setTitleColor:MainColor forState:UIControlStateNormal];
    [coutDown setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    coutDown.delegate = self;
    coutDown.centerY = translate.centerY;
    [self.view addSubview:coutDown];
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
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
                if (error == 0) {
                    
                    //发送验证码
                    [self sendCode];
                    
                    [button startTime : 125];
                    
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

- (void) send
{
    if (self.registPhoneNumber.text.length == 0) {
        return;
    }
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ChangeKeyValue,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid":[UserInfoTool getUserInfo].ID,
                        @"businesscode":@"10000",
                        @"key":@"mobile",
                        @"value":self.registPhoneNumber.text,
                        @"authcode" : self.translate.text
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             if ([self.delegate respondsToSelector:@selector(changeMobile:)]) {
                 [self.delegate changeMobile:self.registPhoneNumber.text];
             }
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
             });
         }
         
     }fail:^(NSError *error) {
         
     }];
}

@end
