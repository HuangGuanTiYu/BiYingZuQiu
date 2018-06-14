//
//  ExamineCommitController.m
//  MoveSchool
//
//  Created by edz on 2017/7/27.
//
//

#import "ExamineCommitController.h"
#import "TitleCenterButton.h"
#import "IQTextView.h"
#import "AFNetWW.h"
#import "MessageModel.h"
#import "UIImage+TBCityIconFont.h"
#import "TBCityIconFont.h"

@interface ExamineCommitController ()

@property (nonatomic, strong) TitleCenterButton *selectedButton;

//拒绝理由
@property (nonatomic, strong) NSMutableArray *noRedresons;

//通过理由
@property (nonatomic, strong) NSMutableArray *redresons;

@property (nonatomic, strong) IQTextView *textView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *resonView;

//理由数组
@property (nonatomic, strong) NSMutableArray *redresonButtins;

//分割线
@property (nonatomic, strong) UIView *sepView;

@end

@implementation ExamineCommitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"审核意见";
    
    self.noRedresons = [NSMutableArray array];
    self.redresons = [NSMutableArray array];
    self.redresonButtins = [NSMutableArray array];;

    //获取审核评语
    [self setData];
    
    [self setUpUI];
}

#pragma 获取审核评语
- (void) setData
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetDicTipList,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        if (code == 10000) {
            NSArray *rows = responseDic[@"rows"];
            if (rows.count > 0) {
                for (NSDictionary *dict in rows) {
                    if ([dict[@"type"] intValue] == 1) { //审核通过
                        [self.redresons addObject:dict[@"content"]];
                    }else
                    {
                        [self.noRedresons addObject:dict[@"content"]];
                    }
                }
            }
            
            //添加审核理由
            [self addReson : 0];
        }

        
    } fail:^(NSError *error) {

    }];
    
}

