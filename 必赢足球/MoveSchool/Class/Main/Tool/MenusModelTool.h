//
//  MenusModelTool.h
//  MoveSchool
//
//  Created by edz on 2017/9/12.
//
//

#import <Foundation/Foundation.h>

@interface MenusModelTool : NSObject

/**
 *  保存菜单信息
 */
+ (void)saving:(NSArray *)menusModel;

/**
 *  取出菜单信息
 */
+ (NSArray *)menus;

@end
