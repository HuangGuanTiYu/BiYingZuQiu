//
//  MyTeacherController.m
//  MoveSchool
//
//  Created by edz on 2017/5/4.
//
//

#import "MyTeacherController.h"
#import "ApplyTeacherController.h"

@interface MyTeacherController ()

@property(nonatomic, strong) UIView *blankView;

@end

@implementation MyTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [ManyLanguageMag getMineMenuStrWith:@"我是讲师"];

}

- (instancetype)initWithState : (int) state
{
    self = [super init];
    if (self) {
        switch (state) {
            case 0: //不是讲师
                [self createBlankView];
                break;
            case 2: //审核中
                [self createApprovalView:[ManyLanguageMag getMineStrWith:@"你的申请，正在审批中"]];
                break;
            case 3: //禁用
                [self createApprovalView:[ManyLanguageMag getMineStrWith:@"你被禁用讲师"]];
                break;
            case 4: //未通过
                [self createApprovalView:[ManyLanguageMag getMineStrWith:@"很遗憾，没有通过"]];
                break;
            default:
                break;
        }
    }
    return self;
}

-(void)createBlankView
{
    self.blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.blankView.backgroundColor=RGBColor(240, 240, 240);
    
    [self.view addSubview:self.blankView];
    
    CGFloat blanckH = 62;
    CGFloat blanckW = 59;
    UIImageView * blankView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-(blanckW))/2, self.view.height/4, blanckW, blanckH)];
    blankView.image = [UIImage imageNamed:@"to_be_teacher"];
    [self.blankView addSubview:blankView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(blankView.frame)+35, self.view.width, 30)];
    label.text=[ManyLanguageMag getMineStrWith:@"您目前还不是讲师,立即" ];
    label.textColor=RGBColor(190, 190, 190);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [self.blankView addSubview:label];

    CGFloat Width=(double)0.33*SCREEN_WIDTH;
    UIButton * blankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blankButton.frame = CGRectMake((self.view.width-Width)/2, CGRectGetMaxY(label.frame)+20, Width, Width/3);
    blankButton.backgroundColor = [UIColor whiteColor];
    blankButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [blankButton setTitle:[ManyLanguageMag getMineStrWith:@"申请成为讲师"] forState:UIControlStateNormal];
    [blankButton setTitleColor:GreenColor forState:UIControlStateNormal];
    blankButton.titleLabel.font = [UIFont systemFontOfSize:15];
    blankButton.layer.cornerRadius = 1;
    blankButton.layer.masksToBounds = YES;
    blankButton.layer.borderColor = GreenColor.CGColor;
    blankButton.layer.borderWidth = 0.5;
    [blankButton addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    [self.blankView addSubview:blankButton];
}

-(void)createApprovalView:(NSString *)str

{
    _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _blankView.backgroundColor = RGBColor(240, 240, 240);
    [self.view addSubview:_blankView];
    
    CGFloat blanckH = 62;
    CGFloat blanckW = 59;
    UIImageView * blankView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-(blanckW))/2, self.view.height/4, blanckW, blanckH)];
    blankView.image = [UIImage imageNamed:@"to_be_teacher"];
    [_blankView addSubview:blankView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(blankView.frame)+35, self.view.width, 30)];
    label.text=str;
    label.textColor=RGBColor(190, 190, 190);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [_blankView addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark 申请成为讲师
- (void) Click
{
    ApplyTeacherController *vc = [[ApplyTeacherController alloc]init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
