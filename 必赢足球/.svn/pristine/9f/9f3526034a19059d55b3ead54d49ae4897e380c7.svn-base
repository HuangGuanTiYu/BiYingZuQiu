//
//  CourseViewControllerX.m
//  zhitongti
//
//  Created by edz on 2016/12/14.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "CourseViewControllerX.h"
#import "MultileHeadView.h"
#import "SCSearchBar.h"
#import "CourseHeaderTwo.h"
#import "ZttApp.h"
#import "CourseCollectioncell.h"
#import "AFNetWW.h"
#import "CourseDetailArrayModel.h"
#import "CourseDetailModel.h"
#import "MJExtension.h"
#import "CourseDetailController.h"
#import "SearchViewControllerX.h"
#import "MainWebController.h"
#import "CourseSpecialDetailViewController.h"
#import "AppDelegate.h"
#import "SpecialViewController.h"
#import "CourseStudyViewControllerX.h"

#define lunbotuH (double)120/667*kSize.height
#define fastbtnH (double)120/667*kSize.height
#define kSize [[UIScreen mainScreen] bounds].size
#define HeaderH_One 240
#define HeaderH_Two 50
#define ItemH  (kSize.width-40)*9/32+10+10+30+10


@interface CourseViewControllerX ()<UICollectionViewDataSource,UICollectionViewDelegate,CourseHeaderTwoSelectDelegate,MultileHeadViewSelectDelegate,UIWebViewDelegate,UIScrollViewDelegate,GoToInfoViewControllerProtocol,UITextFieldDelegate>{
    NSInteger _indexOne;
    NSInteger _indexTwo;
    NSTimer * _timer;
}

@property(nonatomic,strong)SCSearchBar *searchBar;

@property(strong,nonatomic ) UICollectionView * rightCollection;

@property(nonatomic,strong)NSArray * hotCourseArr;
@property(nonatomic,strong)NSArray * guessLikeArr;
@property(nonatomic,copy)NSString  * AFinir;
@property(nonatomic,copy)NSString  * BFinir;

@property(nonatomic, strong) id responseDic;

@end

