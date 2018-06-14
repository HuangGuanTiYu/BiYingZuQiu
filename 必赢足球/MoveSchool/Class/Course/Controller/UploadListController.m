//
//  UploadListController.m
//  MoveSchool
//
//  Created by edz on 2018/1/5.
//

#import "UploadListController.h"
#import "VideoCell.h"
#import "VideoModelTool.h"
#import "VideoModel.h"
#import "AFNetWW.h"
#import "NewH5CourseController.h"
#import "CustomLabel.h"

@interface UploadListController ()<UITableViewDelegate, UITableViewDataSource, VideoCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *noCommentView;

@property (nonatomic, strong) CustomLabel *titleLabel;

@end

@implementation UploadListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"上传列表";
    
    CustomLabel *titleLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    self.titleLabel = titleLabel;
    titleLabel.hidden = YES;
    titleLabel.textInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
    titleLabel.font = [UIFont systemFontOfSize:ys_f24];
    titleLabel.textColor = AuxiliaryColor;
    
    NSMutableArray *uploadFaile = [NSMutableArray array];
    
    if (self.datas.count > 0) {
        for (VideoModel *model in self.datas) {
            if (model.uploadFaile) {
                [uploadFaile addObject:model];
            }
        }
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height - 64;
    
    if (uploadFaile.count > 0) {
        titleLabel.text = [NSString stringWithFormat:@"提示：您有%lu个音频课件在上传出现问题，请重新上传~",(unsigned long)uploadFaile.count];
        titleLabel.hidden = NO;
        [self.view addSubview:titleLabel];
        
        tableView.y = 44;
        tableView.height = self.view.height - 64 - 44;
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = ViewBackColor;
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];

    
    //没有评论
    UIView *noCommentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.noCommentView = noCommentView;
    noCommentView.hidden = YES;
    [self.view addSubview:noCommentView];
    
    //图片 + 文字
    UIView *imageTexgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, noCommentView.width, 129)];
    imageTexgView.centerY = self.view.height * 0.5 - 45 - 64;
    [noCommentView addSubview:imageTexgView];
    
    //背景图
    UIImageView *noImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 121, 90)];
    noImage.image = [UIImage imageNamed:@"kong"];
    noImage.centerX = noCommentView.width * 0.5;
    [imageTexgView addSubview:noImage];
    
    UILabel *toTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noImage.frame) + 5, noCommentView.width, 20)];
    toTestLabel.textAlignment = NSTextAlignmentCenter;
    toTestLabel.text = @"还没有内容呀~";
    toTestLabel.textColor = AuxiliaryColor;
    toTestLabel.font = [UIFont systemFontOfSize:ys_f24];
    [imageTexgView addSubview:toTestLabel];
    
    //没有内容
    if (self.datas.count == 0) {
        self.tableView.hidden = YES;
        self.noCommentView.hidden = NO;
    }else
    {
        self.noCommentView.hidden = YES;
        self.tableView.hidden = NO;
    }
    
    [self setUpData];
    
    if (self.videoPath.length > 0) {
        [self uploadVideo];
    }
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor whiteColor] imageFont:18];

}

- (void) back
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[NewH5CourseController class]]) {
            NewH5CourseController *A = (NewH5CourseController *)controller;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToViewController:A animated:YES];
            });
        }
    }
}

#pragma mark 上传视频
- (void) uploadVideo
{
 
    [MBProgressHUD showSuccess:@"正在上传，请稍后"];
    
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    NSString *url = [NSString stringWithFormat:@"%@/%@?token=%@",header,UploadVoice,[UserInfoTool getUserInfo].token];
    
    AFHTTPRequestOperationManager *manager = [[AFNetWW sharedAFNetWorking] getAFNManager];
    
    NSString *documentsFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsFolder stringByAppendingPathComponent:self.videoPath];
    
    NSData *voiceData = [NSData dataWithContentsOfFile:filePath];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:voiceData name:@"file" fileName:[self.videoPath lastPathComponent] mimeType:@"application/octet-stream;charset=utf-8"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
        
        NSString *videoUrl = dic[@"id"];
        
        //视频上传成功 提交信息到服务器
        [self uploadData : videoUrl localVideoPath : self.videoPath];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
        [MBProgressHUD showError:@"上传失败"];
        
        self.model.uploadFaile = YES;
        [VideoModelTool updateVideoModel:self.model];
        
    }];
}

- (void) uploadData : (NSString *) videoUrl localVideoPath : (NSString *) localVideoPath
{
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];

    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",header,H5courseSaveH5Course,[UserInfoTool getUserInfo].token];
    
    NSDictionary *courseJson = @{
                                 @"id" : videoUrl,
                                 @"title" : self.titles,
                                 @"headimgurl" : self.imageUrl.length > 0 ? self.imageUrl : @"",
                                 @"bgImg" : @"",
                                 @"desc" : self.desc,
                                 @"direction": @"horizontal",
                                 @"templateId": @(40443),
                                 @"readonly": @(false),
                                 @"pages" : @[]
                                 };
    
    NSDictionary *dic=@{
                        @"clientid" : @(1),
                        @"courseJson" : courseJson
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
            [MBProgressHUD showSuccess:@"上传成功"];
            
            NSString *documentsFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *filePath = [documentsFolder stringByAppendingPathComponent:localVideoPath];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                self.videoPath = nil;
                [VideoModelTool removeVideoModel:self.model];
            }
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[NewH5CourseController class]]) {
                    NewH5CourseController *A = (NewH5CourseController *)controller;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popToViewController:A animated:YES];
                    });
                }
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"VideoCell";
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.videoCellDelegate = self;
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (void) setUpData
{
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *model = self.datas[indexPath.row];
    if (model.uploadFaile) {
        return 125 + 44 + mainSpacing;
    }
    return 125;
}

- (void)deleteVideo:(VideoCell *)cell
{
    [MBProgressHUD showSuccess:@"删除成功"];
    
    self.titleLabel.text = [NSString stringWithFormat:@"提示：您有%lu个音频课件在上传出现问题，请重新上传~",(unsigned long)(self.datas.count - 1)];

    
    VideoModel *model = self.datas[[self.tableView indexPathForCell:cell].row];

    if ([[NSFileManager defaultManager] fileExistsAtPath:model.videoPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:model.videoPath error:nil];
        model.videoPath = nil;
        [VideoModelTool removeVideoModel:model];
    }
    
    [self.datas removeObjectAtIndex:[self.tableView indexPathForCell:cell].row];
    [self.tableView reloadData];
}

- (void)reUploadVideo:(VideoCell *)cell
{
    VideoModel *model = self.datas[[self.tableView indexPathForCell:cell].row];
    self.titles = model.title;
    self.imageUrl = model.imageUrl;
    self.desc = model.desc;
    self.model = model;
    self.videoPath = model.videoPath;
    [self uploadVideo];

}

@end
