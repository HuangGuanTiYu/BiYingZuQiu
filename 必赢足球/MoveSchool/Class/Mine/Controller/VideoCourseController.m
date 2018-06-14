//
//  VideoCourseController.m
//  MoveSchool
//
//  Created by edz on 2017/12/23.
//
//

#import "VideoCourseController.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "H5CourseModel.h"
#import "H5CourseCell.h"
#import "MainWebController.h"
#import "MJRefresh.h"
#import "TopImageButton.h"
#import <UMSocialCore/UMSocialCore.h>
#import "H5ExamineController.h"
#import "ShareButton.h"
#import "NewCourseDetailController.h"
#import "NewVideoCourseController.h"
#import "VideoPreviewController.h"

typedef enum {
    /** 分享到网易足球 */
    ShareSchool,
    /** 分享到QQ */
    ShareToQQ,
    /** 分享到微信 */
    ShareToWechat,
    /** 分享到微博 */
    ShareToSina,
    /** 分享到QQ会话 */
    ShareToQQChat,
    /** 分享到微信朋友圈 */
    ShareToWechatTimeline
} ShareType;

typedef enum
{
    deleteH5Course = 0, //删除课件
    offlineH5Course, //下线课件
    publishH5Course //发布课件
} H5CourseType;

@interface VideoCourseController ()<UITableViewDelegate, UITableViewDataSource, H5CourseCellDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, assign) int index;

//当前选中的课件
@property (nonatomic, strong) H5CourseModel *h5CourseModel;

//当前选中的cell
@property (nonatomic, strong) H5CourseCell *h5CourseCell;

//遮罩
@property(strong, nonatomic) UIView *maskView;

//分享模块
@property(nonatomic, strong) UIView *templateView;

//分享title
@property(nonatomic, copy) NSString *shareTitle;

//分享描述
@property(nonatomic, copy) NSString *shareSummary;

//分享缩略图
@property(nonatomic, strong) id shareImage;

//分享地址URL
@property(nonatomic, copy) NSString *shareUrl;

@property (nonatomic, strong) UIView *noCommentView;

@property(nonatomic, strong) NSArray *digits;

@end

@implementation VideoCourseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.datas = [NSMutableArray array];
    
    self.isMoreData = NO;
    self.index = 0;
    
    [self setUpData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self setUpUI];
    
    self.digits = @[@"0" , @"1" , @"2" , @"3" , @"4" , @"5" ,
                    @"6" , @"7" , @"8" , @"9" , @"a" , @"b" ,
                    @"c" , @"d" , @"e" , @"f" , @"g" , @"h" ,
                    @"i" , @"j" , @"k" , @"l" , @"m" , @"n" ,
                    @"o" , @"p" , @"q" , @"r" , @"s" , @"t" ,
                    @"u" , @"v" , @"w" , @"x" , @"y" , @"z"];
    
    self.shareTitle = @"网易足球";
    self.shareSummary = @"致力于为客户提供专业化的在线培训服务及系统化的培训解决方案，网易足球聚合了最优质的课程资源、讲师资源，鼓励用户参与分享，打造具有持续学习能力的培训生态圈。";
    self.shareImage = [UIImage imageNamed:@"logo"];
}

