//
//  EditMessageController.m
//  MoveSchool
//
//  Created by edz on 2017/4/26.
//
//  更新信息

#import "EditMessageController.h"
#import "UIImageView+WebCache.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "CountDownButton.h"
#import "UIButton+Extension.h"

@interface EditMessageController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *qqTextField;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *manButton;

@property (weak, nonatomic) IBOutlet UIButton *womanButton;

@property (weak, nonatomic) IBOutlet UIButton *noSexButton;

@property (weak, nonatomic) UIButton *sexButton;

@property (weak, nonatomic) IBOutlet UIView *codeView;

@property (weak, nonatomic) CountDownButton *button;

@property (assign, nonatomic) BOOL changeHeaderImage;

@end

@implementation EditMessageController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"更改信息";
    
    [self setUpUI];
    
    [self setUpData];
}

- (void) setUpUI
{
    self.headImgView.userInteractionEnabled = YES;
    self.headImgView.layer.cornerRadius = self.headImgView.width * 0.5;
    self.headImgView.layer.masksToBounds = YES;
    [self.headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImgViewClick)]];

    self.nameTextField.tintColor = [UIColor blueColor];
    self.qqTextField.tintColor = [UIColor blueColor];
    self.mobileTextFiel.tintColor = [UIColor blueColor];
    self.codeTextField.tintColor = [UIColor blueColor];
    
    [self.mobileTextFiel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    leftView.backgroundColor = [UIColor whiteColor];

    self.mobileTextFiel.borderStyle = self.nameTextField.borderStyle = self.qqTextField.borderStyle = self.codeTextField.borderStyle = UITextBorderStyleNone;
    self.mobileTextFiel.layer.borderColor = self.nameTextField.layer.borderColor = self.qqTextField.layer.borderColor = self.codeTextField.layer.borderColor = RGBCOLOR(155, 155, 155).CGColor;
    self.mobileTextFiel.layer.borderWidth = self.nameTextField.layer.borderWidth = self.qqTextField.layer.borderWidth = self.codeTextField.layer.borderWidth = 0.5;
    
    self.mobileTextFiel.leftView = leftView;
    self.mobileTextFiel.backgroundColor = self.nameTextField.backgroundColor = self.qqTextField.backgroundColor = [UIColor whiteColor];

    self.mobileTextFiel.leftViewMode = self.nameTextField.leftViewMode = self.qqTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishClick)];
    
    self.codeView.hidden = YES;

    CountDownButton *button = [[CountDownButton alloc] initWithFrame:CGRectMake(self.view.width - 100, self.codeView.y - 10, 100, self.codeView.height)];
    self.button = button;
    [button addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:GreenColor forState:UIControlStateNormal];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    self.button.hidden = YES;

}

- (void) setUpData
{
    
    if ([UserInfoTool getUserInfo].headimgurl != nil) {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[UserInfoTool getUserInfo].headimgurl] placeholderImage:[UIImage imageNamed:@"headerNormal"]];
    }
    
    if ([UserInfoTool getUserInfo].nickname != nil) {
        self.nameTextField.text = [UserInfoTool getUserInfo].nickname;
    }
    
    if ([UserInfoTool getUserInfo].qq != nil) {
        self.qqTextField.text = [UserInfoTool getUserInfo].qq;
    }
    
    if ([UserInfoTool getUserInfo].mobile != nil) {
        self.mobileTextFiel.text = [UserInfoTool getUserInfo].mobile;
    }
    
    if ([UserInfoTool getUserInfo].sex != nil && [UserInfoTool getUserInfo].sex.length > 0) {
        if ([[UserInfoTool getUserInfo].sex isEqualToString:@"1"]) {
            self.sexButton = self.manButton;
            self.manButton.selected = YES;
        }else if([[UserInfoTool getUserInfo].sex isEqualToString:@"2"])
        {
            self.sexButton = self.womanButton;
            self.womanButton.selected = YES;
        }else if([[UserInfoTool getUserInfo].sex isEqualToString:@"4"])
        {
            self.sexButton = self.noSexButton;
            self.noSexButton.selected = YES;
        }
    }
}

- (IBAction)sexClick:(UIButton *)sender {
    self.sexButton.selected = NO;
    sender.selected = YES;
    self.sexButton = sender;
}

+ (instancetype)editMessageController
{
    return [[UIStoryboard storyboardWithName:@"MyCenter" bundle:nil] instantiateInitialViewController];
}

#pragma mark 完成点击
- (void) finishClick
{
    
    if (self.mobileTextFiel.text.length > 0 && self.mobileTextFiel.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    
    if (self.nameTextField.text.length < 2 || self.nameTextField.text.length > 32) {
        [MBProgressHUD showError:@"昵称长度:2-32位"];
    }
    
    [MBProgressHUD showMessage:@"发布中,请稍后..."];

    if (self.changeHeaderImage) {
        [self sendPhoto];
    }else
    {
        [self sendData];
    }
}

- (void) sendData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"nickname"] = self.nameTextField.text;
    
    int sex = 0;
    if (self.manButton.selected) {
        sex = 1;
    }else if (self.womanButton.selected) {
        sex = 2;
    }else if (self.noSexButton.selected) {
        sex = 3;
    }
    
    dict[@"sex"] = @(sex);
    
    if (self.qqTextField.text.length > 0) {
        dict[@"qq"] = self.qqTextField.text;
    }else
    {
        dict[@"qq"] = @"";
    }
    
    dict[@"mobile"] = self.mobileTextFiel.text;
    
    if (self.codeTextField.text.length > 0) {
        dict[@"activecode"] = self.codeTextField.text;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,FixUserInfo,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dict success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [MBProgressHUD showSuccess:@"修改成功"];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

#pragma mark 发送带有图片的
- (void) sendPhoto
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,Alterheadpic,[UserInfoTool getUserInfo].token];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"ext"] = @"jpg";
    dict[@"data"] = [UIImageJPEGRepresentation(self.headImgView.image, 1.0) base64EncodedStringWithOptions:0];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dict success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [self sendData];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
            
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
    
}

#pragma mark textField文字发生变化
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }
    
    if (textField.text.length == 11) {
        self.codeView.hidden = NO;
        self.button.hidden = NO;
    }else
    {
        self.codeView.hidden = YES;
        self.button.hidden = YES;
    }
}

- (IBAction)codeButtonClick:(CountDownButton *)button {
    [self sendActiveCode:self.mobileTextFiel.text];
    [button startTime : 140];
}

- (void) sendActiveCode : (NSString *) data
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_REG_ACTIVE_CODE];
    
    NSDictionary *dic=@{
                        @"mobile": data,
                        @"scene" : @1
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"发送成功"];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
            
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

#pragma mark 头像点击
- (void) headImgViewClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 0) { //照相机
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 1)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.changeHeaderImage = YES;
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    self.headImgView.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
