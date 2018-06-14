//
//  FriendInfoShowHotViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 caobohua. All rights reserved.
//  我的信息界面

#import "FriendInfoShowHotViewController.h"
#import "UIView+Extension.h"
#import "InfoFriendImageTableViewCell.h"
#import "InfoFriendTableViewCell.h"
#import "MainPersonCellNoAddCell.h"
#import "InfoFriendSectionTableViewCellAdd.h"
#import "FriendCheckViewController.h"
#import "EditMessageController.h"

@interface FriendInfoShowHotViewController ()<UITableViewDelegate,UITableViewDataSource,InfoFriendSectionTableViewCellAddDelegate,MainPersonCellNoAddCellDelegate,FriendCheckViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray *dicArr;
@property(nonatomic,strong)UITableView *tableview;


//浏览图片
@property (strong, nonatomic) UIImageView *scanImage;

@end

@implementation FriendInfoShowHotViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.tableview reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
        
    [self prepareData];

}

- (void) setUpUI
{
    [self.view addSubview:self.tableview];
    
    [self.tableview registerClass:[MainPersonCellNoAddCell class] forCellReuseIdentifier:@"MainPersonCell"];
    [self.tableview registerClass:[InfoFriendTableViewCell class] forCellReuseIdentifier:@"InfoFriendTableViewCell"];
    [self.tableview registerClass:[InfoFriendImageTableViewCell class] forCellReuseIdentifier:@"InfoFriendImageTableViewCell"];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 22, 24, 24);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"common_back_white"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    //编辑按钮
    if ([self.friendM.zttid isEqualToString:[UserInfoTool getUserInfo].zttid]) {
        
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.frame = CGRectMake(SCREEN_WIDTH - 24 - 7, 22, 24, 24);
        editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [editBtn addTarget:self action:@selector(onEditClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        [self.view addSubview:editBtn];
        
    }
}

#pragma mark 返回
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)prepareData{
    NSString *name;
    NSString *username;
    NSString *mobile;
    NSString *mail;
    NSString*tengroup;
    NSString *department;
    NSString *nickname;
    NSString *company;
    
    //防止信息为空崩溃
    if (self.friendM.company==nil) {
        company=@"";
    }else{
        company=self.friendM.company;
    }
    if (self.friendM.name==nil) {
        name=@"";
    }else{
        name=self.friendM.name;
    }
    if (self.friendM.username==nil) {
        username=@"";
    }else{
        username=self.friendM.username;
    }
    if (self.friendM.mobile==nil) {
        mobile=@"";
    }else{
        mobile=self.friendM.mobile;
    }
    if (self.friendM.mail==nil) {
        mail=@"";
    }else{
        mail=self.friendM.mail;
    }
    if (self.friendM.tengroup==nil) {
        tengroup=@"";
    }else{
        tengroup=self.friendM.tengroup;
    }
    if (self.friendM.department==nil) {
        department=@"";
    }else{
        department=self.friendM.department;
    }
    if (self.friendM.nickname==nil) {
        nickname=@"";
    }else{
        nickname=self.friendM.nickname;
    }
 
    
    NSArray * section4=@[name,username,mobile,mail,company,department,tengroup];
    NSArray * section3=@[@"姓名",@"工号",@"个人电话",@"邮箱",@"主体",@"部门",@"事业部"];
   
    NSMutableArray *arrM=[NSMutableArray array];
    for (int i=0; i<section3.count; i++) {
        
        infoFriendsModel *model=[[infoFriendsModel alloc] init];
        
        model.name = section3[i];
        model.detailName = section4[i];
        model.imageIshidden = YES;
        [arrM addObject:model];
    }
    
    self.dicArr=arrM;

}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, self.view.width, self.view.height+20)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}




