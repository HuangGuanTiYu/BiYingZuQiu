//
//  LiveShowViewController.m
//  LiveVideoCoreDemo
//
//  Created by Alex.Shi on 16/3/2.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import "LiveShowViewController.h"
#import "UIButton+UserInfo.h"
#import "XMNShareMenu.h"
#import "Dialogue.h"
//#import "IQKeyboardManager.h"
#import "UIView+Extension.h"

@interface LiveShowViewController()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UIView                     *innerView;
@property(strong, nonatomic) UIActivityIndicatorView    *activityIndicatorView;
@property(nonatomic, strong) UIView                     *AllBackGroudView;
@property(nonatomic, strong) UIButton                   *ExitButton;
@property(nonatomic, strong) UILabel                    *RtmpStatusLabel;
//@property(nonatomic, strong) UILabel                    *teacherName;
@property(nonatomic, strong) UILabel                    *onLineUserNumber;
@property(nonatomic, strong) UIButton                   *CameraChangeButton;
@property(nonatomic, strong) UIButton                   *onlineButton;
@property(nonatomic, strong) UIButton                   *SoundChangeButton;
@property(nonatomic, strong) UIButton                   *beautyButton;
@property(nonatomic, strong) UIButton                   *chatButton;
@property(nonatomic, strong) XMNShareView               *FilterMenu;
@property(nonatomic, assign) Boolean                    bCameraFrontFlag;
@property(nonatomic, assign) NSInteger                  width;
@property(nonatomic, assign) NSInteger                  height;
@property(nonatomic, strong) UIView                     *focusBox;

@property(nonatomic, strong) UITextField                *chatTextField;
@property(nonatomic, strong) UIButton                   *sendButton;
@property(nonatomic, assign) CGFloat                    difference;

@property(nonatomic, strong) UITableView                *tableView;
@property(nonatomic,strong) NSMutableArray              *tableArray;
@property(nonatomic, copy) NSString                     *antename;
@property(nonatomic, copy) NSString                     *anteid;

@property(nonatomic, assign) NSInteger                  onLineCount;
//@property(nonatomic, copy) NSString                     *publisherName;
@property(nonatomic,strong) UIFont                      *font;
@property(nonatomic,assign) BOOL                        isBeautiful;
@property(nonatomic,assign) BOOL                        isQuiet;
@property(nonatomic,strong) NSTimer                     *timer;

//@property(nonatomic,strong) NSString                    *publisherId;
@property(nonatomic,strong) NSMutableDictionary         *onlineUsers;

@property(nonatomic,assign) BOOL                        waterMask;

//在线列表
@property(nonatomic, strong) UITableView *onlineTableView;

//在线列表背景View
@property(nonatomic, strong) UIView *onlineView;

//在线人员姓名列表
@property(nonatomic, strong) NSArray *onlineUesrArray;

@end

@implementation LiveShowViewController

