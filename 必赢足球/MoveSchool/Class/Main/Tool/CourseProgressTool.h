//
//  CourseProgressTool.h
//  MoveSchool
//
//  Created by edz on 2017/10/12.
//
//

#import <Foundation/Foundation.h>
@class CourseProgresModel;

@interface CourseProgressTool : NSObject

/**
 *  保存菜单信息
 */
+ (void)saving:(CourseProgresModel *)progress;

/**
 *  取出菜单信息
 */
+ (NSMutableArray *)progress;

/**
 *  删除菜单信息
 */
+ (void) deleteProgress : (CourseProgresModel *) model;

@end
