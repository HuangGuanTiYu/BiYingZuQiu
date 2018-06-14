//
//  CalendarViewController.h
//  自定义calandar
//
//  Created by yuhongtao on 16/6/23.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@class FSCalendar;
@protocol CalendarViewControllerDelegate <NSObject>

-(void)passAmodelArr:(NSArray *)arr;

-(void)passClickDateWith:(NSDate *)date;
@end
@interface CalendarViewController : UIViewController<FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) UIButton *previousButton;
@property (weak, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) NSDictionary *images;

- (void)previousClicked:(id)sender;
- (void)nextClicked:(id)sender;


@property (nonatomic,weak)id<CalendarViewControllerDelegate>delegate;
@property (strong, nonatomic) NSDictionary *fillSelectionColors;
@property (strong, nonatomic) NSDictionary *fillDefaultColors;//填充色默认

@end
