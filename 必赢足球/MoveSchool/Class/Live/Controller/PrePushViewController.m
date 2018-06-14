//
//  ViewController.m
//  LiveVideoCoreDemo
//
//  Created by Alex.Shi on 16/3/2.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import "PrePushViewController.h"
#import "ASValueTrackingSlider.h"
#import "CCPush/CCPushUtil.h"
#import "ZJSwitch.h"
#import "ColorTypeTools.h"

@interface PrePushViewController () <ASValueTrackingSliderDataSource, ASValueTrackingSliderDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate, CCPushUtilDelegate>

@property(nonatomic, strong) ASValueTrackingSlider      *BitSlider;
@property(nonatomic, strong) UIButton                   *StartButton;
@property(nonatomic, assign) NSInteger                  width;
@property(nonatomic, assign) NSInteger                  height;
//横竖屏推流
@property (strong, nonatomic) UITextField               *textFieldIsPortrait;
//分辨率
@property (strong, nonatomic) UITextField               *textFieldSize;
//帧  率
@property (strong, nonatomic) UITextField               *textFieldFrameRate;
@property (strong, nonatomic) UITableView               *tableViewIsPortrait;
@property (strong, nonatomic) UITableView               *tableViewSize;
@property (strong, nonatomic) UITableView               *tableViewFrameRate;
@property (strong, nonatomic) NSArray                   *arrayIsPortrait;
@property (strong, nonatomic) NSArray                   *arraySize;
@property (strong, nonatomic) NSArray                   *arrayFrameRate;

@property (assign, nonatomic) BOOL                      showList;

@property (nonatomic, assign) Boolean                   IsHorizontal;
//分辨率
@property (nonatomic, assign) CGSize                    size;
//码率
@property (nonatomic, assign) NSInteger                 bitRate;
//帧率
@property (nonatomic, assign) NSInteger                 frameRate;

@end

@implementation PrePushViewController

-(void)OnStartLiveClicked:(id)sender {
    _LiveShowViewController = [[LiveShowViewController alloc] init];
    _LiveShowViewController.IsHorizontal = _IsHorizontal;
    
    float width = _size.width;
    float height = _size.height;
    if (_IsHorizontal) {
        _size.width = MAX(width, height);
        _size.height = MIN(width, height);
    } else {
        _size.width = MIN(width, height);
        _size.height = MAX(width, height);
    }
    [[CCPushUtil sharedInstanceWithDelegate:self] setVideoSize:_size BitRate:(int)_bitRate FrameRate:(int)_frameRate];
    [self presentViewController:_LiveShowViewController animated:YES completion:nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return false;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIButton *)createButtonWith:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [self.view addSubview:button];
    return button;
}

