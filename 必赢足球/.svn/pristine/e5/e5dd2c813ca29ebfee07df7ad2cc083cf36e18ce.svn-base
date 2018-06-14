//
//  SearchModelTool.m
//  MoveSchool
//
//  Created by edz on 2017/9/20.
//
//

#import "SearchModelTool.h"

#define recommendFilePath FilePathWithName(SearchesFileName)


@implementation SearchModelTool

/**
 *  保存菜单信息
 */
+ (void) saving : (NSString *) searchString
{
    NSMutableArray *array = [SearchModelTool searches];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    [array insertObject:searchString atIndex:0];
    [NSKeyedArchiver archiveRootObject:array toFile:recommendFilePath];
    
}

/**
 *  取出菜单信息
 */
+ (NSMutableArray *)searches
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];
}

+ (void) removeAllSearches
{
    NSMutableArray *array = [SearchModelTool searches];
    [array removeAllObjects];
    [NSKeyedArchiver archiveRootObject:array toFile:recommendFilePath];
}

@end
