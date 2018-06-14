//
//  CourseProgressTool.m
//  MoveSchool
//
//  Created by edz on 2017/10/12.
//
//

#import "CourseProgressTool.h"
#import "CourseProgresModel.h"

#define recommendFilePath FilePathWithName(CourseProgress)


@implementation CourseProgressTool

/**
 *  保存菜单信息
 */
+ (void)saving:(CourseProgresModel *)progress
{
    NSMutableArray *progressArray = [self progress];
    if (progressArray == nil) {
        progressArray = [NSMutableArray array];
    }
    
    [progressArray addObject:progress];
    
    [NSKeyedArchiver archiveRootObject:progressArray toFile:recommendFilePath];
    
}

/**
 *  取出菜单信息
 */
+ (NSMutableArray *)progress
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];
}

/**
 *  删除菜单信息
 */
+ (void) deleteProgress : (CourseProgresModel *) model
{
    NSMutableArray *progressArray = [self progress];
    
    if (progressArray.count > 0) {
        for (CourseProgresModel *models in progressArray) {
            
            if ([models.courseid isEqualToString:model.courseid]) {
                [progressArray removeObject:models];
            }
        }
    }
    
    [NSKeyedArchiver archiveRootObject:progressArray toFile:recommendFilePath];
}


@end
