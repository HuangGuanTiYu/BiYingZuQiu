//
//  DWDownloadItemTool.m
//  MoveSchool
//
//  Created by edz on 2017/6/5.
//
//

#import "DWDownloadItemTool.h"
#import "DWDownloadItem.h"

#define recommendFilePath FilePathWithName(DWDownloadItemFileName)

@implementation DWDownloadItemTool

/**
 *  保存单个下载信息
 */
+ (void) saveDWDownloadItem : (DWDownloadItem *) item
{
    NSMutableArray *array = [self getDWDownloadItem];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    [array insertObject:item atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:array toFile:recommendFilePath];
}

/**
 *  批量保存下载信息
 */
+ (void) saveDWDownloadItems : (NSMutableArray *) items
{
    [NSKeyedArchiver archiveRootObject:items toFile:recommendFilePath];
}

/**
 *  取出下载信息
 */
+ (NSMutableArray *) getDWDownloadItem
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];
}

/**
 *  删除下载信息
 */
+ (void) deleteDWDownloadItem : (DWDownloadItem *) item
{
    NSMutableArray *itemArray = [self getDWDownloadItem];
    
    if (itemArray.count > 0) {
        BOOL hasItem = NO;
        DWDownloadItem *newItem = nil;
        
        for (DWDownloadItem *loderItem in itemArray) {
            
            if ([loderItem.videoPath isEqualToString:item.videoPath] || [loderItem.pdfUrl isEqualToString:item.pdfUrl]) {
                hasItem = YES;
                newItem = loderItem;
            }
        }
        
        if (hasItem) {
            
            [itemArray removeObject:newItem];
            
            [self saveDWDownloadItems:itemArray];
        }
    }
}

@end
