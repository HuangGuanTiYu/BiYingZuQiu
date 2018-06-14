//
//  VideoModelTool.h
//  MoveSchool
//
//  Created by edz on 2018/1/6.
//

#import <Foundation/Foundation.h>
@class VideoModel;

@interface VideoModelTool : NSObject

/**
 *  保存音频信息
 */
+ (void) saving : (VideoModel *) videoModel;

/**
 *  取出音频信息
 */
+ (NSMutableArray *)videoModels;

/**
 * 删除所有音频
 */
+ (void) removeVideoModel : (VideoModel *) model;

+ (void) updateVideoModel : (VideoModel *) newModel;

@end
