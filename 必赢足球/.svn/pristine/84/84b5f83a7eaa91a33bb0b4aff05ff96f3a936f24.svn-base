//
//  MenusModelTool.m
//  MoveSchool
//
//  Created by edz on 2017/9/12.
//
//

#import "MenusModelTool.h"

#define recommendFilePath FilePathWithName(MenusFileName)

@implementation MenusModelTool

/**
 *  保存菜单信息
 */
+ (void)saving:(NSArray *)menus
{
    [NSKeyedArchiver archiveRootObject:menus toFile:recommendFilePath];

}

/**
 *  取出菜单信息
 */
+ (NSArray *)menus
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];
}

@end
