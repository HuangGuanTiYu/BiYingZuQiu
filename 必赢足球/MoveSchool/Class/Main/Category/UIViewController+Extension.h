//
//  UIViewController+Extension.h
//  MoveSchool
//
//  Created by edz on 2017/8/12.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/**
 * 跳转到 课程详情界面
 * CourseId 课程ID
 */
- (void) jumpToTypeContoller : (UIViewController *) controller CourseId : (NSString *) CourseId;

@end