@implementation CourseViewControllerX

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor=kColorGray240;
    _searchBar = [[SCSearchBar alloc] init];
    _searchBar.delegate = self;
    CGFloat height = 30;
    _searchBar.frame = CGRectMake(0, 0, kSize.width-20, height);
    
    _searchBar.placeholder = [ManyLanguageMag gethCourseStrWith:@"请输入要搜索的关键词"];

    _searchBar.backgroundColor=[UIColor grayColor];
    _searchBar.layer.cornerRadius=height/2;
    _searchBar.layer.masksToBounds=YES;
    _searchBar.returnKeyType =UIReturnKeySearch;
    self.navigationItem.titleView=_searchBar;
    
    self.title=[ManyLanguageMag gethCourseStrWith:@"课程"];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent=NO;
    //未观看完课程提示视图
    
    UIView *viE=[[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.width, 1)];
    viE.backgroundColor=kColorGray225;
    [self.navigationController.navigationBar addSubview:viE];
    [self CourseNOSeeView];
    
    _indexOne=0;
    _indexTwo=0;
    [self networking];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直滚动
    flowLayout.minimumInteritemSpacing=0;//左右间隔
    flowLayout.minimumLineSpacing=0;
    
    self.rightCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(0,0,kSize.width,kSize.height) collectionViewLayout:flowLayout];
    
    self.rightCollection.backgroundColor=kColorGray240;
    self.rightCollection.delegate=self;
    self.rightCollection.dataSource=self;
    [self.rightCollection registerClass:[CourseCollectioncell class] forCellWithReuseIdentifier:@"CourseCollectioncell"];
    [self.view addSubview:self.rightCollection];
    
    self.rightCollection.showsVerticalScrollIndicator = NO;
    
    //  注册
    [self.rightCollection registerClass:[MultileHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MultileHeadView"];
    [self.rightCollection registerClass:[CourseHeaderTwo class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CourseHeaderTwo"];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.translucent = YES;

    self.title = [ManyLanguageMag gethCourseStrWith:@"课程"];
    _searchBar.placeholder =[ManyLanguageMag gethCourseStrWith:@"请输入要搜索的关键词"];
    
}

-(void)CourseNOSeeView{
    
    NSString *chapterID = [SCUSER_DEFAULT objectForKey:@LOcaalVidioRecord]; //章节ID
    NSString *viidiID = [SCUSER_DEFAULT objectForKey:@LOcaalchapteridRecord];  //视频套ID
    
    if (viidiID && chapterID) {
    
        NSString *token;
        if([UserInfoTool getUserInfo].token == nil){
            token = @"";
        }else{
            token = [UserInfoTool getUserInfo].token;
        }
        
        NSDictionary *parameter=@{
                                  @"chapterid":chapterID
                                  };
        NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
            
            NSInteger code=[responseDic[@"rescode"] integerValue];

            if (code == 10000) {
                NSDictionary *parameter=@{
                                          @"token":token,
                                          @"chapterid":chapterID
                                          };
                NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,CourseDetail];
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                    NSInteger code = [responseDic[@"rescode"] integerValue];
                    NSDictionary *data = responseDic[@"data"];
                    self.responseDic = responseDic;
                    
                    if (code==10000) {
                        
                        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-90-64, self.view.width, 45)];
                        [btn setBackgroundColor:RGBACOLOR(7, 12, 26, 0.6)];
                        [btn addTarget:self action:@selector(GoONStudy) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:btn];
                        
                        UILabel *titleL=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.width/2-10, btn.height)];
                        titleL.textColor=[UIColor whiteColor];
                        titleL.text=[data objectForKey:@"title"];
                        titleL.textAlignment=NSTextAlignmentLeft;
                        titleL.font=[UIFont systemFontOfSize:12];
                        [btn addSubview:titleL];
                        
                        
                        UILabel *timeL=[[UILabel alloc]initWithFrame:CGRectMake(self.view.width/2-10, 0, self.view.width/4+10, btn.height)];
                        timeL.textColor=[UIColor whiteColor];
                        
                        NSDictionary *playPosition = [SCUSER_DEFAULT dictionaryForKey:viidiID];
                        NSInteger durtion  = [[playPosition valueForKey:@"playbackTime"] integerValue];
                        
                        
                        timeL.text=[NSString stringWithFormat:@"%@%@",[ManyLanguageMag gethCourseStrWith:@"学习至"],[NSDate famateWithSeconds:durtion]];
                        timeL.textAlignment=NSTextAlignmentLeft;
                        timeL.font=[UIFont systemFontOfSize:12];
                        [btn addSubview:timeL];
                        
                        
                        UILabel *goonL=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-90, 0,100, btn.height)];
                        goonL.textColor = GreenColor;
                        goonL.textAlignment=NSTextAlignmentCenter;
                        goonL.text=[ManyLanguageMag gethCourseStrWith:@"继续观看"];
                        [btn addSubview:goonL];
                        
                        double delayInSeconds = 10.0;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [btn removeFromSuperview];
                        });
                    }
                } fail:^(NSError *error) {
                }];
            }else if(code == 30030)
            {
                [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
            }
        
        } fail:^(NSError *error) {
            
        }];
    }
    
}
-(void)GoONStudy{
    
    //到课程详情
    CourseDetailArrayModel *courseDetail = [CourseDetailArrayModel objectWithKeyValues:self.responseDic[@"data"]];
    NSArray *captions = [CourseDetailModel objectArrayWithKeyValuesArray:self.responseDic[@"rows"]];
    
    //到课程详情
    CourseDetailController *courseDetailVc = [[CourseDetailController alloc] init];
    courseDetailVc.courseDetail = courseDetail;
    if (captions.count > 0) {
        courseDetailVc.captions = captions;
    }
    [self.navigationController pushViewController:courseDetailVc animated:YES];
    
}
-(void)networking{
    
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&index=%ld&count=4",NetHeader,Hotcourse,[UserInfoTool getUserInfo].token,(long)_indexOne];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSInteger code=[responseDic[@"rescode"] integerValue];

        if (code==10000) {
            
            NSDictionary * data =responseDic[@"data"];
            NSInteger all=[data[@"all"] integerValue];
            NSInteger number = all / 4 ;
            NSInteger  left = all % 4;
            if (left > 0) {
                number++;
            }
            if (_indexOne == number) {
                _indexOne = 1;
            }else{
                _indexOne++;
            }

            NSArray *row=responseDic[@"rows"];
            self.hotCourseArr=[CourseHotModel objectArrayWithKeyValuesArray:row];
            if (self.guessLikeArr==nil) {
                [self networkingX];
            }
            
            _AFinir = @"yes";
            [self.rightCollection reloadSections:[NSIndexSet indexSetWithIndex:1]];

        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
        
    }];

}
#pragma mark textFeildDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _searchBar.text=nil;
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchViewControllerX *vc = [[SearchViewControllerX alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    return 0;
}

-(void)networkingX{
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&index=%ld&count=4",NetHeader,Guesslike,[UserInfoTool getUserInfo].token,(long)_indexTwo];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSInteger code=[responseDic[@"rescode"] integerValue];

        if (code == 10000) {
            NSDictionary * data =responseDic[@"data"];
            NSInteger all=[data[@"all"] integerValue];
            NSInteger number = all / 4 ;
            NSInteger  left = all % 4;
            if (left > 0) {
                number++;
            }
            if (_indexTwo == number) {
                _indexTwo = 1;
            }else{
                _indexTwo++;
            }
            
            NSArray *rows=responseDic[@"rows"];
            self.guessLikeArr = nil;
            self.guessLikeArr=[CourseHotModel objectArrayWithKeyValuesArray:rows];

            [self.rightCollection reloadSections:[NSIndexSet indexSetWithIndex:2]];
            _BFinir = @"yes";
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}
#pragma mark---imageCollectionView--------------------------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if(section == 1)
    {
        return self.hotCourseArr.count;
    }else if(section == 2)
    {
        return self.guessLikeArr.count;
    }
    return 4;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MultileHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MultileHeadView" forIndexPath:indexPath];
        headView.delegate=self;
        return headView;
    }else{
        CourseHeaderTwo *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CourseHeaderTwo" forIndexPath:indexPath];
        headView.delegate=self;
        headView.sectionX=indexPath.section;
        headView.tag=indexPath.section;
        return headView;
    }
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CourseHotModel *model;
    if (indexPath.section==1) {
        model=  self.hotCourseArr[indexPath.row];
    }
    if (indexPath.section ==2) {
        model=  self.guessLikeArr[indexPath.row];
    }
    [self passCourseid:model.course_id andType:(int)model.type.integerValue];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseCollectioncell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CourseCollectioncell" forIndexPath:indexPath];
    
    
    if(!cell){
        cell =[[CourseCollectioncell alloc]initWithFrame:CGRectMake(0, 0, self.view.width, HeaderH_Two)];
    }
    if (indexPath.section == 1) {
        cell.model= self.hotCourseArr[indexPath.row];
    }else if (indexPath.section == 2){
        cell.model= self.guessLikeArr[indexPath.row];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kSize.width/2, ItemH);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//告知头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(kSize.width, HeaderH_One);
    }else{
        return CGSizeMake(kSize.width, HeaderH_Two);
    }
}

