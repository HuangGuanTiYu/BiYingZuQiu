//
//  FindController.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/18.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "FindController.h"
#import "UIBarButtonItem+Extension.h"
#import "FindCell.h"
#import "FindModel.h"
#import "InformationController.h"
#import "AFNetWW.h"
#import "FindClassifyModel.h"
#import "MJExtension.h"
#import "CourseController.h"
#import "LiveListController.h"
#import "TeacherController.h"
#import "SalonController.h"
#import "SpecialController.h"
#import "SearchResultController.h"
#import "VideoController.h"

@interface FindController ()<UICollectionViewDelegate, UICollectionViewDataSource, FindCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation FindController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
    self.models = [NSMutableArray array];
    
    FindModel *model = [[FindModel alloc] init];
    model.title = @"资讯";
    model.imageText = @"find_zixun";
    [self.models addObject:model];
    
    FindModel *model1 = [[FindModel alloc] init];
    model1.title = @"课程";
    model1.imageText = @"find_kecheng";
    [self.models addObject:model1];
    
    FindModel *model2 = [[FindModel alloc] init];
    model2.title = @"直播";
    model2.imageText = @"find_zhibo";
    [self.models addObject:model2];
    
    FindModel *model3 = [[FindModel alloc] init];
    model3.title = @"讲师";
    model3.imageText = @"find_jiangshi";
    [self.models addObject:model3];
    
    FindModel *model4 = [[FindModel alloc] init];
    model4.title = @"沙龙";
    model4.imageText = @"find_shalong";
    [self.models addObject:model4];
    
    FindModel *model5 = [[FindModel alloc] init];
    model5.title = @"专题";
    model5.imageText = @"find_zhuanti";
    [self.models addObject:model5];
    
    FindModel *model6 = [[FindModel alloc] init];
    model6.title = @"音频";
    model6.imageText = @"find_yinping";
    [self.models addObject:model6];
}
- (void) setUpUI
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e627" target:self selector:@selector(test) imageColor:[UIColor whiteColor] imageFont:18];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = ViewBackColor;
    _collectionView.height = self.view.height - 64 - 49;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[FindCell class] forCellWithReuseIdentifier:@"FindCell"];
    
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 2.5;
    cell.layer.masksToBounds = YES;
    
    FindModel *model = self.models[indexPath.row];
    cell.model = model;
    return cell;
}


//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellSize = (self.view.width - 15 * 2 - mainSpacing) * 0.5;
    return CGSizeMake(cellSize, cellSize);
}

// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void) test
{
    SearchResultController *searchVc = [[SearchResultController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark 按钮点击
- (void)findCellClick:(FindCell *)cell
{
    NSInteger row = [self.collectionView indexPathForCell:cell].row;
    
    //资讯
    if (row == 0) {
        [self getTag:NO];
    }else
    //课程
    if (row == 1)
    {
        [self getTag:YES];
    }else
    //直播
    if(row == 2){
        [self getLiveList];
    }
    //讲师
    if (row == 3) {
        [self getTeacherList];
    }
    //沙龙
    if (row == 4) {
        [self getSalonList];
    }
    //专题
    if (row == 5) {
        [self getSpecialList];
    }
    //音频
    if (row == 6) {
        [self getVideoList];
    }
}

#pragma mark 拉取标签
//isCourse 是否是课程，或是资讯
- (void) getTag : (BOOL) isCourse
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&token=%@&businesscode=%@",NetHeader,GetLabelClassList,[UserInfoTool getUserInfo].token,isCourse ? courseType : newsType];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *classifys = [FindClassifyModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
             if (isCourse) {
                 CourseController *courseVc = [[CourseController alloc] init];
                 courseVc.classifys = classifys;
                 [self.navigationController pushViewController:courseVc animated:YES];
             }else
             {
                 InformationController *informationVc = [[InformationController alloc] init];
                 informationVc.classifys = classifys;
                 [self.navigationController pushViewController:informationVc animated:YES];
             }
         }
         
     }fail:^(NSError *error) {
         
     }];
}

#pragma mark 获取讲师列表
- (void) getTeacherList
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetTeacherSort,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             NSArray *classifys = [FindClassifyModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
             TeacherController *teacherVc = [[TeacherController alloc] init];
             teacherVc.classifys = classifys;
             [self.navigationController pushViewController:teacherVc animated:YES];
         }
         
     }fail:^(NSError *error) {

     }];
}


#pragma mark 获取直播列表
- (void) getLiveList
{
    LiveListController *liveVc = [[LiveListController alloc] init];
    [self.navigationController pushViewController:liveVc animated:YES];
}

#pragma mark 获取沙龙列表
- (void) getSalonList
{
    SalonController *shalongVc = [[SalonController alloc] init];
    [self.navigationController pushViewController:shalongVc animated:YES];
}

#pragma mark 获取专题
- (void) getSpecialList
{
    SpecialController *specVc = [[SpecialController alloc] init];
    [self.navigationController pushViewController:specVc animated:YES];
}

- (void) getVideoList
{
    VideoController *specVc = [[VideoController alloc] init];
    [self.navigationController pushViewController:specVc animated:YES];
}

@end