#pragma  mark tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewl=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    
    viewl.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    
    UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
    lbl.frame = CGRectMake(viewl.frame.origin.x, 10, viewl.frame.size.width, 1);
    lbl.backgroundColor = kColorGray225;
    [viewl addSubview:lbl];
    
    UIView *lbl1 = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
    lbl1.frame = CGRectMake(0, -1, viewl.frame.size.width, 1);
    lbl1.backgroundColor = kColorGray225;
    [viewl addSubview:lbl1];
    return viewl;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0 || section==1) {
        return 0;
    }
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if (section==1){
        
        return 1;
    }else if (section==2){
        return 2;
    }else{
        return 7;
    }
}

#pragma mark datasouse
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MainPersonCellNoAddCell *cell=[[MainPersonCellNoAddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainPersonCell"];
        cell.model=self.friendM;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=YES;
        cell.delegate = self;
        return cell;
        
        
    }else if (indexPath.section == 1){
        
        if ([self.friendM.zttid isEqualToString:[UserInfoTool getUserInfo].zttid]) {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ccell"];
            return cell;
        }else{

            if ([self.friendM.ftype isEqualToString:@"0"]) {
                InfoFriendSectionTableViewCellAdd *cell=[[InfoFriendSectionTableViewCellAdd alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
                cell.delegate=self;
                return cell;
            }else if ([self.friendM.ftype isEqualToString:@"2"]){
                FriendCheckViewController *cell=[[FriendCheckViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
                cell.delegate = self;
                return cell;
            }else{
                FriendCheckViewController *cell=[[FriendCheckViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
                return cell;
            }
        }
    }else if (indexPath.section==2){
     
            InfoFriendTableViewCell *cell=[[InfoFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoFriendImageTableViewCell"];
            infoFriendsModel *model=[infoFriendsModel new];
            model.name=@"昵称";
            
            if (self.friendM.nickname==nil) {
                self.friendM.nickname=@"";
            }
        
        
           if (self.friendM.sex == nil) {
               self.friendM.sex=@"";
             }
            model.detailName = self.friendM.nickname;
            model.imageIshidden = YES;
            infoFriendsModel *model1=[infoFriendsModel new];
            model1.name = @"性别";
            model1.detailName=[self sexKnowWithString:self.friendM.sex];
            model1.imageIshidden = YES;
            
           
            NSArray *arr=@[model,model1];
            cell.model=arr[indexPath.row];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled=NO;
        UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lbl.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.size.height - 5, cell.frame.size.width +200, 1);
        lbl.backgroundColor = kColorGray240;
        [cell.contentView addSubview:lbl];
            return cell;
        
    }else{
        
        InfoFriendTableViewCell *cell=[[InfoFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoFriendImageTableViewCell"];
        cell.model=self.dicArr[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        
        UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lbl.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.size.height - 5, cell.frame.size.width+200, 1);
        lbl.backgroundColor = kColorGray240;
        [cell.contentView addSubview:lbl];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 130;
    }else if (indexPath.section==1){
        //
        if ([self.friendM.zttid isEqualToString:[UserInfoTool getUserInfo].zttid]) {

            return 0;
        }else{
            
            if ([self.friendM.ftype isEqualToString:@"0"]) {
                
                return 0;
            }else if ([self.friendM.ftype isEqualToString:@"2"]){
                return 0;
            }else{
                return 0;
            }
        }
    }else{
        return 40;
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

-(NSString *)sexKnowWithString:(NSString *)str{

    if ([str isEqualToString:@"2"]) {
        return @"女";
    }else if([str isEqualToString:@"1"]){
    
        return @"男";

    }else{
        return @"";
    }
}

#pragma mark 编辑按钮
-(void)onEditClickBtn:(UIButton *)sender{
    EditMessageController *editVc = [EditMessageController editMessageController];
    [self.navigationController pushViewController:editVc animated:YES];
}

#pragma mark 添加好友
- (void) addFirend
{

}

- (void)addViewWithAddWith:(UIButton *)btn
{

}

- (void)sendMsgAndDeleteFriendWith:(UIButton *)sender
{

}


@end
