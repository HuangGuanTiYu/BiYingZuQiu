//
//  AddMusicController.m
//  MoveSchool
//
//  Created by edz on 2017/12/16.
//
//

#import "AddMusicController.h"
#import "AddMusicCell.h"

@interface AddMusicController ()<UITableViewDelegate, UITableViewDataSource, AddMusicCellDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AddMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择背景音乐";
    
    self.titles = @[@"晨歌",@"卡农",@"梁祝"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"AddMusicCell";
    AddMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[AddMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.title = self.titles[indexPath.row];
    cell.selectedName = self.selectedName;
    cell.addMusicCellDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

- (void)addMusic:(AddMusicCell *)cell
{

    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chenge" ofType:@"mp3"];
    NSString *name = @"晨歌";
    if (indexPath.row == 1) {
        filePath = [[NSBundle mainBundle] pathForResource:@"kanong" ofType:@"mp3"];
        name = @"卡农";
    }else if (indexPath.row == 2) {
        filePath = [[NSBundle mainBundle] pathForResource:@"liangzhu" ofType:@"mp3"];
        name = @"梁祝";
    }

    if ([self.addMusicControllerDelgate respondsToSelector:@selector(addMusic:name:)]) {
        [self.addMusicControllerDelgate addMusic:filePath name:name];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
