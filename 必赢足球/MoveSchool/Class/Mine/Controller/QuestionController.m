//
//  QuestionController.m
//  MoveSchool
//
//  Created by edz on 2017/9/18.
//
//

#import "QuestionController.h"
#import "IQTextView.h"
#import "AFNetWW.h"

@interface QuestionController ()<UITextViewDelegate>

@property(nonatomic, strong) IQTextView *textView;

@end

@implementation QuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"提问";
    
    //输入框
    self.textView = [[IQTextView alloc] initWithFrame:self.view.bounds];
    self.textView.placeholder = @"请输入您的问题？";
    self.textView.textColor = MainTextColor;
    self.textView.delegate = self;
    self.textView.height = 210;
    self.textView.font = [UIFont systemFontOfSize:ys_28];
    [self.view addSubview:self.textView];
    
    //登录按钮
    UIButton *registLogin = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.textView.frame) + 30, self.view.width - 30, 40)];
    [registLogin addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    registLogin.layer.cornerRadius = 5;
    registLogin.layer.masksToBounds = YES;
    registLogin.backgroundColor = MainColor;
    [registLogin setTitle:@"提交" forState:UIControlStateNormal];
    [registLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registLogin.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [self.view addSubview:registLogin];
}

- (void) registClick
{
    
    [self.textView resignFirstResponder];
    [MBProgressHUD showMessage:@"正在提交，请稍后" toView:[UIApplication sharedApplication].keyWindow];

    
    if (self.textView.text.length == 0) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ZttFeedBack,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"content" : self.textView.text
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
        
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"提交成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
            
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

        [MBProgressHUD showError:@"发送请求失败"];
    }];
    
}

@end
