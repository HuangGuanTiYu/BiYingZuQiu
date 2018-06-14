//
//  MineStudyCourseViewController.h
//  Main
//
//  Created by yuhongtao on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

typedef enum
{
    CourseSourceStudy, //来自我的学习
    CourseSourceCollection, //来自我的收藏
    CourseSourceCause, //来自我的事业部
    CourseSourceCourseStudy, //来自课程-学习
    
} CourseSourceType;

@protocol MineStudyCourseViewControllerDelegate <NSObject>

//刷新标题课程数量
- (void) reloadButtonBarView;

@end

@interface MineStudyCourseViewController : UIViewController<XLPagerTabStripChildItem>

//标签名字
@property (nonatomic,copy) NSString *pageTitle;

@property (nonatomic,weak) id<MineStudyCourseViewControllerDelegate> delegate;

@property(nonatomic, assign) int CourseSourceType;

@property(nonatomic,copy)NSString *instname;

@property(nonatomic,copy)NSString *courseName;

@property (nonatomic, copy) NSString *zttid;

@end
