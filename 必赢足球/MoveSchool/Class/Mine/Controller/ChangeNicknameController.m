//
//  ChangeNicknameController.m
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import "ChangeNicknameController.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"

@interface ChangeNicknameController ()

@property (nonatomic, strong) UITextField *phoneNumber;

@end

@implementation ChangeNicknameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改昵称";
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    
    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
    self.phoneNumber = phoneNumber;
    [phoneNumber setLefSpacing:15];
    phoneNumber.backgroundColor = [UIColor whiteColor];
    phoneNumber.placeholder = @"请输入昵称";
    phoneNumber.font = [UIFont systemFontOfSize:ys_28];
    [phoneNumber setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [phoneNumber setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:phoneNumber];
    
    if (self.name.length > 0) {
        phoneNumber.text = self.name;
    }
}

- (void) send
{
    if (self.phoneNumber.text.length == 0) {
        return;
    }
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ChangeKeyValue,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid":[UserInfoTool getUserInfo].ID,
                        @"businesscode":@"10000",
                        @"key":@"nickname",
                        @"value":self.phoneNumber.text
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             if ([self.delegate respondsToSelector:@selector(changeNickname:)]) {
                 [self.delegate changeNickname:self.phoneNumber.text];
             }
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
             });
         }
         
     }fail:^(NSError *error) {
         
     }];
}

@end
