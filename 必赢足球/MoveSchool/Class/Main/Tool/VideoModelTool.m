//
//  VideoModelTool.m
//  MoveSchool
//
//  Created by edz on 2018/1/6.
//

#import "VideoModelTool.h"
#import "VideoModel.h"

#define recommendFilePath FilePathWithName(VideoModelName)

@implementation VideoModelTool

/**
 *  保存音频信息
 */
+ (void) saving : (VideoModel *) videoModel
{
    
    NSMutableArray *array = [VideoModelTool videoModels];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    [array insertObject:videoModel atIndex:0];
    [NSKeyedArchiver archiveRootObject:array toFile:recommendFilePath];
}

/**
 *  取出音频信息
 */
+ (NSMutableArray *)videoModels
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];
}

/**
 * 删除所有音频
 */
+ (void) removeVideoModel : (VideoModel *) model
{
    NSMutableArray *array = [VideoModelTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        VideoModel *newItem = nil;
        
        for (VideoModel *model in array) {
            if ([model.videoPath isEqualToString:model.videoPath]) {
                hasItem = YES;
                newItem = model;
            }
        }
        
        if (hasItem) {
            
            [array removeObject:newItem];
            
            [self saveDWDownloadItems:array];
        }
    }
    
}

/**
 *  批量保存下载信息
 */
+ (void) saveDWDownloadItems : (NSMutableArray *) items
{
    [NSKeyedArchiver archiveRootObject:items toFile:recommendFilePath];
}

+ (void) updateVideoModel : (VideoModel *) newModel
{
    NSMutableArray *array = [VideoModelTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        VideoModel *newItem = nil;
        VideoModel *oldItem = nil;
        
        for (VideoModel *model in array) {
            if ([model.videoPath isEqualToString:newModel.videoPath]) {
                hasItem = YES;
                newItem = newModel;
                oldItem = model;
            }
        }
        
        if (hasItem) {
            
            [array replaceObjectAtIndex:[array indexOfObject:oldItem] withObject:newItem];
            
            [self saveDWDownloadItems:array];
        }
    }

}

@end