#pragma mark  cell点击
-(void)passCourseid:(NSString *)courseid andType:(int)type{
    //   1课程，2 直播，3沙龙，4 专题，5 H5页面
    
    switch (type) {
        case 40400:{
            [self pushToCourseDetailWithCourseId:courseid];
        }
            break;
        case 40300:{
            [self pushToLiveDetailWithCourseId:courseid];
        }
            break;
        case 40200:{
            [self pushToSalonDetailWithCourseId:courseid];
        }
            break;
        case 40100:{
            [self pushToCourseSpecialDetailWithCourseId:courseid];
        }
            break;
        case 5:{
        }
            break;
        default:
            break;
    }
    
}

-(void)pushToCourseSpecialDetailWithCourseId:(NSString *)courseid{
    CourseSpecialDetailViewController *vc=[[CourseSpecialDetailViewController alloc] init];
    vc.ID = courseid;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushToSalonDetailWithCourseId:(NSString *)courseid{
    MainWebController *shalong = [[MainWebController alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@mh5/shalong/shalongdetail?id=%@&locale=%@",NetHeader,courseid,[ManyLanguageMag getTypeWithWebDiscript]];
    shalong.url = url;
    shalong.webTitle = @"沙龙详情";
    [self.navigationController pushViewController:shalong animated:YES];
}

-(void)pushToLiveDetailWithCourseId:(NSString *)courseid{
    NSString *uelStr=[NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,courseid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
    
    MainWebController *vc = [[MainWebController alloc] init];
    vc.url = uelStr;
    vc.title = @"直播详情";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushToCourseDetailWithCourseId:(NSString *)courseid{
    
    NSString *token;
    if([UserInfoTool getUserInfo].token == nil){
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate alertViewLogin];
        return;
    }else{
        token = [UserInfoTool getUserInfo].token;
    }
    
    NSDictionary *parameter=@{
                              @"chapterid":courseid
                              };
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            NSDictionary *parameter=@{
                                      @"token":token,
                                      @"chapterid":courseid
                                      };
            NSString *url=[NSString stringWithFormat:@"%@%@",NetHeader,CourseDetail];
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                NSInteger code=[responseDic[@"rescode"] integerValue];
                NSDictionary *dic = responseDic[@"data"];
                
                if (dic.allKeys.count != 0) {
                    if (code == 10000) {
                        //到课程详情
                        CourseDetailArrayModel *courseDetail = [CourseDetailArrayModel objectWithKeyValues:responseDic[@"data"]];
                        NSArray *captions = [CourseDetailModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
                        
                        CourseDetailController *courseDetailVc = [[CourseDetailController alloc] init];
                        courseDetailVc.courseDetail = courseDetail;
                        if (captions.count > 0) {
                            courseDetailVc.captions = captions;
                        }
                        [self.navigationController pushViewController:courseDetailVc animated:YES];
                    }
                }else{
                    [MBProgressHUD showError:@"课程已被删除"];
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

-(void)fastbtnclick:(UIButton *)btn withType:(NSString *)type withID:(NSString *)ID withWebUrl:(NSString *)Url{
    
    //type 1  webview打开  2  课程详情
    
    if ([UserInfoTool isLogin]) {
        if (btn.tag < 1000) {
            [self gotocontrollerwithType:type withID:ID withWebUrl:Url];
        }else if(btn.tag == 1000) //专题列表
        {
            SpecialViewController *speVc = [[SpecialViewController alloc] init];
            [self.navigationController pushViewController:speVc animated:YES];
        }else if (btn.tag == 1001) //直播列表
        {
            NSString *url = [NSString stringWithFormat:@"%@%@?appkey=%@&locale=%@",NetHeader,liveReCommend,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.needSearch = YES;
            vc.webTitle = [ManyLanguageMag gethCourseStrWith:@"直播"];
            vc.url = url;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (btn.tag == 1002) //沙龙列表
        {
            NSString *url = [NSString stringWithFormat:@"%@%@?appkey=%@&locale=%@",NetHeader,shalongReCommend,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.needSearch = YES;
            vc.webTitle = [ManyLanguageMag gethCourseStrWith:@"沙龙"];
            vc.url = url;
            [self.navigationController pushViewController:vc animated:YES];
        }else if(btn.tag == 1003) //学习列表
        {
            CourseStudyViewControllerX *courseList = [[CourseStudyViewControllerX alloc] init];
            [self.navigationController pushViewController:courseList animated:YES];
        }
    }else{
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate alertViewLogin];
    }
}

-(void)gotocontrollerwithType:(NSString *)type withID:(NSString *)ID withWebUrl:(NSString *)Url{

    if ([type isEqualToString:@"1"]) {
        
        MainWebController *vc = [[MainWebController alloc] init];
        vc.webTitle = @"详情";
        vc.url = Url;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"2"]){
        
        if ([UserInfoTool isLogin]) {
            NSString *token;
            if([UserInfoTool getUserInfo].token == nil){
                token = @"";
            }else{
                token = [UserInfoTool getUserInfo].token;
            }
            
            NSDictionary *parameter=@{
                                      @"chapterid":ID
                                      };
            NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,token];
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                
                NSInteger code=[responseDic[@"rescode"] integerValue];
                
                if (code == 10000)
                {
                    NSDictionary *parameter=@{
                                              @"token":token,
                                              @"chapterid":ID
                                              };
                    NSString *url=[NSString stringWithFormat:@"%@%@",NetHeader,CourseDetail];
                    
                    
                    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                        NSInteger code=[responseDic[@"rescode"] integerValue];
                        if (code==10000) {
                            //到课程详情
                            CourseDetailArrayModel *courseDetail = [CourseDetailArrayModel objectWithKeyValues:responseDic[@"data"]];
                            NSArray *captions = [CourseDetailModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
                            
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
        }else{
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate alertViewLogin];
        }
    }else{
        [MBProgressHUD showError:@"未知类型"];
    }

}

#pragma mark delegate
-(void)exchange:(UICollectionReusableView *)resuableView{
    
    _AFinir = nil; _BFinir = nil;
    if (resuableView.tag == 1) {
        [self networking];
    }
    if (resuableView.tag ==2) {
        [self networkingX];
    }
}

-(void)Finir:(NSTimer *)timer{
    UICollectionReusableView *vcT=(UICollectionReusableView *)timer.userInfo;
    if (_AFinir!=nil && _BFinir!=nil) {
        //刷新刷新界面
        [self.rightCollection reloadSections:[NSIndexSet indexSetWithIndex:vcT.tag]];
         _AFinir = nil; _BFinir = nil;
        //取消定时器
        [_timer invalidate];
         _timer = nil;
    }
}

@end
