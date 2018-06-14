//
//  H5ExamineController.m
//  MoveSchool
//
//  Created by edz on 2017/7/10.
//
//

#import "H5ExamineController.h"
#import "H5CourseModel.h"
#import "MineOrderLableModel.h"
#import "IQTextView.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"

@interface H5ExamineController ()

@property (nonatomic, strong) UIView *commentView;

@property (nonatomic, strong) UITextField *textView;

//标签名称数组
@property (nonatomic, strong) NSMutableArray *models;

//标签按钮数组
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) UIView *tagView;

@property (nonatomic, strong) UIView *alertVeiw;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation H5ExamineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.h5CourseModel.title;
    
    [self setUpUI];
    
    //注册 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiddenFrame:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) setUpUI
{
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 120 - mainSpacing, mainSpacing, 120, 30)];
    [addButton setTitleColor:GreenColor forState:UIControlStateNormal];
    [addButton setTitle:@"自定义添加标签" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    //标签View
    UIView *tagView = [[UIView alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(addButton.frame) + mainSpacing, self.view.width - 2 * mainSpacing, 200)];
    tagView.backgroundColor = DivisionDivColor;
    [self.view addSubview:tagView];
    self.tagView = tagView;
    
    NSMutableArray *models = (NSMutableArray *)[self.h5CourseModel.labels componentsSeparatedByString:@" "];
    if (models != nil && models.count > 0) {
        self.models = [[NSMutableArray alloc] initWithArray:models];
    }else
    {
        self.models = [NSMutableArray array];
    }
    
    self.buttons = [NSMutableArray array];
    
    CGFloat buttonW = (tagView.width - 4 * mainSpacing) / 3;
    
    for (int i = 0; i < models.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(mainSpacing + (i % 3) * (buttonW + mainSpacing), mainSpacing + (i / 3) * (30 + mainSpacing), buttonW, 30)];
        button.selected = YES;
        button.layer.borderColor = GreenColor.CGColor;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:models[i] forState:UIControlStateNormal];
        [button setTitleColor:RGBColor(143,143,143) forState:UIControlStateNormal];
        [button setTitleColor:GreenColor forState:UIControlStateSelected];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        [tagView addSubview:button];
        
        [self.buttons addObject:button];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(tagView.frame) + mainSpacing, tagView.width, 30)];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 30)];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
    leftImage.image = [UIImage imageNamed:@"prompt"];
    leftImage.centerY = leftView.height * 0.5;
    
    [leftView addSubview:leftImage];
    
    titleTextField.leftView = leftView;
    titleTextField.leftViewMode = UITextFieldViewModeAlways;
    titleTextField.textColor = RGBColor(143,143,143);
    titleTextField.font = [UIFont systemFontOfSize:15];
    titleTextField.text = @"提示：点击按钮可添加或取消标签";
    [self.view addSubview:titleTextField];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(2 * mainSpacing, CGRectGetMaxY(titleTextField.frame) + 4 * mainSpacing, self.view.width - 4 * mainSpacing, 50)];
    submit.titleLabel.textAlignment = NSTextAlignmentCenter;
    [submit addTarget:self action:@selector(finishCick) forControlEvents:UIControlEventTouchUpInside];
    [submit setTitle:@"提交审核" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont systemFontOfSize:17];
    submit.backgroundColor = GreenColor ;
    submit.layer.cornerRadius = 5;
    submit.layer.masksToBounds = YES;
    [self.view addSubview:submit];
}

#pragma mark 标签按钮点击
- (void) buttonClick : (UIButton *) button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        button.layer.borderColor = GreenColor.CGColor;
    }else
    {
        button.layer.borderColor = RGBColor(143,143,143).CGColor;
    }
}

#pragma mark 标签按钮点击
- (void) btnClick : (UIButton *) button
{
    button.selected = !button.selected;
    if (button.selected) {
        button.layer.borderColor = GreenColor.CGColor;
    }else
    {
        button.layer.borderColor = [[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] CGColor];

    }
}

