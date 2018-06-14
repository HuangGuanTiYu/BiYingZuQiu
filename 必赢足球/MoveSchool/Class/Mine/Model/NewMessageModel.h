//
//  NewMessageModel.h
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import <Foundation/Foundation.h>

@interface NewMessageModel : NSObject

//msgrecordtype1阅读2审核
@property (nonatomic, assign) int msgrecordtype;

//1任务、2通知、3互动//Count数量
@property (nonatomic, assign) int msgtype;

@property (nonatomic, assign) int count;

@end
