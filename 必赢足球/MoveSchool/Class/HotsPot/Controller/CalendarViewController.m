//
//  CalendarViewController.m
//  自定义calandar
//
//  Created by yuhongtao on 16/6/23.
//  Copyright © 2016年 com.ztt. All rights reserved.
//  时间选择器

#import "CalendarViewController.h"
#import "MJExtension.h"
#import "HotPointModel.h"
#import "AFNetWW.h"
#import "UserInfo.h"
#import "MJExtension.h"

#define kViolet [UIColor colorWithRed:170/255.0 green:114/255.0 blue:219/255.0 alpha:1.0]

@interface CalendarViewController ()
@property(nonatomic,strong)NSArray *dateArr; //获取本月有信息的日期
@property(nonatomic,strong)NSMutableArray *modelArr;//保存本月所有的数据模型
@property(nonatomic,strong)NSDate *currentPageDate;//保存本月所有的数据模型

@end

@implementation CalendarViewController
#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"FSCalendar";
        
        self.modelArr = [NSMutableArray array];
        
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth ;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        
        NSInteger year = [dateComponent year];
        NSInteger month = [dateComponent month];
        [self netWorkingWithYear:year andMonth:month];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    _calendar.appearance.titlePlaceholderColor =[UIColor  lightGrayColor];
    _calendar.appearance.selectionColor =[UIColor  whiteColor];
    _calendar.appearance.titleSelectionColor=[UIColor  blackColor];
    _calendar.appearance.titleTodayColor = GreenColor;
    
}
-(void)netWorkingWithYear:(NSInteger)year andMonth:(NSInteger)month{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&year=%ld&month=%ld",NetHeader,CalendarDate,[UserInfoTool getUserInfo].token,(long)year,(long)month];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSArray *rows=responseDic[@"rows"];
        NSArray *model=[HotPointModel objectArrayWithKeyValuesArray:rows];
        NSMutableArray *tempArr=[NSMutableArray array];
        for (int i=0; i<model.count; i++) {
            HotPointModel *temp=model[i];
            [self.modelArr addObject:temp];
            
            //改变日期格式
            NSRange range1 = NSMakeRange(0, 4);//NSMakeRange这个函数的作用是从第0位开始计算，长度为4
            NSRange range2 = NSMakeRange(5, 2);//NSMakeRange这个函数的作用是从第0位开始计算，长度为4
            NSRange range3 = NSMakeRange(8, 2);//NSMakeRange这个函数的作用是从第0位开始计算，长度为4
            NSString *year=[temp.indate substringWithRange:range1];
            NSString *month=[temp.indate substringWithRange:range2];
            NSString *day=[temp.indate substringWithRange:range3];
            NSString *tempstr=[NSString stringWithFormat:@"%@/%@/%@",year,month,day];
            [tempArr addObject:tempstr];
        }
        //排序取得时间
        NSSet *dataSet=[NSSet setWithArray:tempArr];
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sd, nil];
        self.dateArr = [dataSet sortedArrayUsingDescriptors:sortDescriptors];
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        for (int i=0; i<self.dateArr.count; i++) {
            [dic setObject:GreenColor   forKey:self.dateArr[i]];
        }
        //   清除当前日期颜色
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY/MM/dd"];
        NSString* date = [formatter stringFromDate:[NSDate new]];
        [dic setObject:[UIColor clearColor] forKey:date];
        self.fillDefaultColors=dic;
        
        [_calendar  reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
    
}



- (void)dealloc
{
    
}

#pragma mark   前一月后一月按钮
- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.calendar dateBySubstractingMonths:1 fromDate:currentMonth];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:previousMonth];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    [self netWorkingWithYear:year andMonth:month];
    
    [self.calendar setCurrentPage:previousMonth animated:YES];
}
- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.calendar dateByAddingMonths:1 toDate:currentMonth];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nextMonth];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    [self netWorkingWithYear:year andMonth:month];
    
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

#pragma mark - <FSCalendarDelegate>
//选中前执行
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    return YES;
}

