//
//  SetLanguageController.m
//  MoveSchool
//
//  Created by edz on 2017/9/17.
//
//

#import "SetLanguageController.h"
#import "SetLanguageCell.h"

@interface SetLanguageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titls;

@property (nonatomic, strong) UIButton *selectButton;


@end

@implementation SetLanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titls = @[@"中文简体",@"英文",@"日语"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.title = @"语言选择";
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titls.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"SetLanguageCell";
    SetLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SetLanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.title = self.titls[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    NSString *str=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [MainUserDefaults setObject:str forKey:@"manylanguage"];
    
    SetLanguageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectButton.selected = YES;
    self.selectButton.selected = NO;
    self.selectButton = cell.selectButton;
}


@end
