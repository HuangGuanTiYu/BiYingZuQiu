//
//  SearchModelTool.h
//  MoveSchool
//
//  Created by edz on 2017/9/20.
//
//

#import <Foundation/Foundation.h>

@interface SearchModelTool : NSObject

/**
 *  保存菜单信息
 */
+ (void) saving : (NSString *) searchString;

/**
 *  取出菜单信息
 */
+ (NSMutableArray *)searches;

+ (void) removeAllSearches;


@end
