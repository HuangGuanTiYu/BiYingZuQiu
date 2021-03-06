//
//  CourseLiveController.m
//  MoveSchool
//
//  Created by edz on 2017/6/3.
//
//

#import "DownLoadCourseLiveController.h"
#import "DWMoviePlayerController.h"
#import "DWTools.h"
#import "LeftStyleButton.h"
#import "DWPlayerMenuView.h"
#import "DWTableView.h"
#import "AFNetWW.h"
#import "TopImageButton.h"
#import "ChapterModel.h"
#import "Reachability.h"
#import "CourseProgressTool.h"
#import "CourseProgresModel.h"

@interface DownLoadCourseLiveController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic)DWMoviePlayerController *player;

//清晰度
@property (strong, nonatomic)NSArray *qualityDescription;

//当前清晰度
@property (strong, nonatomic)NSString *currentQuality;

@property (strong, nonatomic)UIView *videoBackgroundView;

@property (strong, nonatomic)UIView *overlayView;

@property (strong, nonatomic) UILabel *currentPlaybackTimeLabel;

@property (strong, nonatomic)NSTimer *timer;

@property (strong, nonatomic)UISlider *durationSlider;

@property (strong, nonatomic)UILabel *durationLabel;

@property (assign, nonatomic) BOOL hiddenAll;

@property (strong, nonatomic) UIView *footerView;

@property (strong, nonatomic) UIView *headerView;

//清晰度背景图
@property (strong, nonatomic)DWPlayerMenuView *qualityView;

//清晰度按钮
@property (strong, nonatomic) UIButton *qualityButton;

//清晰度列表
@property (strong, nonatomic)DWTableView *qualityTable;

@property (strong, nonatomic)NSDictionary *playUrls;

@property (strong, nonatomic)NSDictionary *currentPlayUrl;

@property (strong, nonatomic) UIView *nextMaskView;

@property (strong, nonatomic) LeftStyleButton *backButton;

@end

@implementation DownLoadCourseLiveController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        
        NSString *progres = [NSString stringWithFormat:@"%f",self.player.currentPlaybackTime];
        
        CourseProgresModel *model = [[CourseProgresModel alloc] init];
        model.courseid = self.chapterid;
        model.progres = progres;
        
        for (CourseProgresModel *models in [CourseProgressTool progress]) {
            if (models.courseid == model.courseid) {
                return;
            }
        }
        
        [CourseProgressTool saving:model];
        
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,LearnRecord,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"courseid" : self.chapterid,
                        @"learntime" : [NSString stringWithFormat:@"%f",self.player.currentPlaybackTime]
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    [self.player cancelRequestPlayInfo];
    
    self.player.currentPlaybackTime = self.player.duration;
    self.player.contentURL = nil;
    
    [self removeTimer];
    
    // 显示 navigationController
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.format == 0) {
        //加载网络视频
        [self loadPlayUrls];
    } else if (self.format == 2) {
        
        //自己服务器的视频
        _player = [[DWMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.videoLocalPath]];
    }else if(self.format == 3)
    {
        _player = [[DWMoviePlayerController alloc] initWithUserId:DWACCOUNT_USERID key:DWACCOUNT_APIKEY];
    }
    
    [self addObserverForMPMoviePlayController];
    [self addTimer];
    
    self.player.scalingMode = MPMovieScalingModeAspectFill;
    self.player.controlStyle = MPMovieControlStyleNone;
    
    _qualityDescription = @[@"清晰", @"高清"];
    
    _currentQuality = [_qualityDescription objectAtIndex:0];
    
    // 加载播放器 必须第一个加载
    [self loadPlayer];
    
    [self setUpUI];
    
    if (self.format == 0) {
        // 获取videoId的播放url
        [self playLocalVideo];
        
    } else if (self.format == 2) {
        // 播放自己服务器视频
        [self playLocalVideo];
    }else if(self.format == 3)
    {
        //播放本地视频
        [self playMobileLocalVideo];
    }
    
}

