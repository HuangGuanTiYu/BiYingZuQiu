//
//  StudyFrameTool.h
//  MoveSchool
//
//  Created by edz on 2017/5/25.
//
//

#import <Foundation/Foundation.h>
@class StudyCircleModel;

@interface StudyFrameTool : NSObject

/**
 *  保存朋友圈信息
 */
+ (void) saveStudy : (NSMutableArray *) studyCircleArray;

/**
 *  取出朋友圈信息
 */
+ (NSMutableArray *) getStudyCircleArray;

/**
 *  删除全部朋友圈信息
 */
+ (void) delegateStudyCircleArray;

/**
 *  删除单个朋友圈信息
 */
+ (void) delegateStudyCircle : (StudyCircleModel *) studyCircleModel;

@end
