//
//  SearchViewControllerX.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/1.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "SearchViewControllerX.h"
#import "HotSearchCell.h"
#import "LocationTool.h"
#import "HistorySearchCell.h"
#import "UIView+Extension.h"
#import "SCSearchBar.h"
#import "ColorTypeTools.h"
#import "AFNetWW.h"
#import "MineStudyCourseViewController.h" 
#import "SearchListViewController.h"
#import "CourseDetailModel.h"
#import "MJExtension.h"

#define kSize [[UIScreen mainScreen]bounds].size
#define sectionHeight 50
@interface SearchViewControllerX ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,HistorySearchCellSelectDelegate,HotSearchCellSelectDelegate>
{
    UITableView *_tableView;
    CGFloat SectiononeH;
    
}

@property(nonatomic,strong)SCSearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray *arry;
@property (nonatomic, strong) NSMutableArray *locationLines;//本地归档存储
//@property(nonatomic,strong) NSMutableArray *historyArr;

@end
@implementation SearchViewControllerX
- (NSMutableArray *)locationLines{
    if(!_locationLines){
        // 从文件取
        _locationLines = [LocationTool showSelectLocation];
    }
    if (!_locationLines) {
        _locationLines = [[NSMutableArray alloc]init];
    }
    return _locationLines;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [LocationTool saveLocation:self.locationLines];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavi];
    [self setupData];
    [self createsecrch];
}

-(void)setNavi{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

-(void)setupData{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,HotRecommend,[UserInfoTool getUserInfo].token];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {

        [MBProgressHUD showText:@"获取列表成功" inview:self.view];
        if ([responseDic[@"rescode"] intValue]==10000) {
            NSArray *row = responseDic[@"rows"];
            
            self.arry = [NSMutableArray array];
            for (NSDictionary *dic in row) {
                
                [self.arry addObject:dic[@"tags"]];//热门推荐列表
            }
            [self  hotreCommed];

        }
    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
  
}

-(void)hotreCommed{
    CGFloat oneLineBtnWidtnLimit = kSize.width-20;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = 10;//btn的x间距
    CGFloat btnGapY = 10;
    NSInteger BtnlineNum = 0;
    CGFloat BtnHeight = 30;
    CGFloat minBtnLength =  50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0;//每个btn的起始位置
    Btnx += btnGap;
    
    for (int i = 0; i < self.arry.count; i++) {
        NSString *str =self.arry[i];
        CGFloat btnWidth = [self WidthWithString:str fontSize:13 height:BtnHeight];
        btnWidth += 20;//让文字两端留出间距
        
        if(btnWidth<minBtnLength)
            btnWidth = minBtnLength;
        
        if(btnWidth>maxBtnLength)
            btnWidth = maxBtnLength;
        
        if(Btnx + btnWidth > oneLineBtnWidtnLimit)
        {
            BtnlineNum ++;//长度超出换到下一行
            Btnx = btnGap;
        }
        
        CGFloat height =  (BtnlineNum*(BtnHeight+btnGapY));
        Btnx = Btnx + btnWidth + btnGap;
        
        SectiononeH=height+BtnHeight;
    }
    
    [self createTableView];

}
#pragma mark - self tools
//根据字符串计算宽度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}

-(void)createsecrch{
    _searchBar =  [[SCSearchBar alloc]init];
    _searchBar.delegate = self;
    CGFloat width=30;
    _searchBar.frame = CGRectMake(0, 0, kSize.width-120, width);
    _searchBar.placeholder = [ManyLanguageMag gethCourseStrWith:@"请输入课程名称"];
    _searchBar.backgroundColor=[UIColor grayColor];
    _searchBar.layer.cornerRadius=width/2;
    _searchBar.layer.masksToBounds=YES;
    [_searchBar setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
     _searchBar.returnKeyType =UIReturnKeySearch;
    _searchBar.font=[UIFont systemFontOfSize:14];
    self.navigationItem.titleView=_searchBar;
    
    self.navigationItem.rightBarButtonItem = [self itemWithTitleName:[ManyLanguageMag gethCourseStrWith:@"取消"] highTitleName:[ManyLanguageMag gethCourseStrWith:@"取消"] addTarget:self action:@selector(cancel)];
}
-(void)cancel{
    _searchBar.text=nil;
    [_searchBar resignFirstResponder];
}
#pragma mark textFeildDelegate

-(void)gotoCourse{
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,CourseSearch];
    NSDictionary *Parameters=@{
                               @"token":[UserInfoTool getUserInfo].token,
                               @"key"  : _searchBar.text,
                               @"type": @"0",
                               @"index":@"0",
                               @"count":@"1000"
                               };
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        [MBProgressHUD showText:@"获取列表成功" inview:self.view];
        if ([responseDic[@"rescode"] intValue]==10000) {
            NSArray *row=responseDic[@"rows"];
            SearchListViewController *vc=[SearchListViewController new];
            vc.arr = (NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:row];
            [self.navigationController pushViewController:vc animated:0];
        }
    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //历史纪录
    if ([self.locationLines containsObject:_searchBar.text]) {
        [self.locationLines removeObject:_searchBar.text];
    }
    [self.locationLines insertObject:_searchBar.text atIndex:0];
    if (self.locationLines.count>8) {
        [self.locationLines removeLastObject];
    }
    [_tableView reloadData];
    //搜索界面挑战
    [self gotoCourse];
    return _searchBar;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([self.locationLines containsObject:searchBar.text]) {
        [self.locationLines removeObject:searchBar.text];
    }
    [self.locationLines insertObject:searchBar.text atIndex:0];
    if (self.locationLines.count>8) {
        [self.locationLines removeLastObject];
    }
    [_tableView reloadData];
}


- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.width, self.view.height+64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SectiononeH;
    }else{
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if(section==1&&self.locationLines.count!=0){
    CGFloat height=self.view.height-300-50*(self.locationLines.count-1)+70;
        return height;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1&&self.locationLines.count!=0) {
        UIView *bgviw=[UIView new];
        bgviw.backgroundColor=kColorGray240;
        UIButton *footerview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        [footerview setTitle:[ManyLanguageMag  gethCourseStrWith:@"清除历史记录"] forState:UIControlStateNormal];
        footerview.titleLabel.font=[UIFont systemFontOfSize:13];
        [footerview addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
        [footerview setTitleColor:GreenColor forState:UIControlStateNormal];
        [bgviw addSubview:footerview];
        return bgviw;
    }else{
        return nil;
    }
    
}
-(void)clear{
    [self.locationLines removeAllObjects];
      NSIndexSet *sect=[NSIndexSet indexSetWithIndex:1];
    [_tableView reloadSections:sect withRowAnimation:0];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section==0) {
        return 1;
        
    }else{
        return self.locationLines.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, sectionHeight)];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, sectionHeight)];
    
    [view addSubview:lable];
    if (section==0) {
        lable.textColor = GreenColor;
        lable.text = [ManyLanguageMag gethCourseStrWith:@"热门搜索"];
    }else{
        lable.textColor = GreenColor;
        lable.text = [ManyLanguageMag gethCourseStrWith:@"搜索历史"];
    }
    lable.font = [UIFont systemFontOfSize:16];

    return view;
}

