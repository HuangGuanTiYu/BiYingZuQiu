//
//  CourseStudyViewControllerX.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/29.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "CourseStudyViewControllerX.h"
#import "SetingViewController.h"
#import "ColorTypeTools.h"
#import "AFNetWW.h"
#import "CourseStudyListModel.h"
#import "SearchViewControllerX.h"
#import "MJExtension.h"
#import "MineStudyCourseViewController.h"

@interface CourseStudyViewControllerX ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableViewArr;

@end

@implementation CourseStudyViewControllerX

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self netWork];
    
}

-(void)netWork{
    
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&locale=%@",NetHeader,StudyLi,[UserInfoTool getUserInfo].token,[ManyLanguageMag getTypeWithWebDiscript]];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        if ([responseDic[@"rescode"] intValue]==10000) {
            NSArray *row=responseDic[@"rows"];
            NSArray *tempArr= [CourseStudyListModel objectArrayWithKeyValuesArray:row];
            self.tableViewArr = tempArr;
            [self.view addSubview:self.tableView];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}
-(void)setNav{
    self.title = [ManyLanguageMag gethCourseStrWith:@"学习"];
    
    self.navigationItem.rightBarButtonItem = [ColorTypeTools itemWithImageName:@"common_search_red" highImageName:@"" addTarget:self action:@selector(searchClick)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return self.tableViewArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CourseStudyListModel *model=self.tableViewArr[indexPath.row];
    model.name = [model.name stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    cell.textLabel.text= model.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.textLabel.textColor=kColorGray154;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
    lbl.frame = CGRectMake(cell.frame.origin.x, cell.frame.size.height - 1, 1000, 1);
    lbl.backgroundColor = kColorGray240;
    [cell.contentView addSubview:lbl];
    
    if (indexPath.row==0) {
        cell.textLabel.textColor = GreenColor;
        
        UIView *lb = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lb.frame = CGRectMake(cell.frame.origin.x , 0, cell.frame.size.width, 1);
        lb.backgroundColor = kColorGray240;
        [cell.contentView addSubview:lb];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseStudyListModel *model = self.tableViewArr[indexPath.row];

    MineStudyCourseViewController *courseVc = [[MineStudyCourseViewController alloc] init];
    courseVc.CourseSourceType = CourseSourceCourseStudy;
    courseVc.instname = model.ID;
    courseVc.courseName = [model.name stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    [self.navigationController pushViewController:courseVc animated:YES];
    
}

#pragma mark 懒加载
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//不显示cell的分割线
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

-(NSArray *)tableViewArr{
    
    if (!_tableViewArr) {
        _tableViewArr=[NSMutableArray array];
    }
    return _tableViewArr;
    
}

-(void)searchClick{
    SearchViewControllerX *vc=[[SearchViewControllerX alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
