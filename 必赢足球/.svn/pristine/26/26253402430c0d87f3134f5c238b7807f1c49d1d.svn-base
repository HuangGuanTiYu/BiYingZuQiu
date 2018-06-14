//
//  VideoCoverController.m
//  MoveSchool
//
//  Created by edz on 2018/1/3.
//

#import "VideoCoverController.h"
#import "UITextField+Extension.h"
#import "IQTextView.h"
#import "UploadListController.h"
#import "TBCityIconFont.h"
#import "IQKeyboardManager.h"
#import "VideoModelTool.h"
#import "VideoModel.h"
#import "AFNetWW.h"
#import "UploadFileModel.h"
#import "MJExtension.h"

@interface VideoCoverController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIImageView *bjImageView;

@property(nonatomic, strong) IQTextView *textView;

@property (nonatomic, strong) UITextField *phoneNumber;

@property (nonatomic, copy) NSString *imageUrl;

@end

@implementation VideoCoverController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的音频";
    
    UIImageView *bjImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 210)];
    bjImageView.image = [UIImage imageNamed:@"zhibo_bg"];
    self.bjImageView = bjImageView;
    bjImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bjImageView];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
    addButton.backgroundColor = [UIColor blackColor];
    addButton.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
    addButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [addButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e69a", 18, [UIColor whiteColor])] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"上传图片" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.centerX = self.view.width * 0.5;
    addButton.centerY = bjImageView.height * 0.5;
    [self.view addSubview:addButton];
    
    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bjImageView.frame), self.view.width, 45)];
    self.phoneNumber = phoneNumber;
    [phoneNumber setLefSpacing:10];
    phoneNumber.textColor = MainTextColor;
    phoneNumber.backgroundColor = [UIColor whiteColor];
    phoneNumber.placeholder = @"请给音频文件加个标题";
    phoneNumber.font = [UIFont systemFontOfSize:ys_28];
    [phoneNumber setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [phoneNumber setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:phoneNumber];
    
    UIView *descView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneNumber.frame) + mainSpacing, self.view.width, 145)];
    descView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:descView];

    //输入框
    self.textView = [[IQTextView alloc] initWithFrame:CGRectMake(7, 0, self.view.width - 2 * 7, descView.height)];
    self.textView.placeholder = @"详细介绍下音频课件吧";
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.placeholderXZone = YES;
    self.textView.placeHolderLabel.textColor = AuxiliaryColor;
    self.textView.textColor = MainTextColor;
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:ys_28];
    [descView addSubview:self.textView];
    
    //登录按钮
    UIButton *registLogin = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(descView.frame) + 30, self.view.width - 30, 40)];
    [registLogin addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    registLogin.layer.cornerRadius = 5;
    registLogin.layer.masksToBounds = YES;
    registLogin.backgroundColor = MainColor;
    [registLogin setTitle:@"上传" forState:UIControlStateNormal];
    [registLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registLogin.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [self.view addSubview:registLogin];

}

- (void) addButtonClick
{
    [self.view endEditing:YES];

    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从相册中选择",@"拍照",nil];
    [actionSheet showInView:self.view];
}

#pragma mark 选择上传方式
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 1) { //照相机
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 0)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    __weak typeof(self) weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    self.bjImageView.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //上传图片
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    NSString *url = [NSString stringWithFormat:@"%@/%@?token=%@",header,UploadImage,[UserInfoTool getUserInfo].token];
    
    AFHTTPRequestOperationManager *manager = [[AFNetWW sharedAFNetWorking] getAFNManager];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.bjImageView.image, 0.5) name:@"file" fileName:@"test.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *models =  [UploadFileModel objectArrayWithJSONData:responseObject];
        NSMutableArray *attachs = [NSMutableArray array];
        for (UploadFileModel *model in models) {
            [attachs addObject:model];
        }
        
        UploadFileModel *model = [attachs firstObject];
        self.imageUrl = model.url;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void) registClick
{
 
    if (self.phoneNumber.text.length == 0) {
        [MBProgressHUD showError:@"请填写标题"];
        return;
    }
    
    if (self.textView.text.length == 0) {
        [MBProgressHUD showError:@"请填写简介"];
        return;
    }
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    
    VideoModel *model = [[VideoModel alloc] init];
    model.time = timeLocal;
    model.videoPath = self.videoPath;
    model.title = self.phoneNumber.text;
    model.desc = self.textView.text;
    model.bjImage = self.bjImageView.image;
    model.videoLength = self.videoLength;
    model.imageUrl = self.imageUrl;
    [VideoModelTool saving:model];
    
    UploadListController *vc = [[UploadListController alloc] init];
    vc.datas = [VideoModelTool videoModels];
    vc.videoPath = self.videoPath;
    vc.model = model;
    vc.imageUrl = self.imageUrl;
    vc.titles = self.phoneNumber.text;
    vc.desc = self.textView.text;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

@end
