//
//  MineMapViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/9.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "MineMapViewController.h"
#import "JYRadarChart.h"
#import "MJRefresh.h"
#import "CourseSpecialDetailViewController.h"
#import "MineMapModel.h"
#import "AFNetWW.h"
#import "CourseDetailModel.h"
#import "MJExtension.h"
#import "MineMapHeaderview.h"
#import "CourseView.h"
#import "MineMapcellModel.h"
#import "CourseDetailArrayModel.h"
#import "CourseDetailController.h"

@interface MineMapViewController () <UITableViewDelegate,UITableViewDataSource>{
    JYRadarChart *p;
    JYRadarChart *p2;
    UILabel * titleLable;

    NSInteger _index;
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *projectArr;
@property(nonatomic,strong)NSMutableArray *mymapArr;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,strong)NSMutableArray *rowArr;//雷达图btn列表
@property(nonatomic,copy)NSString *finish;
@property(nonatomic,copy)NSString *total;
@end

@implementation MineMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index=0;
    
    self.projectArr = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     __weak typeof (self) weakSelf = self;

    self.title = [ManyLanguageMag getMineMenuStrWith:@"我的地图"];

    [self initJYRadarChart];
    [self.view addSubview:self.tableView];
    [self networkingTitle];
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf networkingTitle];
    }];
    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    self.tableView.mj_footer = footer;
    
}

- (void) loadMoreData
{
    [self networkingProjectWithID:self.ID];
}


-(void)initJYRadarChart{
    
    p = [[JYRadarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH - 40)];
    p.delegate = self;
    
    UIImageView *backimag=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH - 50)];
    backimag.image = [UIImage imageNamed:@"mine_setting_bg"];
    [self.view addSubview:backimag];
    
    titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    titleLable.font=[UIFont systemFontOfSize:14];
    titleLable.textAlignment=NSTextAlignmentCenter;
    titleLable.textColor=[UIColor whiteColor];
    [backimag addSubview:titleLable];
    
    p.y = CGRectGetMaxY(titleLable.frame) + 10;
    
    p.steps = 5;//几条横线
    p.showStepText = YES;//显示每一条的占多少空格
    p.r = SCREEN_WIDTH / 4;//半径
    p.minValue = 0;
    p.maxValue = 100;
    p.fillArea = YES;
    p.colorOpacity = 0.5;
    p.backgroundFillColor = [UIColor blackColor];
    p.showLegend = YES;
    //设置标题已经标题区域的颜色
    p.backgroundColor=[UIColor clearColor];
    
    __weak typeof (self) weakSelf = self;
    
    p.block=^(NSInteger value){//回调
        CourseSpecialDetailViewController *couresedetail=[[CourseSpecialDetailViewController alloc]init];
        
        MineMapModel *model=weakSelf.mymapArr[value];
        couresedetail.ID=[NSString stringWithFormat:@"%ld",(long)model.ID];
        [weakSelf.navigationController pushViewController:couresedetail animated:YES];
    };
    

}
-(void)networkingTitle{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=1",NetHeader,studyMap,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSInteger code=[responseDic[@"rescode"] integerValue];
        if (code==10000) {
            NSArray *row=responseDic[@"rows"];
            
            if(row.count==0){//没有数据
                titleLable.text=@"您暂无地图数据";
            }else{//有数据
                NSDictionary *dic=row[0];
                [self networkingMapWithID:dic[@"id"]];
                [self networkingProjectWithID:dic[@"id"]];
                self.ID=dic[@"id"];
                titleLable.text = dic[@"name"];
                self.finish = dic[@"finish"];
                self.total = dic[@"total"];
            }
        }
        
    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
        
    }];

}


//雷达图btn列表
-(void)networkingMapWithID:(NSString *)ID{
    
     NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&index=0&count=10&id=%@",NetHeader,Projectlist,[UserInfoTool getUserInfo].token,ID];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            self.mymapArr=[NSMutableArray array];
            self.rowArr = responseDic[@"rows"];
            self.mymapArr = (NSMutableArray *)[MineMapModel objectArrayWithKeyValuesArray:self.rowArr];

            NSMutableArray *arry=[NSMutableArray array]; //题目
             NSMutableArray *arryQ=[NSMutableArray array];  //进度
            for(int i=0;i<self.mymapArr.count;i++){
                MineMapModel *model=self.mymapArr[i];
                [arry addObject:model.classesname];

                NSNumber *temp=[NSNumber numberWithInteger:model.progress.intValue+1];
                [arryQ addObject:temp];
            }
            p.attributes =arry;
            p.dataSeries = @[arryQ];
            [self.view addSubview:p];
        }
        
    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
        
    }];

}
/**
 *  待学课程
 *
 *  @param ID 学习地图ID
 */
-(void)networkingProjectWithID:(NSString *)ID{

    NSString *url=[NSString stringWithFormat:@"%@m/studymap/courselist?token=%@&index=%ld&count=10&id=%@",NetHeader,[UserInfoTool getUserInfo].token,_index,ID];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code==10000) {
              NSArray *row=responseDic[@"rows"];
              NSArray *arry=[CourseDetailModel objectArrayWithKeyValuesArray:row];

                if (arry.count == 0) {

                }else{
                    for (int  i=0; i<arry.count; i++) {
                        [self.projectArr addObject:arry[i]];
                    }
                }
             [_tableView reloadData];
        }
        
           _index++;

    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
        
    }];
}


-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,SCREEN_WIDTH - 50, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_WIDTH + 30) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MineMapHeaderview class] forHeaderFooterViewReuseIdentifier:@"section"];
    }
    return _tableView;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (double)100/365*SCREEN_WIDTH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.projectArr.count==0?0:35;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.projectArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IdentifierCell=@"cell";

    CourseView *cell = [tableView dequeueReusableCellWithIdentifier:
                        IdentifierCell];
    if (cell==nil) {
        cell=[[CourseView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.width=self.view.width;
    cell.model=self.projectArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMapcellModel *model = self.projectArr[indexPath.row];
    NSString *courseid =model.chapterid ? model.chapterid:(model.mainid ? model.mainid : model.courseid);
    
    
    NSDictionary *parameter=@{
                              @"chapterid":courseid
                              };
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            NSDictionary *parameter=@{
                                      @"chapterid": courseid
                                      };
            NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDetail,[UserInfoTool getUserInfo].token];
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                NSInteger code=[responseDic[@"rescode"] integerValue];
                if (code == 10000) {
                    
                    CourseDetailArrayModel *courseDetail = [CourseDetailArrayModel objectWithKeyValues:responseDic[@"data"]];
                    NSArray *captions = [CourseDetailModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
                    
                    //到课程详情
                    CourseDetailController *courseDetailVc = [[CourseDetailController alloc] init];
                    courseDetailVc.courseDetail = courseDetail;
                    if (captions.count > 0) {
                        courseDetailVc.captions = captions;
                    }
                    [self.navigationController pushViewController:courseDetailVc animated:YES];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
            }];
        }else if(code == 30030)
        {
            [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

-(UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MineMapHeaderview *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"section"];
    head.contentView.backgroundColor=[UIColor whiteColor];
    head.num=[NSString stringWithFormat:@"%d/%@",[self.total intValue] - [self.finish intValue],self.total];
    return head;
}


#pragma mark  课程点击
-(void)courseclick:(NSInteger )tag{
    
    CourseSpecialDetailViewController *vc = [[CourseSpecialDetailViewController alloc] init];
    MineMapModel *model = self.mymapArr[tag];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