- (void) playMobileLocalVideo
{
    self.playUrls = [NSDictionary dictionaryWithObject:self.videoLocalPath forKey:@"playurl"];
    
    self.player.contentURL = [[NSURL alloc] initFileURLWithPath:self.videoLocalPath];
    
    [self.player prepareToPlay];
    [self.player play];
}

- (void) setUpUI
{
    CGRect frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
    
    self.videoBackgroundView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.videoBackgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.videoBackgroundView];
    
    self.player.scalingMode = MPMovieScalingModeAspectFit;
    self.player.controlStyle = MPMovieControlStyleNone;
    self.player.view.backgroundColor = [UIColor clearColor];
    self.player.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self.videoBackgroundView addSubview:self.player.view];
    
    self.overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    UITapGestureRecognizer *signelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSignelTap:)];
    signelTap.numberOfTapsRequired = 1;
    signelTap.delegate = self;
    [self.overlayView addGestureRecognizer:signelTap];
    [self.view addSubview:self.overlayView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.overlayView.height - 50, self.overlayView.width, 50)];
    self.footerView = footerView;
    self.footerView.hidden = YES;
    footerView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.9];
    [self.overlayView addSubview:footerView];
    
    //播放按钮
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(22, 0, 30, 30)];
    startButton.centerY = footerView.height *0.5;
    [startButton setImage:[UIImage imageNamed:@"player-pausebutton"] forState:UIControlStateNormal];
    [startButton setImage:[UIImage imageNamed:@"player-playbutton"] forState:UIControlStateSelected];
    [startButton addTarget:self action:@selector(playbackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:startButton];
    
    //当前时间
    UILabel *currentPlaybackTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startButton.frame) + mainSpacing, 0, 60, 20)];
    self.currentPlaybackTimeLabel = currentPlaybackTimeLabel;
    currentPlaybackTimeLabel.centerY = footerView.height * 0.5;
    currentPlaybackTimeLabel.text = @"00:00:00";
    currentPlaybackTimeLabel.textColor = [UIColor whiteColor];
    currentPlaybackTimeLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:currentPlaybackTimeLabel];
    
    // 视频总时间
    UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(footerView.width - 60 - 22, 0, 60, 20)];
    self.durationLabel = durationLabel;
    durationLabel.centerY = footerView.height * 0.5;
    durationLabel.textColor = [UIColor whiteColor];
    durationLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:durationLabel];
    
    //滑动条
    self.durationSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(currentPlaybackTimeLabel.frame) + mainSpacing, 0, durationLabel.x - mainSpacing * 2 - CGRectGetMaxX(currentPlaybackTimeLabel.frame), 30)];
    self.durationSlider.centerY = footerView.height * 0.5;
    [footerView addSubview:self.durationSlider];
    
    [self durationSlidersetting];
    
    //头部
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.overlayView.width, 38)];
    self.headerView = headerView;
    headerView.hidden = YES;
    headerView.backgroundColor = footerView.backgroundColor;
    [self.overlayView addSubview:headerView];
    
    //返回按钮
    LeftStyleButton *backButton = [[LeftStyleButton alloc] initWithFrame:CGRectMake(mainSpacing, 0, frame.size.width * 0.5, 30)];
    backButton.centerY = headerView.height * 0.5;
    [backButton setImage:[UIImage imageNamed:@"player-back-button"] forState:UIControlStateNormal];
    self.backButton = backButton;
    [backButton setTitle:self.liveTitle forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    
    //下一个视频 遮罩
    UIView *nextMaskView = [[UIView alloc] initWithFrame:self.overlayView.bounds];
    self.nextMaskView = nextMaskView;
    nextMaskView.hidden = YES;
    nextMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.overlayView addSubview:nextMaskView];
    
    //下一个视频按钮
    TopImageButton *nextButton = [[TopImageButton alloc] initWithFrame:CGRectMake(0, 0, 86, 126)];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    nextButton.centerX = self.overlayView.width * 0.5;
    nextButton.centerY = self.overlayView.height * 0.5;
    nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [nextButton setImage:[UIImage imageNamed:@"icon_player"] forState:UIControlStateNormal];
    [nextButton setTitle:@"播放下一节" forState:UIControlStateNormal];
    [nextMaskView addSubview:nextButton];
    
    [self loadQualityView];
}