-(void)buttonClick:(UIButton *)btn {
    [[CCPushUtil sharedInstanceWithDelegate:self] setNodeIndex:btn.tag];
    NSString *str = [NSString stringWithFormat:@"设置成功：%d",(int)btn.tag];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"设置成功" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void) dropdown:(UITextField *)textField {
    [self.textFieldIsPortrait resignFirstResponder];
    [self.textFieldSize resignFirstResponder];
    [self.textFieldFrameRate resignFirstResponder];
    
    if (_showList) {//如果下拉框已显示，什么都不做
        _showList = NO;
        _tableViewIsPortrait.hidden = YES;
        _tableViewSize.hidden = YES;
        _tableViewFrameRate.hidden = YES;
        
        self.StartButton.userInteractionEnabled = YES;
        self.textFieldSize.userInteractionEnabled = YES;
        self.textFieldSize.userInteractionEnabled = YES;
        self.textFieldFrameRate.userInteractionEnabled = YES;
    } else {//如果下拉框尚未显示，则进行显示
        self.StartButton.userInteractionEnabled = YES;
        self.textFieldSize.userInteractionEnabled = YES;
        self.textFieldSize.userInteractionEnabled = YES;
        self.textFieldFrameRate.userInteractionEnabled = YES;
        
        UITableView *tableView = nil;
        if(textField.tag == 1) {
            tableView = _tableViewIsPortrait;
        } else if (textField.tag == 2) {
            tableView = _tableViewSize;
        } else if (textField.tag == 4) {
            tableView = _tableViewFrameRate;
        }
        
        [self.view bringSubviewToFront:tableView];
        [tableView reloadData];
        tableView.hidden = NO;
        _showList = YES;//显示下拉框
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播";
    self.navigationItem.leftBarButtonItem = [ColorTypeTools itemWithImageName:@"common_back" highImageName:@"" addTarget:self action:@selector(backC)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _showList = NO;
    _IsHorizontal = YES;
    _size = CGSizeMake(720, 1280);
    _frameRate = 30;
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height - 64;
    
    _arrayIsPortrait = [[NSArray alloc] initWithObjects:@"竖屏推流",@"横屏推流",nil];
    _arraySize = [[NSArray alloc] initWithObjects:@"360 * 640",@"540 * 960",@"720 * 1280",nil];
    _arrayFrameRate = [[NSArray alloc] initWithObjects:@"30帧/秒",@"25帧/秒",@"20帧/秒",nil];
    
    self.textFieldIsPortrait = [self createTextFieldWithFrame:CGRectMake(90,(_height - 64) / 6, _width - 90 - 20, 30) keyboardType:UIKeyboardTypeASCIICapable tag:1];
    self.textFieldIsPortrait.text = @"横屏推流";
    [self.textFieldIsPortrait addTarget:self action:@selector(dropdown:) forControlEvents:UIControlEventAllTouchEvents];
    
    self.textFieldSize = [self createTextFieldWithFrame:CGRectMake(90,(_height - 64) / 6 * 2, _width - 90 - 20, 30) keyboardType:UIKeyboardTypeASCIICapable tag:2];
    self.textFieldSize.text = @"720 * 1280";
    [self.textFieldSize addTarget:self action:@selector(dropdown:) forControlEvents:UIControlEventAllTouchEvents];
    
    _BitSlider = [[ASValueTrackingSlider alloc] initWithFrame:CGRectMake(90,(_height - 64) / 6 * 3, _width - 90 - 20, 30)];
    _BitSlider.minimumValue = 100.0;
    _BitSlider.maximumValue = [[CCPushUtil sharedInstanceWithDelegate:self] getMaxBitrate];
    _BitSlider.popUpViewCornerRadius = 4;
    [_BitSlider setMaxFractionDigitsDisplayed:0];
    _BitSlider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    _BitSlider.font = [UIFont fontWithName:@"GillSans-Bold" size:18];
    _BitSlider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    _BitSlider.popUpViewWidthPaddingFactor = 1.7;
    _BitSlider.delegate = self;
    _BitSlider.dataSource = self;
    _BitSlider.value = 800.0;
    _bitRate = 800.0;
    [self.view addSubview:_BitSlider];
    
    self.textFieldFrameRate = [self createTextFieldWithFrame:CGRectMake(90,(_height - 64) / 6 * 4, _width - 90 - 20, 30) keyboardType:UIKeyboardTypeASCIICapable tag:4];
    self.textFieldFrameRate.text = @"30帧/秒";
    [self.textFieldFrameRate addTarget:self action:@selector(dropdown:) forControlEvents:UIControlEventAllTouchEvents];
    
    _tableViewIsPortrait = [[UITableView alloc] initWithFrame:CGRectMake(90,(_height - 64) / 6 + 30, _width - 90 - 20, _arrayIsPortrait.count * 35)];
    _tableViewIsPortrait.delegate = self;
    _tableViewIsPortrait.tag = 1;
    _tableViewIsPortrait.dataSource = self;
    _tableViewIsPortrait.backgroundColor = [UIColor grayColor];
    _tableViewIsPortrait.separatorColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableViewIsPortrait];
    
    _tableViewSize = [[UITableView alloc] initWithFrame:CGRectMake(90,(_height - 64) / 6 * 2 + 30, _width - 90 - 20, _arraySize.count * 35)];
    _tableViewSize.delegate = self;
    _tableViewSize.tag = 2;
    _tableViewSize.dataSource = self;
    _tableViewSize.backgroundColor = [UIColor grayColor];
    _tableViewSize.separatorColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableViewSize];
    
    _tableViewFrameRate = [[UITableView alloc] initWithFrame:CGRectMake(90,(_height - 64) / 6 * 4 + 30, _width - 90 - 20, _arrayFrameRate.count * 35)];
    _tableViewFrameRate.delegate = self;
    _tableViewFrameRate.tag = 4;
    _tableViewFrameRate.dataSource = self;
    _tableViewFrameRate.backgroundColor = [UIColor grayColor];
    _tableViewFrameRate.separatorColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableViewFrameRate];
    
    _tableViewIsPortrait.hidden = YES;
    _tableViewSize.hidden = YES;
    _tableViewFrameRate.hidden = YES;
    
    [self createLabelWithText:@"横屏推：" tag:1];
    [self createLabelWithText:@"分辨率：" tag:2];
    [self createLabelWithText:@"码  率：" tag:3];
    [self createLabelWithText:@"帧  率：" tag:4];

    _StartButton=[[UIButton alloc]initWithFrame:CGRectMake(30,(_height - 64 - 30 * 6) / 7 * 6 + 30 * 5 + 64, _width - 60, 30)];
    _StartButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [_StartButton setTitle:@"开始直播"forState:UIControlStateNormal];
    [_StartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _StartButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [_StartButton setBackgroundColor:[UIColor redColor]];
    [_StartButton addTarget:self action:@selector(OnStartLiveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_StartButton setTintColor:[UIColor colorWithRed:255 green:206 blue:192 alpha:1.0f]];
    _StartButton.layer.masksToBounds = YES;
    _StartButton.layer.cornerRadius = _StartButton.frame.size.height / 2;
    [self.view addSubview:_StartButton];

}

-(void)backC{
    _LiveShowViewController = nil;
    [[CCPushUtil sharedInstanceWithDelegate:self] logout];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value{
    if (slider == _BitSlider) {
        float bit = value;
        _bitRate = bit;
    }
    return nil;
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider{
    return;
}

- (void)sliderWillHidePopUpView:(ASValueTrackingSlider *)slider{
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self judgeArray:tableView] count];
}

-(NSArray *)judgeArray:(UITableView *)tableView {
    NSArray *array = nil;
    if(tableView.tag == 1){
        array = _arrayIsPortrait;
    } else if (tableView.tag == 2) {
        array = _arraySize;
    } else if (tableView.tag == 4) {
        array = _arrayFrameRate;
    }
    return array;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = [[self judgeArray:tableView] objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.backgroundColor = [UIColor grayColor];
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableViewHide];
    NSArray *array = [self judgeArray:tableView];
    UITextField *textField = nil;
    if(tableView.tag == 1){
        textField = _textFieldIsPortrait;
        if ([indexPath row] == 0) {
            _IsHorizontal = NO;
        } else {
            _IsHorizontal = YES;
        }
    } else if (tableView.tag == 2) {
        textField = _textFieldSize;
        if ([indexPath row] == 0) {
            _size = CGSizeMake(360, 640);
        } else if([indexPath row] == 1) {
            _size = CGSizeMake(540, 960);
        } else if([indexPath row] == 2) {
            _size = CGSizeMake(720, 1280);
        }
    } else if (tableView.tag == 4) {
        textField = _textFieldFrameRate;
        if ([indexPath row] == 0) {
            _frameRate = 30;
        } else if([indexPath row] == 1) {
            _frameRate = 25;
        } else if([indexPath row] == 2) {
            _frameRate = 20;
        }
    }
    textField.text = [array objectAtIndex:[indexPath row]];
    
    _showList = NO;
    
    _tableViewIsPortrait.hidden = YES;
    _tableViewSize.hidden = YES;
    _tableViewFrameRate.hidden = YES;
}

- (void) tableViewShow {
    //NSLog(@"显示下拉菜单！");
    [self.textFieldIsPortrait resignFirstResponder];
    [self.textFieldSize resignFirstResponder];
    [self.textFieldFrameRate resignFirstResponder];
    
    self.StartButton.userInteractionEnabled = NO;
    self.textFieldSize.userInteractionEnabled = NO;
    self.textFieldSize.userInteractionEnabled = NO;
    self.textFieldFrameRate.userInteractionEnabled = NO;
}

- (void) tableViewHide {
    //NSLog(@"隐藏下拉菜单！");
    [self.textFieldIsPortrait resignFirstResponder];
    [self.textFieldSize resignFirstResponder];
    [self.textFieldFrameRate resignFirstResponder];
    
    self.StartButton.userInteractionEnabled = YES;
    self.textFieldSize.userInteractionEnabled = YES;
    self.textFieldSize.userInteractionEnabled = YES;
    self.textFieldFrameRate.userInteractionEnabled = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.textFieldIsPortrait resignFirstResponder];
    [self.textFieldSize resignFirstResponder];
    [self.textFieldFrameRate resignFirstResponder];
    
    self.StartButton.userInteractionEnabled = YES;
    self.textFieldSize.userInteractionEnabled = YES;
    self.textFieldSize.userInteractionEnabled = YES;
    self.textFieldFrameRate.userInteractionEnabled = YES;
    
    _showList = NO;
    _tableViewIsPortrait.hidden = YES;
    _tableViewSize.hidden = YES;
    _tableViewFrameRate.hidden = YES;
}