- (void) setUpData
{
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&index=%d&count=10&format=3",NetHeader,GetMyCourseList,[UserInfoTool getUserInfo].token,self.index];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (code == 10000)
        {
            NSArray *models = [H5CourseModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
            
            if (models.count > 0) {
                if (self.isMoreData) {
                    [self.datas addObjectsFromArray:models];
                }else
                {
                    self.datas = (NSMutableArray *)models;
                }
                
                //没有内容
                if (self.datas.count == 0) {
                    self.tableView.hidden = YES;
                    self.noCommentView.hidden = NO;
                }else
                {
                    self.noCommentView.hidden = YES;
                    self.tableView.hidden = NO;
                }
                
                [self.tableView reloadData];
            }else if(self.isMoreData)
            {
                --self.index;
                [MBProgressHUD showError:@"已加载全部课件"];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                return ;
            }else
            {
                
                //没有内容
                if (self.datas.count == 0) {
                    self.tableView.hidden = YES;
                    self.noCommentView.hidden = NO;
                }else
                {
                    self.noCommentView.hidden = YES;
                    self.tableView.hidden = NO;
                }
            }
        }
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showError:@"发送请求失败"];
        
    }];
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.y = 70;
    tableView.height = self.view.height - 64 - 70;
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isMoreData = NO;
        weakSelf.index = 0;
        [weakSelf setUpData];
    }];
    
    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    tableView.mj_footer = footer;
    
    //没有评论
    UIView *noCommentView = [[UIView alloc] initWithFrame:self.view.bounds];
    noCommentView.y = 70;
    noCommentView.height = self.view.height - 70 - 64;
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
    static NSString *ID = @"cell";
    H5CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[H5CourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.h5CourseModel = self.datas[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    H5CourseModel *model = self.datas[indexPath.row];
    if (model.status != 1) {
        VideoPreviewController *vc = [[VideoPreviewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    NewVideoCourseController *newCourseVc = [[NewVideoCourseController alloc] init];
    newCourseVc.courseid = model.mainid;
    [self.navigationController pushViewController:newCourseVc animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

#pragma mark 创建课件
- (void) createViewClick
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.isFromH5Course = YES;
    webVc.webTitle = @"创建课件";
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    webVc.url = [NSString stringWithFormat:@"%@/%@",header,CreateH5Course];
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)editButtonClick:(H5CourseCell *)h5CourseCell
{
    NSInteger index = [self.tableView indexPathForCell:h5CourseCell].row;
    H5CourseModel *model = self.datas[index];
    self.h5CourseModel = model;
    
    self.h5CourseCell = h5CourseCell;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"", nil];
    
    switch (model.status) {
        case 6: //待发布
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"发布",@"删除", nil];
            break;
        case 2: //审核中
        case 4:
        case 7: //未通过
        case 8: //已下线
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"删除", nil];
            break;
            
        case 1: //已上线
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"下线",@"分享",@"删除", nil];
            break;
        default:
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"删除", nil];
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [sheet showInView:self.view];
    });
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self pushEditView:self.h5CourseModel isEdit:YES];
    }
    
    switch (self.h5CourseModel.status) {
        case 6: //待发布
            if (buttonIndex == 1) { //发布
                [self publishH5Course];
            }else if (buttonIndex == 2) //删除
            {
                [self deleteH5Course];
            }
            break;
        case 1: //已上线
            if (buttonIndex == 1) { //下线
                [self deleteH5Course:offlineH5Course];
            }else if (buttonIndex == 2) //分享
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self shareCourse];
                });
            }else if (buttonIndex == 3) //删除
            {
                [self deleteH5Course];
            }
            break;
        case 2: //审核中
        case 4:
        case 7: //未通过
        case 8: //已下线
            if (buttonIndex == 1) { //删除
                [self deleteH5Course];
            }
            break;
        default:
            break;
    }
}

#pragma mark 删除课件
- (void) deleteH5Course
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:[ManyLanguageMag getLOginStrWith:@"确定"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteH5Course:deleteH5Course];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 跳转到提交审核界面
- (void) publishH5Course
{
    H5ExamineController *examineVc = [[H5ExamineController alloc] init];
    examineVc.h5CourseModel = self.h5CourseModel;
    [self.navigationController pushViewController:examineVc animated:YES];
}