# pragma mark 清晰度
- (void)loadQualityView
{
    //清晰度
    UIButton *qualityButton = [[UIButton alloc] initWithFrame:CGRectMake(self.headerView.width - 60 - 22, 0, 60, 20)];
    self.qualityButton = qualityButton;
    qualityButton.centerY = self.headerView.height * 0.5;
    [qualityButton addTarget:self action:@selector(qualityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [qualityButton setTitle:_currentQuality forState:UIControlStateNormal];
    [qualityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qualityButton.titleLabel.font = [UIFont systemFontOfSize:12];
    qualityButton.contentMode = UIViewContentModeCenter;
    qualityButton.layer.borderColor = [UIColor whiteColor].CGColor;
    qualityButton.layer.borderWidth = 1;
    qualityButton.backgroundColor = [UIColor clearColor];
    [self.headerView addSubview:qualityButton];
    
    if (self.format == 2 || self.format == 3) { //自己服务器的视频不需要 切换清晰度
        qualityButton.hidden = YES;
    }
    
    self.qualityView = [[DWPlayerMenuView alloc]
                        initWithFrame:CGRectMake(self.qualityButton.x, CGRectGetMaxY(self.qualityButton.frame), 60, self.qualityDescription.count * 30 + 9)
                        andTriangelHeight:8
                        FillColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    self.qualityView.hidden = YES;
    self.qualityView.backgroundColor = [UIColor clearColor];
    
    [self.overlayView addSubview:self.qualityView];
    
    
    self.qualityTable = [[DWTableView alloc] initWithFrame:CGRectMake(0, mainSpacing, self.qualityView.width, self.qualityView.height) style:UITableViewStylePlain];
    self.qualityTable.rowHeight = 30;
    self.qualityTable.backgroundColor = [UIColor clearColor];
    [self.qualityTable resetDelegate];
    self.qualityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.qualityTable.scrollEnabled = NO;
    [self.qualityView addSubview:self.qualityTable];
    
    __weak DownLoadCourseLiveController *blockSelf = self;
    self.qualityTable.tableViewNumberOfRowsInSection = ^NSInteger(UITableView *tableView, NSInteger section) {
        return blockSelf.qualityDescription.count;
    };
    
    self.qualityTable.tableViewCellForRowAtIndexPath = ^UITableViewCell*(UITableView *tableView, NSIndexPath *indexPath) {
        static NSString *cellId = @"qualityTableCellId";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell.textLabel sizeToFit];
        cell.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row == 0) {
            // 清晰度：清晰
            cell.selected = YES;
            cell.textLabel.text = [blockSelf.qualityDescription objectAtIndex:0];
            cell.textLabel.textColor = [UIColor greenColor];
            
        } else if (indexPath.row == 1) {
            // 清晰度：高清
            cell.textLabel.text = [blockSelf.qualityDescription objectAtIndex:1];
        }
        
        return cell;
    };
    
    
    self.qualityTable.tableViewDidSelectRowAtIndexPath = ^void(UITableView *tableView, NSIndexPath *indexPath) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
        
        // 更新表格文字颜色，已选中行为蓝色，为选中行为白色。
        UITableViewCell *cell = [blockSelf.qualityTable cellForRowAtIndexPath:indexPath];
        NSArray *cells = [blockSelf.qualityTable visibleCells];
        for (UITableViewCell *cl in cells) {
            if (cl == cell) {
                cl.textLabel.textColor = [UIColor greenColor];
                
            } else {
                cl.textLabel.textColor = [UIColor whiteColor];
            }
        }
        
        if (indexPath.row == 0) {
            [blockSelf switchQuality:0];
            
        } else if (indexPath.row == 1) {
            [blockSelf switchQuality:1];
        }
    };
}

#pragma mark 选择清晰度
- (void)switchQuality:(NSInteger)index
{
    NSInteger currentQualityIndex =  [[self.playUrls objectForKey:@"qualities"] indexOfObject:self.currentPlayUrl];
    
    if (index == currentQualityIndex) {
        // 不需要切换
        return;
    }
    
    [self.player stop];
    self.currentPlayUrl = [[self.playUrls objectForKey:@"qualities"] objectAtIndex:index];
    self.currentQuality = [self.currentPlayUrl objectForKey:@"desp"];
    [self.qualityButton setTitle:self.currentQuality forState:UIControlStateNormal];
    [self qualityButtonClick];
    
    [self resetPlayer];
}

#pragma mark 重新加载调整清晰度
- (void)resetPlayer
{
    self.player.contentURL = [NSURL URLWithString:[self.currentPlayUrl objectForKey:@"playurl"]];
    
    [self.player prepareToPlay];
    [self.player play];
    
}

-(void)durationSlidersetting
{
    self.durationSlider.minimumValue = 0.0f;
    self.durationSlider.maximumValue = 1.0f;
    self.durationSlider.value = 0.0f;
    self.durationSlider.continuous = NO;
    [self.durationSlider setMaximumTrackImage:[UIImage imageNamed:@"player-slider-inactive"]
                                     forState:UIControlStateNormal];
    [self.durationSlider setMinimumTrackImage:[UIImage imageNamed:@"player-slider-active"]
                                     forState:UIControlStateNormal];
    [self.durationSlider setThumbImage:[UIImage imageNamed:@"player-slider-handle"]
                              forState:UIControlStateNormal];
}

# pragma mark - 加载播放器
- (void)loadPlayer
{
    self.videoBackgroundView = [[UIView alloc] init];
    self.videoBackgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.videoBackgroundView];
}

