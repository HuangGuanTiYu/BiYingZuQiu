//
//  SpecialViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/6/27.
//  Copyright © 2016年 caobohua. All rights reserved.
//  course四大按钮之一专题

#import "SpecialViewController.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "AFNetWW.h"
#import "MBProgressHUD.h"
#import "CourseSpecialModel.h"
#import "CourseSpecialViewCell.h"
#import "UIView+Extension.h"
#import "CourseSpecialDetailViewController.h"
#import "ColorTypeTools.h"
#import "AFNetWW.h"

@interface SpecialViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property(nonatomic,strong)NSArray *rowArr;
@property(nonatomic,strong)NSArray *dicArr;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation SpecialViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self netWorking];
    [self setNavigation];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;

    }
    return _tableview;

}
- (void)setNavigation {
    
    self.title = [ManyLanguageMag gethCourseStrWith:@"专题"];
}

-(void)netWorking{
 
    NSString *token = [UserInfoTool getUserInfo].token;
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=10",NetHeader,SpecialList,token];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        self.dicArr = responseDic[@"rows"];
        self.rowArr = [CourseSpecialModel objectArrayWithKeyValuesArray:self.dicArr];
        
        if (self.rowArr.count==0) {
            self.view.backgroundColor=[UIColor whiteColor];
            
            UIWebView *webView=[[UIWebView alloc]initLineWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
            webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            [self.view addSubview:webView];
            NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NetHeader,NOContent]];//创建URL
            NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
            webView.delegate=self;
            [webView loadRequest:request];//加载
            
        }else{
            [self.view addSubview:self.tableview];

        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.rowArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Id = @"cell";
    
    CourseSpecialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    
    if (!cell) {
        cell=[[CourseSpecialViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    CourseSpecialModel *tempModel = self.rowArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = tempModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return self.view.width * 0.4 + mainSpacing;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    CourseSpecialModel *tempModel=self.rowArr[indexPath.row];
    
    CourseSpecialDetailViewController *vc = [[CourseSpecialDetailViewController alloc] init];
    vc.tempModel = tempModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