#pragma mark 自定义添加标签
- (void) addButtonClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *commentView = [[UIView alloc] initWithFrame:window.bounds];
    self.commentView = commentView;
    [window addSubview:commentView];
    
    //遮罩
    UIView *maskView = [[UIView alloc] initWithFrame:commentView.bounds];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    [commentView addSubview:maskView];
    
    UIView *alertVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.9, 140)];
    self.alertVeiw = alertVeiw;
    alertVeiw.centerX = maskView.width * 0.5;
    alertVeiw.centerY = maskView.height * 0.5;
    alertVeiw.layer.cornerRadius = 5;
    alertVeiw.layer.masksToBounds = YES;
    alertVeiw.backgroundColor = [UIColor whiteColor];
    [commentView addSubview:alertVeiw];
    
    //输入框
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(mainSpacing, 30, alertVeiw.width - 2 * mainSpacing, 40)];
    self.textView = textView;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainSpacing, textView.height)];
    [textView addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];

    textView.leftView = leftView;
    textView.leftViewMode = UITextFieldViewModeAlways;
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.backgroundColor = DivisionDivColor;
    textView.font = [UIFont systemFontOfSize:16];
    
    textView.placeholder = @"自定义添加标签";

    [alertVeiw addSubview:textView];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame) + 20, alertVeiw.width, 0.5)];
    sepaView.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, sepaView.y, 0.5, alertVeiw.height)];
    sepaView2.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView2];
    
    //按钮
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), alertVeiw.width * 0.5, 50)];
    [cancleButton addTarget:self action:@selector(commentViewClick) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertVeiw addSubview:cancleButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, cancleButton.y, cancleButton.width, cancleButton.height)];
    
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];

    [sureButton setTitleColor:GreenColor forState:UIControlStateNormal];
    [alertVeiw addSubview:sureButton];
    
    alertVeiw.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        alertVeiw.transform = CGAffineTransformIdentity;
    }];

}

#pragma mark 取消按钮点击
- (void) commentViewClick
{
    if (self.commentView != nil && self.commentView.superview != nil) {
        [self.commentView removeAllSubviews];
        [self.commentView removeFromSuperview];
    }
}

#pragma mark 确认按钮点击
- (void) sureButtonClick
{
    if (self.textView.text.length > 0) {
        
        CGFloat buttonW = (self.view.width - 2 * mainSpacing - 4 * mainSpacing) / 3;

        
        NSInteger i = self.models.count;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(mainSpacing + (i % 3) * (buttonW + mainSpacing), mainSpacing + (i / 3) * (30 + mainSpacing), buttonW, 30)];
        button.selected = YES;
        button.layer.borderColor = GreenColor.CGColor;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:self.textView.text forState:UIControlStateNormal];
        [button setTitleColor:RGBColor(143,143,143) forState:UIControlStateNormal];
        [button setTitleColor:GreenColor forState:UIControlStateSelected];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        
        [self.tagView addSubview:button];
        [self.models addObject:self.textView.text];
        [self.buttons addObject:button];

        [self commentViewClick];
    }
}

- (void)textFieldChange:(UITextField *)textField
{
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
}

#pragma mark 完成点击
- (void) finishCick
{

    NSMutableString *string = [NSMutableString string];
    
    //选中的按钮
    NSMutableArray *selectedButton = [NSMutableArray array];
    if (self.buttons.count > 0) {
        for (UIButton *button in self.buttons) {
            if (button.selected) {
                [string appendFormat:@"%@ ", [NSString stringWithFormat:@"%@ ",button.titleLabel.text]];
                [selectedButton addObject:button];
            }
        }
    }
    
    if (selectedButton.count == 0) {
        [MBProgressHUD showText:@"请至少添加一个标签" inview:self.view];
        return;
    }
    
    if (selectedButton.count > 5) {
        [MBProgressHUD showText:@"最多添加5个标签" inview:self.view];
        return;
    }
    
    string = (NSMutableString *)[string substringToIndex:string.length - 1];
    
    NSDictionary *dic = @{
                          @"id" : self.h5CourseModel.ID,
                          @"labels" : string
                          };
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,PublishH5Course];
    
    [MBProgressHUD showMessage:@"正在提交，请稍后" toView:[UIApplication sharedApplication].keyWindow];

    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        NSNumber * code = responseDic[@"rescode"];
        
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

        if (code.integerValue == 10000)
        {
            [MBProgressHUD showSuccess:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}


- (void)keyBoardWillShowFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.3;
}

- (void) keyBoardWillHiddenFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.5;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
