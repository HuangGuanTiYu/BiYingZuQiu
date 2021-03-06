//
//  AboutMineController.m
//  MoveSchool
//
//  Created by edz on 2017/9/18.
//
//

#import "AboutMineController.h"
#import "AboutMineView.h"
#import "AFNetWW.h"
#import "AboutMineModel.h"
#import "MJExtension.h"

@interface AboutMineController ()

@property (nonatomic, strong) AboutMineView *lastView;

@property (nonatomic, strong) UILabel *fitstContentLabel;

@end

@implementation AboutMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于我们";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:headerView.bounds];
    backImage.image = [UIImage imageNamed:@"my_bg"];
    [headerView addSubview:backImage];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height - 72)];
    contentView.centerY = headerView.height * 0.5;
    [headerView addSubview:contentView];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    logoView.image = [UIImage imageNamed:@"guanyu_logo"];
    logoView.centerX = contentView.width * 0.5;
    
    [contentView addSubview:logoView];
    
    UILabel *copyRight = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoView.frame) + mainSpacing, contentView.width, contentView.height - 65)];
    
    NSString *tem = [self getCurrentLocalVersion];
    
    copyRight.text = [NSString  stringWithFormat:@"%@app%@",[ManyLanguageMag  getSettingStrWith:@"网易足球"],tem];
    copyRight.textColor = [UIColor whiteColor];
    copyRight.font = [UIFont systemFontOfSize:ys_28];
    copyRight.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:copyRight];
    
    [scrollView addSubview:headerView];
    [self.view addSubview:scrollView];
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@&version=%@",NetHeader,M5About,[UserInfoTool getUserInfo].token,[self getCurrentLocalVersion]];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSString *summary = responseDic[@"data"][@"summary"];
             UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(headerView.frame) + mainSpacing, self.view.width - 30, 0)];
 
             NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:summary];
             
             NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
             
             paragraphStyle.firstLineHeadIndent = 30;
             
             [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [summary length])];
             
             summaryLabel.attributedText = attributedString;
             
             summaryLabel.numberOfLines = 0;
             summaryLabel.textColor = MainTextColor;
//             summaryLabel.text = summary;
             summaryLabel.font = [UIFont systemFontOfSize:ys_28];
             [scrollView addSubview:summaryLabel];
             [summaryLabel sizeToFit];
             summaryLabel.height = summaryLabel.height + mainSpacing;
             
             //分割
             UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(summaryLabel.frame) + mainSpacing, self.view.width, mainSpacing)];
             sepaView.backgroundColor = ViewBackColor;
             [scrollView addSubview:sepaView];
             
             NSArray *aboutMineModels = [AboutMineModel objectArrayWithKeyValuesArray:responseDic[@"data"][@"advantage"]];
             
             for (int i = 0 ; i < aboutMineModels.count; i ++) {
                 AboutMineModel *one = aboutMineModels[i];
                 
                 AboutMineView *oneView = [[AboutMineView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(sepaView.frame) + mainSpacing + 30, self.view.width - 30, 0)];
                 oneView.title = one.title;
                 oneView.contents = one.detail;
                 
                 if (self.lastView != nil) {
                     oneView.y = CGRectGetMaxY(self.lastView.frame) + mainSpacing + 30;
                 }
                 [scrollView addSubview:oneView];
                 
                 self.lastView = oneView;
                 
                 if (i == aboutMineModels.count - 1) {
                     
                     NSMutableArray *contentLabels = [NSMutableArray array];
                     
                     NSArray *contacts = responseDic[@"data"][@"contact"];
                     for (int i = 0; i < contacts.count; i ++) {
                         NSString *content = contacts[i];
                         UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i * 20 + CGRectGetMaxY(oneView.frame) + mainSpacing, 0, 20)];
                         contentLabel.numberOfLines = 0;
                         contentLabel.text = content;
                         contentLabel.textColor = MainTextColor;
                         contentLabel.font = [UIFont systemFontOfSize:ys_28];
                         [scrollView addSubview:contentLabel];
                         [contentLabel sizeToFit];
                         [contentLabels addObject:contentLabel];
                         
                         if (i == contacts.count - 1) {
                             scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(contentLabel.frame) + 64 + mainSpacing);
                             self.fitstContentLabel = contentLabel;
                             contentLabel.centerX = scrollView.width * 0.5;
                         }
                     }
                     
                     
                     for (int i = 0;  i < contentLabels.count; i ++) {
                         UILabel *contentLabel = contentLabels[i];
                         if (i != contentLabels.count - 1) {
                             contentLabel.x = self.fitstContentLabel.x;
                         }
                     }
                 }
             }
         }
         
     }fail:^(NSError *error) {
         
     }];
}

#pragma mark-获取当前app版本
- (NSString *)getCurrentLocalVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *version=[NSString stringWithFormat:@"%@",app_Version];
    return version;
}

@end