# pragma mark - 播放本地文件

- (void)playLocalVideo
{
    [self.player prepareToPlay];
    [self.player play];
}

# pragma mark - 播放视频
- (void)loadPlayUrls
{
    _player = [[DWMoviePlayerController alloc] initWithUserId:DWACCOUNT_USERID key:DWACCOUNT_APIKEY];
    _player.currentPlaybackTime = 20;
    _player.initialPlaybackTime = 20;
    [_player setCurrentPlaybackTime:20];
    
    self.player.videoId = self.videoId;
    self.player.timeoutSeconds = 10;
    [self.player setCurrentPlaybackTime:20];
    
    __weak DownLoadCourseLiveController *blockSelf = self;
    self.player.failBlock = ^(NSError *error) {
    };
    
    self.player.getPlayUrlsBlock = ^(NSDictionary *playUrls) {
        // [必须]判断 status 的状态，不为"0"说明该视频不可播放，可能正处于转码、审核等状态。
        blockSelf.playUrls = playUrls;
        
        [blockSelf resetViewContent];
    };
    
    [self.player startRequestPlayInfo];
}

- (void)resetViewContent
{
    // 获取默认清晰度播放url
    NSNumber *defaultquality = [self.playUrls objectForKey:@"defaultquality"];
    
    for (NSDictionary *playurl in [self.playUrls objectForKey:@"qualities"]) {
        if (defaultquality == [playurl objectForKey:@"quality"]) {
            self.currentPlayUrl = playurl;
            break;
        }
    }
    
    if (!self.currentPlayUrl) {
        self.currentPlayUrl = [[self.playUrls objectForKey:@"qualities"] objectAtIndex:0];
    }
    
    
    if (self.videoId) {
        [self resetQualityView];
    }
    
    [self.player prepareToPlay];
    
    [self.player play];
    
}

- (void)resetQualityView
{
    self.qualityDescription = [self.playUrls objectForKey:@"qualityDescription"];
    
    // 设置当前清晰度
    NSNumber *defaultquality = [self.playUrls objectForKey:@"defaultquality"];
    
    for (NSDictionary *playurl in [self.playUrls objectForKey:@"qualities"]) {
        if (defaultquality == [playurl objectForKey:@"quality"]) {
            self.currentQuality = [playurl objectForKey:@"desp"];
            break;
        }
    }
    
    // 由于每个视频的清晰度种类不同，所以这里需要重新加载
    [self reloadQualityView];
}