#pragma mark  cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        HotSearchCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cel"];
        
        if (cell==nil) {
            cell=[[HotSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        }
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.hotArry=self.arry;
        return cell;
    }else{
        HistorySearchCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ce"];
        
        if (cell==nil) {
            cell=[[HistorySearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ce"];
        }
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.historystring=self.locationLines[indexPath.row];
        cell.tag=indexPath.row;
        
        UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lbl.frame = CGRectMake(cell.frame.origin.x , 1, cell.frame.size.width+200 , 1);
        lbl.backgroundColor = kColorGray240;
        [cell.contentView addSubview:lbl];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){//搜索历史点击
        _searchBar.text=self.locationLines[indexPath.row];
        [_searchBar becomeFirstResponder];
        [self gotoCourse];
    }
}


-(void)History:(UITableViewCell *)cell{
    
    NSIndexPath * path = [_tableView indexPathForCell:cell];
    [self.locationLines removeObjectAtIndex:path.row];
    NSIndexSet *sect=[NSIndexSet indexSetWithIndex:1];
    [_tableView reloadSections:sect withRowAnimation:0];
    
    
}
#pragma  mark  热门搜索点击
-(void)Hot:(UIButton *)btn{
    if ([self.locationLines containsObject:btn.titleLabel.text]) {
        [self.locationLines removeObject:btn.titleLabel.text];
    }
    [self.locationLines insertObject:btn.titleLabel.text atIndex:0];
    if (self.locationLines.count>8) {
        [self.locationLines removeLastObject];
    }
    
    _searchBar.text=btn.titleLabel.text;
    
    
    [_searchBar becomeFirstResponder];
      NSIndexSet *sect=[NSIndexSet indexSetWithIndex:1];
      [_tableView reloadSections:sect withRowAnimation:0];
    
    [self gotoCourse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName  addTarget:(id )class action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImageName] forState:UIControlStateHighlighted];
    
    //  设置按钮的尺寸
    button.size = button.currentBackgroundImage.size;
    [button addTarget:class action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(UIBarButtonItem *)itemWithTitleName:(NSString *)imageName highTitleName:(NSString *)hightTitleName  addTarget:(id )class action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:imageName forState:UIControlStateNormal];
    [button setTitle:hightTitleName forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置按钮文本右对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.size=CGSizeMake(44, 44);
    [button addTarget:class action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark 取消第一响应者
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchBar resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
   [_searchBar resignFirstResponder];
    
}

@end