-(void) UIInit {
    float cleaRance = 12;
    float btnWidth = (_width - cleaRance * 8) / 7;
    if (self.IsHorizontal) {
        double fTmp = _height;
        _height = _width;
        _width = fTmp;
        cleaRance = (_width - 7 * btnWidth) / 8;
    }
    CGRect rect = CGRectMake(0, 0, _width, _height);
    self.view.backgroundColor = [UIColor blackColor];
    _AllBackGroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    [self.view addSubview:_AllBackGroudView];
    
    [[CCPushUtil sharedInstanceWithDelegate:self] setPreview:_AllBackGroudView];
    
    _RtmpStatusLabel = [self createLabelWithFrame:CGRectMake(_width - btnWidth - 15, _height - 100 + btnWidth + 3, btnWidth + 15, 28) text:@"未连接" font:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    _RtmpStatusLabel.hidden = YES;
    
    //    _teacherName = [self createLabelWithFrame:CGRectMake(_width - 140, 50, 120, 30) text:@"主播: " font:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    _onLineUserNumber = [self createLabelWithFrame:CGRectMake(_width - 140, 80, 120, 30) text:@"在线人数: " font:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    _chatButton = [self createButtonWith:CGRectMake(20,_height - btnWidth - 10, btnWidth, btnWidth) imageName:@"chat" action:@selector(chatButtonClick)];
    
    _onlineButton = [self createButtonWith:CGRectMake(cleaRance * 3 + btnWidth * 2, _height - btnWidth - 10, btnWidth, btnWidth) imageName:@"user-id" action:@selector(onlineButtonClick:)];
    
    _CameraChangeButton = [self createButtonWith:CGRectMake(cleaRance * 4 + btnWidth * 3, _height - btnWidth - 10, btnWidth, btnWidth) imageName:@"reverse" action:@selector(OnCameraChangeClicked:)];
    
    _SoundChangeButton = [self createButtonWith:CGRectMake(cleaRance * 5 + btnWidth * 4, _height - btnWidth - 10, btnWidth, btnWidth) imageName:@"microphone" action:@selector(soundChange)];
    [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:10];
    
    _beautyButton = [self createButtonWith:CGRectMake(cleaRance * 6 + btnWidth * 5,_height - btnWidth - 10, btnWidth, btnWidth) imageName:@"nobeautiful" action:@selector(beautyFilter)];
    [[CCPushUtil sharedInstanceWithDelegate:self] setCameraBeautyFilterWithSmooth:0 white:0 pink:0];
    
    _ExitButton = [self createButtonWith:CGRectMake(cleaRance * 7 + btnWidth * 6, _height - btnWidth - 10, btnWidth, btnWidth) imageName:@"close" action:@selector(OnExitClicked)];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    
    _focusBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    _focusBox.backgroundColor = [UIColor clearColor];
    _focusBox.layer.borderColor = [UIColor brownColor].CGColor;
    _focusBox.layer.borderWidth = 1.0f;
    _focusBox.hidden = YES;
    [self.view addSubview:_focusBox];
    
    //输入框
    _chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,_height - 100,_width - 100,37)]; //初始化大小并自动释放
    _chatTextField.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _chatTextField.font = [UIFont systemFontOfSize:16];//设置字体名字和字体大小
    _chatTextField.delegate = self;//设置它的委托方法
    _chatTextField.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    _chatTextField.returnKeyType = UIReturnKeySend;//返回键的类型
    _chatTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _chatTextField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _chatTextField.placeholder = @" 请输入文字";
    _chatTextField.layer.masksToBounds = YES;
    _chatTextField.layer.cornerRadius = _chatTextField.frame.size.height / 2;
    _chatTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    _chatTextField.layer.borderWidth = 0.6f;
    _chatTextField.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.view addSubview:_chatTextField];//加入到整个页面中
    [_chatTextField setHidden:YES];
    
    //发送
    _sendButton = [[UIButton alloc]initWithFrame:CGRectMake(_width - 100 + 20, _height - 100,70 , 37)];
    [_sendButton setBackgroundColor:[UIColor colorWithRed:142/255.0 green:226/255.0 blue:211/255.0 alpha:1.0]];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(chatSendMessage) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.layer.masksToBounds = YES;
    _sendButton.layer.cornerRadius = _sendButton.frame.size.height / 3;
    [self.view addSubview:_sendButton];
    [_sendButton setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,_chatTextField.frame.origin.y + _chatTextField.frame.size.height - _height * 0.3, _width * 0.75, _height * 0.3) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _innerView = [[UIView alloc] initWithFrame:rect];
    _innerView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    [self.view addSubview:_innerView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [_activityIndicatorView startAnimating];
    [_innerView addSubview:_activityIndicatorView];
    
}
#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_chatTextField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.onlineTableView) {
        return self.onlineUesrArray.count;
    }
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.onlineTableView) {
        static NSString *CellIdentifier = @"OnlineCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        }
        cell.backgroundColor = [UIColor blackColor];
        cell.alpha = 0.7;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = self.onlineUesrArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    } else {
        for(UIView *cellView in cell.subviews){
            [cellView removeFromSuperview];
        }
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Dialogue *dialogue = [_tableArray objectAtIndex:indexPath.row];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, dialogue.userNameSize.width, dialogue.userNameSize.height)];
    [button setTitle:dialogue.username forState:UIControlStateNormal];
    button.titleLabel.font = _font;
    [button setUserid:dialogue.userid];
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(antesomeone:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:button];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:dialogue.msg];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = dialogue.userNameSize.width;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, dialogue.msgSize.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = _font;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.attributedText = text;
    [cell addSubview:label];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.onlineTableView) {
        return 44;
    }
    Dialogue *dialogue = [_tableArray objectAtIndex:indexPath.row];
    return dialogue.msgSize.height + 10;
}

#pragma mark keyboard notification

