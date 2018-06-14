//
//  ChangeSexController.m
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import "ChangeSexController.h"
#import "ChangeSexCell.h"
#import "AFNetWW.h"

@interface ChangeSexController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) ChangeSexCell *selectedCell;

@end

@implementation ChangeSexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"性别";
    
    self.titles = @[@"男",@"女",@"保密"];
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];

}

- (void) send
{
    NSString *sexVaule = @"";
    if ([self.selectedCell.title isEqualToString:@"男"]) {
        sexVaule = @"1";
    }else if ([self.selectedCell.title isEqualToString:@"女"]) {
        sexVaule = @"2";
    }else if ([self.selectedCell.title isEqualToString:@"保密"]) {
        sexVaule = @"4";
    }
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ChangeKeyValue,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid":[UserInfoTool getUserInfo].ID,
                        @"businesscode":@"10000",
                        @"key":@"sex",
                        @"value": sexVaule
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             if ([self.delegate respondsToSelector:@selector(changeSex:)]) {
                 [self.delegate changeSex:self.selectedCell.title];
             }
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
             });
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ChangeSexCell";
    ChangeSexCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ChangeSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = self.titles[indexPath.row];
    
    if ([self.sex isEqualToString:cell.title]) {
        cell.selectButton.selected = YES;
        cell.titleLabe.textColor = MainColor;
        self.selectedCell = cell;
    }else
    {
        cell.selectButton.selected = NO;
        cell.titleLabe.textColor = MainTextColor;
    }
    
    if (indexPath.row == self.titles.count - 1) {
        cell.sepaView.hidden = YES;
    }else
    {
        cell.sepaView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ChangeSexCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == self.selectedCell) {
        return;
    }
    
    cell.selectButton.selected = YES;
    cell.titleLabe.textColor = MainColor;
    self.selectedCell.titleLabe.textColor = MainTextColor;
    self.selectedCell.selectButton.selected = NO;
    self.selectedCell = cell;
}

@end
