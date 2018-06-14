//
//  MessageModel.h
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *msgRecordid;

@property (nonatomic, copy) NSString *businessid;

@property (nonatomic, copy) NSString *businesscode;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, copy) NSString *auditopinion;

@property (nonatomic, copy) NSString *msgrecordtype;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *createrid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *indate;

@property (nonatomic, copy) NSString *headpic;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *roleName;

@property (nonatomic, strong) NSDictionary *targetBusiness;

// 任务title 高度
@property (nonatomic, assign) CGFloat taskTitleHeight;

// 通知info 高度
@property (nonatomic, assign) CGFloat noticeInfoHeight;

// 互动content 高度
@property (nonatomic, assign) CGFloat interactionCellHeight;

// 审核意见高度
@property (nonatomic, assign) CGFloat auditopinionCellHeight;

@end