- (void)keyboardWillShow:(NSNotification *)notif {
    
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat y = keyboardRect.size.height;
    //    CGFloat x = keyboardRect.size.width;
    //    //NSLog(@"键盘高度是  %d",(int)y);
    //    //NSLog(@"键盘宽度是  %d",(int)x);
    _isBeautiful = false;
    _difference = 0.0;
    if ([_chatTextField isFirstResponder] == true && (self.height - (_chatTextField.frame.origin.y + 37 + 10) < y)) {
        self.difference = y - (self.height - (_chatTextField.frame.origin.y + 37 + 5));
        [UIView animateWithDuration:0.25f animations:^{
            [_chatTextField setHidden:NO];
            [_sendButton setHidden:NO];
            _chatTextField.frame = CGRectMake(10, _chatTextField.frame.origin.y - self.difference, _width - 100,37);
            _sendButton.frame = CGRectMake(_width - 100 + 20, _sendButton.frame.origin.y - self.difference,70 , 37);
            _tableView.frame = CGRectMake(10,_chatTextField.frame.origin.y - 5 - _height * 0.3, _width * 0.75, _height * 0.3);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif {
    [UIView animateWithDuration:0.25f animations:^{
        _chatTextField.frame = CGRectMake(10,_height - 100,_width - 100,37);
        [_chatTextField setHidden:YES];
        [_sendButton setHidden:YES];
        _sendButton.frame = CGRectMake(_width - 100 + 20, _height - 100,70 , 37);
        _tableView.frame = CGRectMake(10,_chatTextField.frame.origin.y + _chatTextField.frame.size.height - _height * 0.3, _width * 0.75, _height * 0.3);
    }];
    self.difference = 0;
}

-(void)antesomeone:(UIButton *)sender {
    NSString *str = [sender titleForState:UIControlStateNormal];
    
    NSRange range = [str rangeOfString:@": "];
    if(range.location == NSNotFound) {
        _antename = str;
    } else {
        _antename = [str substringToIndex:range.location];
    }
    //    NSLog(@"str = %@,range = %@,_antename = %@",str,NSStringFromRange(range),_antename);
    _anteid = sender.userid;
    _chatTextField.text = [[@"@"stringByAppendingString:_antename]stringByAppendingString:@" "];
    [_chatTextField becomeFirstResponder];
}

-(void)chatSendMessage {
    NSString *str = _chatTextField.text;
    if(str == nil || str.length == 0) {
        return;
    }
    
    if([_antename length] == 0) {
        if([str length] == 0) return;
        [[CCPushUtil sharedInstanceWithDelegate:self] chatMessage:str];
    } else {
        NSString *subStr = [[@"@"stringByAppendingString:_antename] stringByAppendingString:@" "];
        NSRange range = [str rangeOfString:subStr];
        NSString *msgStr = [str substringFromIndex:(range.location + range.length)];
        //        NSLog(@"msgStr = %@,_anteid = %@",msgStr,_anteid);
        
        if([msgStr length] != 0) {
            [[CCPushUtil sharedInstanceWithDelegate:self]privateChatWithTouserid:_anteid msg:msgStr];
        }
        _antename = nil;
    }
    _chatTextField.text = nil;
    [_chatTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self chatSendMessage];
    return YES;
}

-(UIButton *)createButtonWith:(CGRect)rect imageName:(NSString *)imageName action:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

-(UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    if(font) {
        label.font = font;
    }
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    return label;
}

- (ASValueTrackingSlider *)createSliderWithFrame:(CGRect)rect {
    ASValueTrackingSlider *slider = [[ASValueTrackingSlider alloc] initWithFrame:rect];
    slider.hidden = YES;
    slider.maximumValue = 10.0;
    slider.minimumValue = 0.0;
    slider.popUpViewCornerRadius = 4;
    [slider setMaxFractionDigitsDisplayed:0];
    slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    slider.font = [UIFont fontWithName:@"GillSans-Bold" size:18];
    slider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    slider.popUpViewWidthPaddingFactor = 1.7;
    slider.delegate = self;
    slider.value = 0.0;
    [self.view addSubview:slider];
    slider.dataSource = self;
    return slider;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)chatButtonClick {
    [_chatTextField becomeFirstResponder];
}

- (void)beautyFilter {
    if(_isBeautiful) {
        [[CCPushUtil sharedInstanceWithDelegate:self] setCameraBeautyFilterWithSmooth:0 white:0 pink:0];
        [_beautyButton setImage:[UIImage imageNamed:@"nobeautiful"] forState:UIControlStateNormal];
    } else {
        [[CCPushUtil sharedInstanceWithDelegate:self] setCameraBeautyFilterWithSmooth:0.5 white:0.5 pink:0.5];
        [_beautyButton setImage:[UIImage imageNamed:@"beautiful"] forState:UIControlStateNormal];
    }
    _isBeautiful = !_isBeautiful;
}

-(void)soundChange {
    if(_isQuiet) {
        [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:10];
        [_SoundChangeButton setImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
    } else {
        [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:0];
        [_SoundChangeButton setImage:[UIImage imageNamed:@"nomicrophone"] forState:UIControlStateNormal];
    }
    _isQuiet = !_isQuiet;
}

-(void)dealloc {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void) onlineButtonClick : (id) sender
{
    [self timerfunc];
    
    self.onlineView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.onlineView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onlineViewClick)]];
    [self.view addSubview:self.onlineView];
    
    self.onlineTableView = [[UITableView alloc] initWithFrame:CGRectMake(_onLineUserNumber.x, self.view.height, self.view.width - _onLineUserNumber.x, CGRectGetMaxY(_onLineUserNumber.frame) - _ExitButton.y)];
    self.onlineTableView.backgroundColor = [UIColor blackColor];
    self.onlineTableView.alpha = 0.7;
    self.onlineTableView.delegate = self;
    self.onlineTableView.dataSource = self;
    [self.view addSubview:self.onlineTableView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.onlineTableView.y = CGRectGetMaxY(_onLineUserNumber.frame);
    }];
}

#pragma mark 在线列表背景点击
- (void) onlineViewClick
{
    if (self.onlineTableView != nil && self.onlineTableView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.onlineTableView.y = self.view.height;
        } completion:^(BOOL finished) {
            [self.onlineTableView removeFromSuperview];
            if(self.onlineView != nil && self.onlineView.superview != nil)
            {
                [self.onlineView removeFromSuperview];
            }
        }];
    }
}


