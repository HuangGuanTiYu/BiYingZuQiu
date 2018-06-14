//
//  PersonMessageController.m
//  MoveSchool
//
//  Created by edz on 2017/10/12.
//
//

#import "PersonMessageController.h"
#import "FriendModel.h"
#import "PersonMessageCell.h"

@interface PersonMessageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSMutableArray *subTitles;

@end

@implementation PersonMessageController

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return mainSpacing;
    }
    
    return 44;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titles = @[@"头像",@"昵称",@"性别",@"手机号",@"邮箱",@"",@"工号",@"部门",@"公司"];
    if ([self.model.companyid intValue] == 0) {
        self.titles = @[@"头像",@"昵称",@"性别",@"手机号",@"邮箱"];
    }
    
    NSString *sex = self.model.sex;
    NSString *sexName = @"";
    if ([sex intValue] == 1) {
        sexName = @"男";
    }else if ([sex intValue] == 2) {
        sexName = @"女";
    }else if ([sex intValue] == 4) {
        sexName = @"保密";
    }
    
    NSString *mobile = self.model.mobile;
    NSString *email = self.model.mail;
    NSString *username = self.model.username;
    NSString *department = self.model.department;
    NSString *company = self.model.company;
    
    NSArray *titles = @[self.model.headimgurl,self.model.nickname.length > 0 ? self.model.nickname : @"" ,sexName.length > 0 ? sexName : @"",mobile.length > 0 ? mobile : @"",email.length > 0 ? email : @"",@"",username.length > 0 ? username : @"",department.length > 0 ? department : @"",company.length > 0 ? company : @""];
    
    self.subTitles = [[NSMutableArray alloc] initWithArray:titles];
    
    [self setUpUI];
}

- (void) setUpUI
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.contentView.backgroundColor = ViewBackColor;
        return cell;
    }
    
    static NSString *ID = @"MineDataCell";
    PersonMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[PersonMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 4 || indexPath.row == 8) {
        cell.divisionView.hidden = YES;
    }else
    {
        cell.divisionView.hidden = NO;
    }
    
    cell.title = self.titles[indexPath.row];
    cell.subTitle = self.subTitles[indexPath.row];
    return cell;
}

@end