#pragma mark 删除课件
- (void) deleteH5Course : (H5CourseType) type
{
    
    NSDictionary *dic = @{
                          @"id" : self.h5CourseModel.ID
                          };
    
    NSString *urlString = DeleteH5Course;
    
    if (type == publishH5Course) {
        urlString = PublishH5Course;
    }else if (type == offlineH5Course)
    {
        urlString = OfflineH5Course;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,urlString];
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        NSNumber * code = responseDic[@"rescode"];
        
        if (code.integerValue == 10000)
        {
            H5CourseModel *resModel = [H5CourseModel objectWithKeyValues:responseDic[@"data"]];
            
            if (type == deleteH5Course) {
                [MBProgressHUD showSuccess:@"删除成功"];
                if ([self.datas containsObject:self.h5CourseModel]) {
                    [self.datas removeObject:self.h5CourseModel];
                }
            }else if (type == publishH5Course)
            {
                [MBProgressHUD showSuccess:@"发布成功"];
                H5CourseModel *model = self.h5CourseModel;
                model.status = resModel.status;
                [self.datas replaceObjectAtIndex:[self.datas indexOfObject:self.h5CourseModel] withObject:model];
                
            }else if (type == offlineH5Course)
            {
                [MBProgressHUD showSuccess:@"下线成功"];
                
                H5CourseModel *model = self.h5CourseModel;
                model.status = resModel.status;
                [self.datas replaceObjectAtIndex:[self.datas indexOfObject:self.h5CourseModel] withObject:model];
            }
            
            //没有内容
            if (self.datas.count == 0) {
                self.tableView.hidden = YES;
                self.noCommentView.hidden = NO;
            }else
            {
                self.noCommentView.hidden = YES;
                self.tableView.hidden = NO;
            }
            
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}


#pragma mark 跳转到课件 编辑或者 预览界面
//isEdit 是否是 编辑
- (void) pushEditView : (H5CourseModel *) model isEdit : (BOOL) isEdit
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.webTitle = isEdit ? @"编辑课件" : model.title;
    webVc.isFromH5Course = YES;
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];

    webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",header,isEdit ? EditAudioPageTemplate : ViewH5Course,model.ccid];
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark 分享课件
- (void) shareCourse
{
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    
    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
    
    NSMutableArray *shareArray = [NSMutableArray array];
    
    if (isInstallWecha) {
        
        ShareButton *weChatButton = [[ShareButton alloc] init];
        weChatButton.tag = ShareToWechat;
        [weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButton setTitle:@"微信好友" forState:UIControlStateNormal];
        [weChatButton setImage:[UIImage imageNamed:@"share_02"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButton];
        
        ShareButton *weChatButtonTimeline = [[ShareButton alloc] init];
        weChatButtonTimeline.tag = ShareToWechatTimeline;
        [weChatButtonTimeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButtonTimeline setTitle:@"朋友圈" forState:UIControlStateNormal];
        [weChatButtonTimeline setImage:[UIImage imageNamed:@"share_03"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButtonTimeline];
    }
    
    if (isInstallQQ) {
        
        ShareButton *qqButton = [[ShareButton alloc] init];
        qqButton.tag = ShareToQQChat;
        [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqButton setTitle:@"QQ好友" forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"share_04"] forState:UIControlStateNormal];
        [shareArray addObject:qqButton];
        
        ShareButton *qqZoneButton = [[ShareButton alloc] init];
        qqZoneButton.tag = ShareToQQ;
        [qqZoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqZoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
        [qqZoneButton setImage:[UIImage imageNamed:@"share_05"] forState:UIControlStateNormal];
        [shareArray addObject:qqZoneButton];
    }
    
    if (isInstallSina) {
        ShareButton *sinaButton = [[ShareButton alloc] init];
        sinaButton.tag = ShareToSina;
        [sinaButton setTitle:@"微博" forState:UIControlStateNormal];
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sinaButton setImage:[UIImage imageNamed:@"share_06"] forState:UIControlStateNormal];
        [shareArray addObject:sinaButton];
    }
    
    if (shareArray.count > 0) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *shareView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView = shareView;
        [shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewClick)]];
        [window addSubview:shareView];
        
        //遮罩
        UIView *maskView = [[UIView alloc] initWithFrame:shareView.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.7;
        [shareView addSubview:maskView];
        
        //分享模块
        UIView *templateView = [[UIView alloc] initWithFrame:CGRectMake(0, shareView.height, shareView.width, 110)];
        self.templateView = templateView;
        templateView.backgroundColor = [UIColor whiteColor];
        [shareView addSubview:templateView];
        
        //按钮宽高
        CGFloat buttonSize = 55;
        
        //间距
        CGFloat spaing = (templateView.width - (shareArray.count) * buttonSize) / (shareArray.count + 1);
        
        for (int i = 0; i < shareArray.count; i ++) {
            TopImageButton *button = shareArray[i];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i * (buttonSize + spaing) + spaing, 0, buttonSize, buttonSize * 2);
            button.centerY = templateView.height * 0.5;
            [templateView addSubview:button];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            templateView.y = shareView.height - templateView.height;
        }];
    }
}