//监听touch事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.textFieldIsPortrait resignFirstResponder];
    [self.textFieldSize resignFirstResponder];
    [self.textFieldFrameRate resignFirstResponder];
    
    self.StartButton.userInteractionEnabled = YES;
    self.textFieldSize.userInteractionEnabled = YES;
    self.textFieldSize.userInteractionEnabled = YES;
    self.textFieldFrameRate.userInteractionEnabled = YES;
    
    _showList = NO;
    _tableViewIsPortrait.hidden = YES;
    _tableViewSize.hidden = YES;
    _tableViewFrameRate.hidden = YES;
}

- (UITextField *)createTextFieldWithFrame:(CGRect)rect keyboardType:(UIKeyboardType)keyboardType tag:(NSInteger) tag {
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textColor = [UIColor blackColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.clearsOnBeginEditing = NO;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = textField.frame.size.height / 2;
    textField.layer.borderColor = [[UIColor grayColor] CGColor];
    textField.layer.borderWidth = 0.6f;
    textField.delegate = self;
    textField.tag = tag;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    return textField;
}

- (void)createLabelWithText:(NSString *)text tag:(NSInteger)tag{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, (_height - 64) / 6 * tag , 60, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines = 1;
    label.highlighted = YES;
    label.userInteractionEnabled = YES;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}
/**
 *	@brief	返回节点列表，节点测速时间，以及最优点索引(从0开始，如果无最优点，随机获取节点当作最优节点)
 */
- (void) nodeListDic:(NSMutableDictionary*)dic bestNodeIndex:(NSInteger)index {
    
}

@end
