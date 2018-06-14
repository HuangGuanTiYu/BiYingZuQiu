//
//  ShaLongTool.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/21.
//

#import <Foundation/Foundation.h>
@class ShalonModel;

@interface ShaLongTool : NSObject

/**
 *  保存音频信息
 */
+ (void) saving : (ShalonModel *) videoModel;

/**
 *  取出音频信息
 */
+ (NSMutableArray *)videoModels;

/**
 * 删除所有音频
 */
+ (void) removeVideoModel : (ShalonModel *) model;

+ (void) saveDWDownloadItems : (NSMutableArray *) items;

@end