-(void) OnCameraChangeClicked:(id)sender{
    //    [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:nil rect:CGRectZero];
    
    _bCameraFrontFlag = !_bCameraFrontFlag;
    [[CCPushUtil sharedInstanceWithDelegate:self] setCameraFront:_bCameraFrontFlag];
    
    if (self.waterMask)
    {
        UIImage *image = [UIImage imageNamed:@"3"];
        CGRect rect = CGRectMake(0, 0, image.size.width/2.f, image.size.height/2.f);
        [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:image rect:rect];
    }
}

- (void)dealSingleTap:(UITapGestureRecognizer *)tap
{
    [_chatTextField resignFirstResponder];
}

-(void) OnExitClicked {
    [self stopTimer];
    [[CCPushUtil sharedInstanceWithDelegate:self] stopPush];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if(self.IsHorizontal){
        bool bRet = ((toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft));
        return bRet;
    }else{
        return false;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if(self.IsHorizontal){
        return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerfunc) userInfo:nil repeats:YES];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.navigationController.navigationBarHidden=YES;
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    _bCameraFrontFlag = false;
    _isQuiet = false;
    _tableArray = [[NSMutableArray alloc] init];
    _onLineCount = 0;
    _font = [UIFont systemFontOfSize:18];
    
    [self UIInit];
    [[CCPushUtil sharedInstanceWithDelegate:self] startPushWithCameraFront:YES];
    
    self.onlineUesrArray = [NSArray array];
}