#pragma mark 遮罩点击
- (void) shareViewClick
{
    if (self.maskView!= nil && self.maskView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.templateView.y = self.maskView.height;
        } completion:^(BOOL finished) {
            [self.templateView removeFromSuperview];
            [self.maskView removeFromSuperview];
        }];
    }
}

#pragma mark 分享按钮点击
- (void) buttonClick : (UIButton *) button
{
    [self shareViewClickWithNoAnimate];
    
    self.shareUrl = [NSString stringWithFormat:@"%@/nodejs/h5/5/discover/course/courseDetail?id=%@&zttshareId=%@&audioCourse=true",NetHeader,self.h5CourseModel.mainid,[self getShareId:[[UserInfoTool getUserInfo].zttid intValue]]];
    
    self.shareTitle = self.h5CourseModel.title;
    self.shareImage = self.h5CourseCell.headerView.image;
    if (self.h5CourseModel.descClearHtml.length > 0) {
        self.shareSummary = self.h5CourseModel.descClearHtml;
    }
    
    switch (button.tag) {
        case ShareToQQ:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case ShareToSina:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            break;
        case ShareToWechatTimeline:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case ShareToQQChat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
        case ShareToWechat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        default:
            break;
    }
}

#pragma mark 生成分享zttshareId
- (NSString *) getShareId : (int) userid
{
    return [NSString stringWithFormat:@"ydxt%@",[self encodeUserid:[NSString stringWithFormat:@"%d",userid]]];
}

#pragma mark 处理分享userid
- (NSString *) encodeUserid : (NSString *) userid
{
    NSData *testData = [userid dataUsingEncoding: NSUTF8StringEncoding];
    
    Byte *testByte = (Byte *)[testData bytes];
    
    int key = 26;
    
    NSMutableString *sb = [NSMutableString string];
    
    for(int i=0;i <[testData length];i++)
    {
        int mm = testByte[i] + 128;
        int p = mm / key;
        int q = mm % key;
        
        [sb appendString:[NSString stringWithFormat:@"%@",[self toNumberSystem:p radix:26]]];
        [sb appendString:[NSString stringWithFormat:@"%@",[self toNumberSystem:q radix:26]]];
    }
    
    return sb;
}

/*
 * 将数值转换成对应的进制
 * i 需要转换的数值
 * radix 需要转换的进制
 */
- (NSString *) toNumberSystem : (int) i radix : (int) radix
{
    if (radix < 2 || radix > 36)
    {
        radix = 10;
    }
    
    if (radix == 10 || radix == -10) {
        return [NSString stringWithFormat:@"%d",i];
    }
    
    NSMutableArray *buf = [NSMutableArray arrayWithCapacity:33];
    for (int i = 0; i < 33; i ++) {
        [buf addObject:@""];
    }
    
    BOOL negative = i < 0 ? YES : NO;
    int charPos = 32;
    if (!negative) {
        i = -i;
    }
    
    while (i <= -radix) {
        buf[charPos--] = self.digits[-(i % radix)];
        i = i / radix;
    }
    
    buf[charPos] = self.digits[-i];
    
    if (negative) {
        buf[charPos] = [NSString stringWithFormat:@"-%@",buf[charPos]];
    }
    
    NSMutableString *result = [NSMutableString string];
    for (NSString *s in buf) {
        [result appendString:s];
    }
    return result;
}

#pragma mark 分享到平台
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareSummary thumImage:self.shareImage];
    
    //设置网页地址
    shareObject.webpageUrl = self.shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
        }else{
            
        }
    }];
}


#pragma mark 删除分享平台不加动画
- (void) shareViewClickWithNoAnimate
{
    if (self.maskView!= nil && self.maskView.superview != nil) {
        [self.templateView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.pageTitle;
}

@end
