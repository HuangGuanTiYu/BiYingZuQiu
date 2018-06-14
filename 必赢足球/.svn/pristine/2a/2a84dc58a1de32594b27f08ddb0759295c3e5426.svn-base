//
//  MineStudyZhuantiViewController.m
//  Main
//
//  Created by yuhongtao on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MineStudyZhuantiViewController.h"
#import "AFNetWW.h"
#import "MJRefresh.h"
#import "CourseSpecialModel.h"
#import "MJExtension.h"
#import "CourseSpecialViewCell.h"
#import "CourseSpecialDetailViewController.h"

@interface MineStudyZhuantiViewController ()<UITableViewDelegate, UITableViewDataSource>

//专题列表
@property(nonatomic, strong) UITableView *speciaList;

//专题程数组
@property(nonatomic,strong) NSMutableArray *speciaArray;

//分页索引值
@property(nonatomic, assign) int index;

//是否是 加载更多
@property(nonatomic, assign) BOOL isMoreData;

@end

@implementation MineStudyZhuantiViewController

- (instancetype)initWithType : (int) type
{
    self = [super init];
    if (self) {
        self.ZhuantiSourceType = type;
        
        //获取专题列表
        if (self.ZhuantiSourceType == ZhuantiSourceStudy) {
            [self getSpecialList : @"0"];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
        {
            [self getCollectionZhuantiList];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
            [self getSpecialList : self.zttid];
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    
    self.speciaArray = [NSMutableArray array];
    
    //获取专题列表
    if (self.ZhuantiSourceType == ZhuantiSourceStudy) {
        [self getSpecialList : @"0"];
    }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
    {
        [self getCollectionZhuantiList];
    }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
        [self getSpecialList : self.zttid];
    }
    
    [self setUpUI];
}

#pragma mark 获取我的收藏专题列表
- (void) getCollectionZhuantiList
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=%@&count=10&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,@(self.index),specialType];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *all=[NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"专题"],responseDic[@"data"][@"all"]];
            self.pageTitle = all;
            
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.speciaArray addObjectsFromArray:(NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.speciaArray = (NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.speciaList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部专题"];
            }
            
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 获取专题列表
- (void) getSpecialList : (NSString *) zttid
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=%@&count=10&zttid=%@",NetHeader,SpecialListX,[UserInfoTool getUserInfo].token,@(self.index),zttid];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *all=[NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"专题"],responseDic[@"data"][@"all"]];
            self.pageTitle = all;
            
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.speciaArray addObjectsFromArray:(NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.speciaArray = (NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.speciaList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部专题"];
            }
            
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

- (void) setUpUI
{
    self.speciaList = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.speciaList.height = self.view.height - 41 - 64;
    self.speciaList.delegate = self;
    self.speciaList.dataSource = self;
    self.speciaList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.speciaList.showsHorizontalScrollIndicator = NO;
    self.speciaList.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.speciaList];
    
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    self.speciaList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isMoreData = NO;
        weakSelf.index = 0;
        //获取专题列表
        if (weakSelf.ZhuantiSourceType == ZhuantiSourceStudy) {
            [weakSelf getSpecialList : @"0"];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
        {
            [weakSelf getCollectionZhuantiList];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
            [weakSelf getSpecialList : self.zttid];
        }
    }];
    
    // 上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.speciaList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isMoreData = YES;
        ++weakSelf.index;
        //获取专题列表
        if (weakSelf.ZhuantiSourceType == ZhuantiSourceStudy) {
            [weakSelf getSpecialList : @"0"];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
        {
            [weakSelf getCollectionZhuantiList];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
            [weakSelf getSpecialList : self.zttid];
        }
    }];
    
}

#pragma tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.speciaArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Id=@"cell";
    
    CourseSpecialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[CourseSpecialViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    
    CourseSpecialModel *tempModel = self.speciaArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = tempModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.width * 0.4 + 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    CourseSpecialModel *tempModel = self.speciaArray[indexPath.row];
    CourseSpecialDetailViewController *vc = [[CourseSpecialDetailViewController alloc] init];
    vc.tempModel = tempModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.pageTitle;
}

@end


