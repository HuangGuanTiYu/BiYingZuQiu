//
//  RankingController.m
//  MoveSchool
//
//  Created by edz on 2017/10/27.
//
//

#import "RankingController.h"
#import "AFNetWW.h"
#import "RankModel.h"
#import "MJExtension.h"
#import "RankCell.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "RankCell.h"

@interface RankingController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, assign) int index;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UILabel *subtitleLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, assign) BOOL isMoreData;


@end

@implementation RankingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.index = 0;
    
    self.datas = [NSMutableArray array];
    
    [self setUpUI];
    
    [self setUpData];
}

- (void) setUpData
{

    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,classesRank,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"classesid" : [NSString stringWithFormat:@"%d",self.businessid],
                        @"index" : [NSString stringWithFormat:@"%d",self.index],
                        @"count" : @"10"
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
            NSArray *models = [RankModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
            
            if (models.count > 0) {
                if (self.isMoreData) {
                    [self.datas addObjectsFromArray:models];
                    
                }else
                {
                    self.datas = (NSMutableArray *)models;
                }
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_footer endRefreshing];
            
            RankModel *model = [RankModel objectWithKeyValues:responseDic[@"data"]];
            
            if (model == nil || model.userid == 0) { //没有排名
                self.subtitleLabel.text = @"还没有累计学习时长哦";
                self.titleLabel.text = @"您还没有排名，赶快去学习吧~";
            }else
            {
                self.subtitleLabel.text = [NSString stringWithFormat:@"%@",model.showDuration];
                NSString *allString = [NSString stringWithFormat:@"%@\n%@",model.ranking,model.nickname];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21] range:[allString rangeOfString:model.ranking]];
                self.titleLabel.attributedText = string;
            }
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

- (void) setUpUI
{
    
    self.title = @"排行榜";
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];

    //背景图
    UIImageView *bjImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 141)];
    bjImage.image = [UIImage imageNamed:@"paihangbang_bg_top"];
    [headerView addSubview:bjImage];
    
    //虚线
    UIView *dottedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
    dottedView.alpha = 0.6;
    dottedView.centerX = self.view.width * 0.5;
    dottedView.centerY = bjImage.centerY;
    [headerView addSubview:dottedView];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = [UIColor whiteColor].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:dottedView.bounds].CGPath;
    
    border.frame = dottedView.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    [dottedView.layer addSublayer:border];
    
    //文字描述
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:dottedView.frame];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    titleLabel.y = dottedView.y - 5;
    titleLabel.width = dottedView.width - 2 * mainSpacing;
    titleLabel.centerX = dottedView.centerX;
    titleLabel.height = dottedView.height + 5;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:ys_f24];
    titleLabel.text = @"您还没有排名，赶快去学习吧~";
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    //副标题
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) - 10, titleLabel.width + 50, 20)];
    self.subtitleLabel = subtitleLabel;
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.centerX = titleLabel.centerX;
    subtitleLabel.backgroundColor = [UIColor whiteColor];
    subtitleLabel.layer.cornerRadius = 10;
    subtitleLabel.layer.masksToBounds = YES;
    subtitleLabel.text = @"还没有累计学习时长哦";
    subtitleLabel.textColor = MainColor;
    subtitleLabel.font = [UIFont systemFontOfSize:ys_f24];
    [headerView addSubview:subtitleLabel];
    
    headerView.height = CGRectGetMaxY(bjImage.frame) + mainSpacing15;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView = tableView;
    tableView.tableHeaderView = headerView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    __weak __typeof(self) weakSelf = self;
    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    tableView.mj_footer = footer;

}

- (void) loadMoreData
{
    self.isMoreData = YES;
    ++self.index;
    [self setUpData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"RankCell";
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[RankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    RankModel *model = self.datas[indexPath.row];
    cell.model = model;
    if (indexPath.row == 0) {
        cell.crownImage.hidden = NO;
    }else
    {
        cell.crownImage.hidden = YES;
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

@end
