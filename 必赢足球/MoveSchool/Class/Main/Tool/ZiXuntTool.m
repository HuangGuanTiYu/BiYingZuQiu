//
//  ZiXuntTool.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/21.
//

#import "ZiXuntTool.h"
#import "HomePageModel.h"

#define FilePathWithName(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]

#define recommendFilePath FilePathWithName(@"ZiXunInfoFileName")

@implementation ZiXuntTool

/**
 *  保存音频信息
 */
+ (void) saving : (HomePageModel *) videoModel
{
    
    NSMutableArray *array = [ZiXuntTool videoModels];
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
+ (void) removeVideoModel : (HomePageModel *) model
{
    NSMutableArray *array = [ZiXuntTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        HomePageModel *newItem = nil;
        
        for (HomePageModel *m in array) {
            if ([m.title isEqualToString:model.title]) {
                hasItem = YES;
                newItem = m;
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

+ (void) updateVideoModel : (HomePageModel *) newModel
{
    NSMutableArray *array = [ZiXuntTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        HomePageModel *newItem = nil;
        HomePageModel *oldItem = nil;
        
        for (HomePageModel *model in array) {
            if ([model.title isEqualToString:newModel.title]) {
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