- (void)reloadQualityView
{
    [self.qualityButton removeFromSuperview];
    self.qualityButton.hidden = YES;
    self.qualityButton = nil;
    
    [self.qualityTable removeFromSuperview];
    self.qualityTable.hidden = YES;
    self.qualityTable = nil;
    
    [self.qualityView removeFromSuperview];
    self.qualityView.hidden = YES;
    self.qualityView = nil;
    
    [self loadQualityView];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
}

- (void)removeTimer
{
    [self.timer invalidate];
}

- (void)timerHandler
{
    self.currentPlaybackTimeLabel.text = [DWTools formatSecondsToString:self.player.currentPlaybackTime];
    
    self.durationSlider.value = (int)self.player.currentPlaybackTime;
    
    
    if ([self.currentPlaybackTimeLabel.text isEqualToString:self.durationLabel.text]) {
        
        [self removeTimer];
        
        if (self.model != nil && self.captions.count > 0) {
            int index = (int)[self.captions indexOfObject:self.model];
            if (index == self.captions.count - 1) { //最后一个章节
                
            }else
            {
                self.nextMaskView.hidden = NO;
            }
        }
        
    }
}

#pragma mark 单击
- (void) handleSignelTap : (UIGestureRecognizer *) recognizer
{
    if (self.hiddenAll) {
        [self showHiddenBasicViews:YES];
        
    } else {
        [self showHiddenBasicViews:NO];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

- (void)showHiddenBasicViews : (BOOL) hidden
{
    self.footerView.hidden = hidden;
    self.headerView.hidden = hidden;
    if (hidden) {
        self.qualityView.hidden = hidden;
        self.qualityTable.hidden = hidden;
    }
    
    self.hiddenAll = !hidden;
}

# pragma mark - MPMoviePlayController Notifications
- (void)addObserverForMPMoviePlayController
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    // MPMovieDurationAvailableNotification
    [notificationCenter addObserver:self selector:@selector(moviePlayerDurationAvailable) name:MPMovieDurationAvailableNotification object:self.player];
}

- (void)moviePlayerDurationAvailable
{
    self.durationLabel.text = [DWTools formatSecondsToString:self.player.duration];
    self.durationSlider.minimumValue = 0.0;
    self.durationSlider.maximumValue = (int)self.player.duration;
}

#pragma mark 播放暂停
- (void) playbackButtonAction : (UIButton *) button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        [self.player pause];
    }else
    {
        [self.player play];
    }
}

#pragma mark 返回按钮
- (void) backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 选择清晰度
- (void) qualityButtonClick
{
    if (self.qualityView.hidden == NO) {
        self.qualityView.hidden = YES;
        self.qualityTable.hidden = YES;
        return;
    }
    self.qualityView.hidden = NO;
    self.qualityTable.hidden = NO;
}

#pragma mark 播放下一节
- (void) nextButtonClick
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,LearnRecord,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"courseid" : self.chapterid,
                        @"learntime" : [NSString stringWithFormat:@"%f",self.player.currentPlaybackTime]
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
        }
    } fail:^(NSError *error) {
        
    }];
    
    int index = (int)[self.captions indexOfObject:self.model];
    
    ChapterModel *model = self.captions[index + 1];
    self.chapterid = model.courseid;
    self.model = model;
    self.videoId = model.ccid;
    [self.backButton setTitle:model.chapterTitle forState:UIControlStateNormal];
    
    [self addTimer];
    [self.player stop];
    
    self.player.videoId = self.videoId;
    self.player.timeoutSeconds = 10;
    [self.player setCurrentPlaybackTime:20];
    
    __weak DownLoadCourseLiveController *blockSelf = self;
    self.player.failBlock = ^(NSError *error) {
    };
    
    self.player.getPlayUrlsBlock = ^(NSDictionary *playUrls) {
        // [必须]判断 status 的状态，不为"0"说明该视频不可播放，可能正处于转码、审核等状态。
        blockSelf.playUrls = playUrls;
        
        [blockSelf resetViewContent];
    };
    
    [self.player startRequestPlayInfo];
    
    self.nextMaskView.hidden = YES;
}

@end
