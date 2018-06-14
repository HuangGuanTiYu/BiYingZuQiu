//
//  SettingCriticismsFeedbackViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/3.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "SettingCriticismsFeedbackViewController.h"
#import "LanguageSettingViewController.h"
#import "ColorTypeTools.h"
#import "AFNetWW.h"
#import "AdviseModel.h"
#import "ReleaseStudyController.h"
#import "MJExtension.h"
#import "MainWebController.h"
#import "SettingCell.h"
#import "QuestionController.h"

@interface SettingCriticismsFeedbackViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableViewArr;
@end

@implementation SettingCriticismsFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNet];
    [self setNav];
}

-(void)advClick{//意见反馈
    
    ReleaseStudyController *vc=[[ReleaseStudyController alloc] init];
    vc.releaseStudy = NO;
    [self.navigationController pushViewController:vc animated:1];
}

-(void)setNet{
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,Advice];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue]==10000) {
            NSArray *row=responseDic[@"rows"];
            NSArray *tempArr = [AdviseModel objectArrayWithKeyValuesArray:row];
            
            self.tableViewArr = tempArr;
            [self.view addSubview:self.tableView];
        }
    
    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];

}
-(void)setNav{
    self.title = [ManyLanguageMag getSettingStrWith:@"帮助反馈"];
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"提问" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AdviseModel *model = self.tableViewArr[indexPath.row];
    
    static NSString *ID = @"SettingCell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.title = model.title;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    AdviseModel *model = self.tableViewArr[indexPath.row];
    
    MainWebController *vc = [[MainWebController alloc] init];
    vc.webTitle = model.title;
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)tabViewRefresh{

    if (!self.tableViewArr) {
  
        [self setNet];
        
    }else{
        [self.tableView reloadData];
    }

}

#pragma 懒加载
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (void) send
{

    QuestionController *questionVc = [[QuestionController alloc] init];
    [self.navigationController pushViewController:questionVc animated:YES];
}

@end
