//
//  StudyFrameTool.m
//  MoveSchool
//
//  Created by edz on 2017/5/25.
//
//

#import "StudyFrameTool.h"
#import "StudyCircleFrame.h"
#import "StudyCircleModel.h"

#define recommendFilePath FilePathWithName(StudyFrameFileName)


@implementation StudyFrameTool

/**
 *  保存朋友圈信息
 */
+ (void) saveStudy : (NSMutableArray *) studyCircleArray
{
    if ([self getStudyCircleArray].count > 0) {
        [self delegateStudyCircleArray];
    }
    
    [NSKeyedArchiver archiveRootObject:studyCircleArray toFile:recommendFilePath];
}

/**
 *  取出朋友圈信息
 */
+ (NSMutableArray *) getStudyCircleArray
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];
}

/**
 *  删除全部朋友圈信息
 */
+ (void) delegateStudyCircleArray
{
    NSArray *frameArray = [self getStudyCircleArray];
    frameArray = nil;
}

/**
 *  删除单个朋友圈信息
 */
+ (void) delegateStudyCircle : (StudyCircleModel *) studyCircleModel;
{
    NSMutableArray *array = (NSMutableArray *)[self getStudyCircleArray];
    if (array.count > 0) {
        StudyCircleModel *deleteModel = [[StudyCircleModel alloc] init];
        for (StudyCircleModel *model in array) {
            if (model.ID != nil && studyCircleModel.ID != nil && [model.ID isEqualToString:studyCircleModel.ID]) {
                deleteModel = model;
            }
        }
        
        [array removeObject:deleteModel];
    }
    
    [self saveStudy:array];
}

@end
