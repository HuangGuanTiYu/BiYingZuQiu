
//
//  LanguageSettingViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/29.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "LanguageSettingViewController.h"
#import "SetingViewController.h"
#import "LanguageSettingViewController.h"
#import "MBProgressHUD.h"
#import "ColorTypeTools.h"

@interface LanguageSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableViewArr;

@end

@implementation LanguageSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CheckIN];//纪录语言设置
    self.title = [ManyLanguageMag getSettingStrWith:@"语言选择"];

    [self.view addSubview:self.tableView];
    
}
-(void)CheckIN{
    NSIndexPath *index=[[NSUserDefaults standardUserDefaults] objectForKey:@"ChectIn"];
    if (!index) {
        NSIndexPath *indexX=[NSIndexPath indexPathForRow:0 inSection:0];
        _selIndex=indexX;
    }else{
        self.selIndex=index;
    }
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
    cell.textLabel.text=self.tableViewArr[indexPath.row];

    NSString *row=  [[NSUserDefaults  standardUserDefaults] objectForKey:@"manylanguage"];
    if (row.integerValue == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"manylanguage"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *temp=[NSString stringWithFormat:@"%@%@,%@",[ManyLanguageMag getSettingStrWith:@"设置成功"],cell.textLabel.text,[ManyLanguageMag getSettingStrWith:@"建议重启app"]];
    [MBProgressHUD showText:temp inview:self.view];
    
    self.title = [ManyLanguageMag  getSettingStrWith:@"语言选择"];
    [self.tableView reloadData];
}

#pragma mark 懒加载
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//不显示cell的分割线
    }
    return _tableView;
}

-(NSArray *)tableViewArr{
    if (!_tableViewArr) {
        _tableViewArr=@[@"中文简体",@"English",@"한국어",@"日本語",@"De Nederlandse"];
    }
    return _tableViewArr;
}


@end