-(void) stopTimer {
    if([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value{
    [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:value/10.0];
    return nil;
}

- (void)timerfunc {
    [[CCPushUtil sharedInstanceWithDelegate:self] roomContext];
    [[CCPushUtil sharedInstanceWithDelegate:self] roomUserCount];
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider {
    return;
}
/**
 *	@brief	正在连接网络，UI不可动
 */
- (void) isConnectionNetWork {
    _innerView.hidden = NO;
}
/**
 *	@brief	连接网络完成
 */
- (void) connectedNetWorkFinished {
    _innerView.hidden = YES;
}

/**
 *	@brief	设置连接状态
 */
- (void) setConnectionStatus:(NSInteger)status {
    switch (status) {
        case 1:
            _RtmpStatusLabel.text = @"正在连接";
            break;
        case 3:
            _RtmpStatusLabel.text = @"已连接";
            break;
        case 5:
            _RtmpStatusLabel.text = @"未连接";
            break;
        default:
            break;
    }
}

/**
 *	@brief	推流失败
 */
-(void)pushFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    _innerView.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推流失败" message:[@"原因：" stringByAppendingString:message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

/**
 *	@brief	点击开始推流按钮，获取liveid
 */
- (void) getLiveidBeforPush:(NSString *)liveid {
    //    NSLog(@"liveid = %@",liveid);
}

-(CGSize)getTitleSizeByFont:(NSString *)str width:(CGFloat)width font:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (void)on_private_chat:(NSString *)str {
    //    NSLog(@"on_private_chat = %@",str);
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    Dialogue *dialogue = [[Dialogue alloc] init];
    dialogue.fromuserid = dic[@"fromuserid"] ;
    dialogue.fromusername = dic[@"fromusername"];
    dialogue.fromuserrole = dic[@"fromuserrole"];
    
    dialogue.touserid = dic[@"touserid"];
    dialogue.tousername = dic[@"tousername"];
    
    dialogue.username = dialogue.fromusername;
    dialogue.userid = dialogue.fromuserid;
    
    dialogue.msg = [[[@" 对 " stringByAppendingString:dialogue.tousername] stringByAppendingString:@": "] stringByAppendingString:dic[@"msg"]];
    dialogue.time = dic[@"time"];
    
    dialogue.msgSize = [self getTitleSizeByFont:[dialogue.username stringByAppendingString:dialogue.msg] width:_tableView.frame.size.width font:_font];
    
    dialogue.userNameSize = [self getTitleSizeByFont:dialogue.username width:_tableView.frame.size.width font:_font];
    
    [_tableArray addObject:dialogue];
    
    if([_tableArray count] >= 1){
        [_tableView reloadData];
        NSIndexPath *indexPathLast = [NSIndexPath indexPathForItem:([_tableArray count]-1) inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPathLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

//- (void)private_question:(NSString *)str {
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//
//    Dialogue *dialogue = [[Dialogue alloc] init];
//    dialogue.userid = dic[@"userid"];
//    dialogue.username = dic[@"username"];
//    dialogue.userrole = dic[@"userrole"];
//    dialogue.msg = [[[@" 对 "stringByAppendingString:@"我"] stringByAppendingString:@": "] stringByAppendingString:dic[@"msg"]];
//    dialogue.time = dic[@"time"];
//
//    dialogue.msgSize = [self getTitleSizeByFont:[dialogue.username stringByAppendingString:dialogue.msg] width:_tableView.frame.size.width font:_font];
//
//    dialogue.userNameSize = [self getTitleSizeByFont:dialogue.username width:_tableView.frame.size.width font:_font];
//
//    [_tableArray addObject:dialogue];
//
//    if([_tableArray count] >= 1){
//        [_tableView reloadData];
//        NSIndexPath *indexPathLast = [NSIndexPath indexPathForItem:([_tableArray count]-1) inSection:0];
//        [_tableView scrollToRowAtIndexPath:indexPathLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
//}

- (void)on_chat_message:(NSString *)str {
    //    NSLog(@"on_chat_message = %@",str);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    Dialogue *dialogue = [[Dialogue alloc] init];
    dialogue.userid = dic[@"userid"];
    dialogue.username = [dic[@"username"] stringByAppendingString:@": "];
    dialogue.userrole = dic[@"userrole"];
    dialogue.msg = dic[@"msg"];
    dialogue.time = dic[@"time"];
    
    dialogue.msgSize = [self getTitleSizeByFont:[dialogue.username stringByAppendingString:dialogue.msg] width:_tableView.frame.size.width font:_font];
    
    dialogue.userNameSize = [self getTitleSizeByFont:dialogue.username width:_tableView.frame.size.width font:_font];
    
    [_tableArray addObject:dialogue];
    
    if([_tableArray count] >= 1){
        [_tableView reloadData];
        NSIndexPath *indexPathLast = [NSIndexPath indexPathForItem:([_tableArray count]-1) inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPathLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)room_user_count:(NSString *)str {
    _onLineCount = [str integerValue];
    _onLineUserNumber.text = [@"在线人数: " stringByAppendingString:str];
}

- (void)receivePublisherId:(NSString *)str onlineUsers:(NSMutableDictionary *)dict {
    //    _publisherId = str;
        _onlineUsers = dict;
    
    if (dict.allValues.count > 0) {
        self.onlineUesrArray = dict.allValues;
        [self.onlineTableView reloadData];
    }
}

- (void)stopPushSuccessful {
    //    NSLog(@"退出推流成功！");
}


- (void)customMessage:(NSString *)message {
    //        NSLog(@"message = %@",message);
}

@end