#pragma mark 添加审核理由
- (void) addReson : (int) type
{
    if (self.redresonButtins.count > 0) {
        for (UIButton *button in self.redresonButtins) {
            [button removeFromSuperview];
        }
        
        [self.redresonButtins removeAllObjects];
    }
    
    UIButton *lastButton = [[UIButton alloc] init];
    
    NSArray *buttons = type == 0 ? self.redresons : self.noRedresons;
    
    for (int i = 0; i < buttons.count; i ++) {
        UIButton *resonOne = [[UIButton alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(self.titleLabel.frame) + 5 + i * 35, self.resonView.width, 35)];
        [resonOne addTarget:self action:@selector(resonButtonClic:) forControlEvents:UIControlEventTouchUpInside];
        resonOne.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        resonOne.titleLabel.font = [UIFont systemFontOfSize:14];
        resonOne.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
        [resonOne setTitle:buttons[i] forState:UIControlStateNormal];
        [resonOne setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e625", 15, GreenColor)] forState:UIControlStateNormal];
        [resonOne setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e624", 15, GreenColor)] forState:UIControlStateSelected];
        
        [resonOne setTitleColor:RGBColor(143,143,143) forState:UIControlStateNormal];
        [resonOne setTitleColor:GreenColor forState:UIControlStateSelected];
        [self.resonView addSubview:resonOne];
        [self.redresonButtins addObject:resonOne];
        [resonOne.titleLabel sizeToFit];
        
        if (i == buttons.count - 1) {
            lastButton = resonOne;
        }
    }
    
    self.textView.y = CGRectGetMaxY(lastButton.frame) + mainSpacing * 2 + 1;
    self.sepView.y = self.textView.y - mainSpacing;
}

- (void) setUpUI
{

    self.view.backgroundColor = RGBCOLOR(240, 240, 240);

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    
    TitleCenterButton *adopt = [[TitleCenterButton alloc] init];
    [adopt setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e623", 15, GreenColor)] forState:UIControlStateSelected];

    adopt.tag = 0;
    [adopt addTarget:self action:@selector(adoptClick:) forControlEvents:UIControlEventTouchUpInside];
    adopt.backgroundColor = [UIColor whiteColor];
    adopt.frame = CGRectMake(0, 0, self.view.width, 50);
    [adopt setTitle:@"通过" forState:UIControlStateNormal];
    [adopt setTitleColor:RGBColor(143,143,143) forState:UIControlStateNormal];
    [adopt setTitleColor:GreenColor forState:UIControlStateSelected];
    adopt.titleLabel.font = [UIFont systemFontOfSize:14];
    [adopt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:adopt];
    adopt.selected = YES;
    self.selectedButton = adopt;
    
    TitleCenterButton *notAdopt = [[TitleCenterButton alloc] init];
    [notAdopt addTarget:self action:@selector(adoptClick:) forControlEvents:UIControlEventTouchUpInside];
    notAdopt.tag = 1;
    notAdopt.backgroundColor = [UIColor whiteColor];
    notAdopt.frame = CGRectMake(0, CGRectGetMaxY(adopt.frame) + 1, self.view.width, 50);
    [notAdopt setTitle:@"拒绝" forState:UIControlStateNormal];
    [notAdopt setTitleColor:RGBColor(143,143,143) forState:UIControlStateNormal];
    [notAdopt setTitleColor:GreenColor forState:UIControlStateSelected];
    notAdopt.titleLabel.font = [UIFont systemFontOfSize:14];
    [notAdopt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [notAdopt setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e623", 15, GreenColor)] forState:UIControlStateSelected];
    [self.view addSubview:notAdopt];
    
    //理由
    CGFloat resonViewY = CGRectGetMaxY(notAdopt.frame) + mainSpacing;
    UIView *resonView = [[UIView alloc] initWithFrame:CGRectMake(0, resonViewY, self.view.width, self.view.height - resonViewY)];
    self.resonView = resonView;
    resonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:resonView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(mainSpacing, 2 * mainSpacing, resonView.width - 2 * mainSpacing, 30)];
    self.titleLabel = title;
    title.text = @"拒绝理由";
    title.font = [UIFont systemFontOfSize:16];
    [title sizeToFit];
    [resonView addSubview:title];
    
    CGFloat textViewY = CGRectGetMaxY(title.frame) + mainSpacing + 1;
    self.textView = [[IQTextView alloc] initWithFrame:CGRectMake(mainSpacing, textViewY, self.view.width - 2 * mainSpacing, self.view.height - textViewY)];
    self.textView.textColor = kColorBlack64;
    self.textView.height = 200;
    self.textView.placeholder = @"请输入理由(非必填)";
    self.textView.font = [UIFont systemFontOfSize:15];
    [resonView addSubview:self.textView];
    
    //分割线
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, resonView.width, 1)];
    self.sepView = sepView;
    sepView.backgroundColor = RGBCOLOR(240, 240, 240);
    [resonView addSubview:sepView];
    
    self.textView.placeholderXZone = YES;


}

- (void) resonButtonClic : (UIButton *) button
{
    button.selected = !button.selected;
}

- (void) adoptClick : (TitleCenterButton *) button
{
    if (button.selected) {
        return;
    }
    
    button.selected = YES;
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    
    //添加审核理由
    [self addReson : (int)button.tag];
}

#pragma mark 确定
- (void) finish
{
    //拒绝没有填写理由
    BOOL hasSelected = NO;
    if (self.redresonButtins.count > 0) {
        for (UIButton *button in self.redresonButtins) {
            if (button.selected) {
                hasSelected = YES;
            }
        }
    }
    if (!hasSelected && self.textView.text.length == 0 && self.selectedButton.tag == 1) {
        [MBProgressHUD showError:@"请填写拒绝理由"];
        return;
    }
    
    NSMutableString *reason = [NSMutableString string];
    if (self.redresonButtins.count > 0) {
        for (UIButton *button in self.redresonButtins) {
            if (button.selected) {
                [reason appendString:[NSString stringWithFormat:@"%@\n",button.titleLabel.text]];
            }
        }
    }
    
    [reason appendString:[NSString stringWithFormat:@"%@\n",self.textView.text]];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,UpdateMsgRecordAuditing,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                        @"id" : self.model.msgRecordid,
                        @"isSuccess" : self.selectedButton.tag == 0 ? @1 : @0,
                        @"reason" : reason
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
            
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];

}

@end
