//
//  CertificateController.m
//  MoveSchool
//
//  Created by edz on 2017/10/27.
//
//

#import "CertificateController.h"
#import "AFNetWW.h"
#import "TBCityIconFont.h"
#import "MainWebController.h"

@interface CertificateController ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *getButton;

@property (nonatomic, strong) UIImageView *titleImage;

@property (nonatomic, strong) UIButton *person;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, copy) NSString *projectid;

@property (nonatomic, copy) NSString *gainExp;

@property (nonatomic, copy) NSString *gainMedal;

@end

@implementation CertificateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"专题证书";
    
    [self setUpData];
}

- (void) setUpData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ClassesCert,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"classesid" : [NSString stringWithFormat:@"%d",self.businessid]
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {

            [self setUpUI];
            
            self.subTitleLabel.text = responseDic[@"data"][@"name"];

            self.projectid = responseDic[@"data"][@"id"];
            self.gainExp = responseDic[@"data"][@"gainExp"];
            self.gainMedal = responseDic[@"data"][@"gainMedal"];
            
            if ([responseDic[@"data"][@"status"] intValue] == 0) { //
                self.titleLabel.text = @"您还没有学习，无法获得证书，赶快去学习吧！";
                self.getButton.selected = NO;
                self.getButton.layer.borderColor = AuxiliaryColor.CGColor;
                self.titleImage.image = [UIImage imageNamed:@"zhengshu_bg"];
                [self.person setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e67b", 81, AuxiliaryColor)] forState:UIControlStateNormal];
                self.subTitleLabel.textColor = AuxiliaryColor;
            }else if([responseDic[@"data"][@"status"] intValue] == 1)
            {
                self.titleLabel.text = @"恭喜您，获得证书!";
                self.getButton.selected = YES;
                self.getButton.layer.borderColor = [UIColor whiteColor].CGColor;
                self.titleImage.image = [UIImage imageNamed:@"zhengshu_bg_highlight"];
                [self.person setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e67b", 81, MainColor)] forState:UIControlStateNormal];
                self.subTitleLabel.textColor = MainTextColor;
            }else if([responseDic[@"data"][@"status"] intValue] == 2)
            {
                self.titleLabel.text = @"恭喜您，获得证书!";
                self.getButton.layer.borderColor = [UIColor whiteColor].CGColor;
                self.titleImage.image = [UIImage imageNamed:@"zhengshu_bg_highlight"];
                [self.person setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e67b", 81, MainColor)] forState:UIControlStateNormal];
                [self.getButton setTitle:@"查看证书" forState:UIControlStateNormal];
                [self.getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.getButton.selected = NO;
            }
        }

    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

- (void) setUpUI
{

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainSpacing15, 25, self.view.width - 2 * mainSpacing15, mainSpacing15)];
    self.titleLabel = titleLabel;
    titleLabel.textColor = AuxiliaryColor;
    titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [self.view addSubview:titleLabel];
    
    //证书
    UIView *certificateView = [[UIView alloc] initWithFrame:CGRectMake(mainSpacing15, CGRectGetMaxY(titleLabel.frame) + mainSpacing15, self.view.width - 2 * mainSpacing15, 152)];
    certificateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:certificateView];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, certificateView.width, 35)];
    self.titleImage = titleImage;
    titleImage.image = [UIImage imageNamed:@"zhengshu_bg"];
    [certificateView addSubview:titleImage];
    
    //领取
    UIButton *getButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 25)];
    self.getButton = getButton;
    getButton.adjustsImageWhenHighlighted = NO;
    [getButton addTarget:self action:@selector(getButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    getButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    getButton.centerY = titleImage.centerY;
    getButton.x = certificateView.width - 15 - 75;
    [getButton setTitle:@"未领取" forState:UIControlStateNormal];
    [getButton setTitle:@"领取证书" forState:UIControlStateSelected];
    [getButton setTitle:@"领取证书" forState:UIControlStateSelected | UIControlStateHighlighted];
    [getButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
    [getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    getButton.layer.borderColor = AuxiliaryColor.CGColor;
    getButton.layer.borderWidth = 0.5;
    getButton.layer.cornerRadius = 1.5;
    getButton.layer.masksToBounds = YES;
    [certificateView addSubview:getButton];
    
    UIButton *person = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleImage.frame), 95, certificateView.height - CGRectGetMaxY(titleImage.frame))];
    self.person = person;
    [certificateView addSubview:person];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(person.frame) + mainSpacing15, person.y, certificateView.width - CGRectGetMaxX(person.frame) - mainSpacing15 * 2, person.height)];
    self.subTitleLabel = subTitleLabel;
    subTitleLabel.font = [UIFont systemFontOfSize:ys_28];
    [certificateView addSubview:subTitleLabel];


}

- (void) getButtonClick : (UIButton *) button
{

    if ([button.titleLabel.text isEqualToString:@"领取证书"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CertReceive,[UserInfoTool getUserInfo].token];
        
        [MBProgressHUD showMessage:@"正在领取，请稍后" toView:[UIApplication sharedApplication].keyWindow];

        
        NSDictionary *dic=@{
                            @"projectid" : self.projectid,
                            @"exp" : self.gainExp,
                            @"medal" : self.gainMedal
                            };
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
            
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

            int rescode = [responseDic[@"rescode"] intValue];
            if (rescode == 10000) {
               
                [self.getButton setTitle:@"查看证书" forState:UIControlStateNormal];
                [self.getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.getButton.selected = NO;
                
                NSString *uelStr = [NSString stringWithFormat:@"%@%@?certid=%d&type=0",NetHeader,CertContent,self.businessid];
                
                MainWebController *vc = [[MainWebController alloc] init];
                vc.url = uelStr;
                vc.webTitle = @"证书";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        } fail:^(NSError *error) {

            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

            [MBProgressHUD showError:@"发送请求失败"];
        }];
    }else if ([button.titleLabel.text isEqualToString:@"查看证书"])
    {
    
        NSString *uelStr = [NSString stringWithFormat:@"%@%@?certid=%d&type=0",NetHeader,CertContent,self.businessid];
        
        MainWebController *vc = [[MainWebController alloc] init];
        vc.url = uelStr;
        vc.webTitle = @"证书";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