//月份改变执行的方法／／即使滑动后执行
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSString *year=[calendar stringFromDate:calendar.currentPage format:@"YYYY"];
    NSString *month=[calendar stringFromDate:calendar.currentPage format:@"MM"];
    
    NSRange range1 = NSMakeRange(0, 1);
    NSString *temp=[month  substringWithRange:range1];
    NSRange range2 = NSMakeRange(1, 1);
    if ([temp isEqualToString:@"0"]) {
        month=[month  substringWithRange:range2];
    }
    
    [self  netWorkingWithYear:year.integerValue andMonth:month.integerValue];
    [_calendar reloadData];
}

//设置calender的frame。
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [_calendar stringFromDate:date format:@"yyyy/MM/dd"];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    return nil;
}


-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma 选中后执行  点击事件
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    
    NSString *date1=[calendar stringFromDate:date format:@"YYYY/MM/dd"];
    if ([self.dateArr  containsObject:date1]) {
        NSString *date2=[calendar stringFromDate:date format:@"YYYY-MM-dd"];
        //    取得点到日期的全部模型
        NSMutableArray *temArr=[NSMutableArray array];
        for (int i=0 ;i<self.modelArr.count; i++) {
            HotPointModel *model=self.modelArr[i];
            if ([model.indate isEqualToString:date2]) {
                [temArr addObject:model];
            }
        }
        [self.delegate passAmodelArr:temArr];
        [self.delegate passClickDateWith:date];
        [self  dismissViewControllerAnimated:0 completion:nil];
    }else{
        [MBProgressHUD showText:@"当前日期不存在内容" inview:self.view];
    }
}
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(30, 100, view.frame.size.width-60, height)];
    
    calendar.layer.masksToBounds=YES;
    calendar.layer.cornerRadius=10;
    calendar.dataSource = self;
    calendar.delegate = self;
    //    calendar.allowsMultipleSelection = YES;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    //    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    [self.view addSubview:calendar];
    //    [calendar selectDate:[calendar currentPage]];
    self.calendar = calendar;
    calendar.appearance.headerTitleColor = kColorBlack;    //标题颜色
    calendar.appearance.headerDateFormat=@"YYYY MMMM";
    calendar.appearance.titleTodayColor = GreenColor;    //今天的颜色
    calendar.appearance.titlePlaceholderColor=kColorGray154; //一个界面不在月份的天
    calendar.appearance.titleSelectionColor=[UIColor whiteColor]; //选中的颜色
    calendar.appearance.titleDefaultColor=[UIColor blackColor];//月份正常天数颜色
    calendar.appearance.weekdayTextColor = kColorGray100;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    
    //完美的button设置
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(10, 10, 30, 30);
    previousButton.backgroundColor = [UIColor whiteColor];
    [previousButton setTitleColor:self.calendar.appearance.headerTitleColor forState:UIControlStateNormal];
    [previousButton setImage:[UIImage imageNamed:@"hot_calander_narrow_left"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [calendar addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(calendar.frame)-30-10, 10, 30, 30);
    nextButton.backgroundColor = [UIColor whiteColor];
    [nextButton setTitleColor:self.calendar.appearance.headerTitleColor forState:UIControlStateNormal];
    [nextButton setImage:[UIImage imageNamed:@"hot_calander_narrow_right"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [calendar addSubview:nextButton];
    self.nextButton = nextButton;
    
    self.view.backgroundColor=[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
    [self viewset];
}

-(void)viewset{
    
    self.view.backgroundColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
    //设置自己的image 给日期
    CGFloat X = (self.view.frame.size.width-50)/2;
    CGFloat Y = 500;
    UIButton * timeLable=[[UIButton alloc]initWithFrame:CGRectMake(X,Y,45,40)];
    
    if(IS_IPHONE_4_OR_LESS){
        
        timeLable.y = self.view.height-50;
        
    }
    
    [timeLable setImage:[UIImage imageNamed:@"hot_calander_narrow_close"] forState:UIControlStateNormal];
    [timeLable addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeLable];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
