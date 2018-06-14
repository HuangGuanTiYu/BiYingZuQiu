//
//  CourseDetailController.h
//  MoveSchool
//
//  Created by edz on 2017/4/27.
//
//

#import <UIKit/UIKit.h>
@class CourseDetailArrayModel;

@interface CourseDetailController : UIViewController

//课程信息
@property(nonatomic, strong) CourseDetailArrayModel *courseDetail;

//章节列表
@property(nonatomic, strong) NSArray *captions;

@end
