//
//  MessageTaskNoticeCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/4.
//
//

#import <UIKit/UIKit.h>
@class MessageModel;

typedef enum {
    /** 任务 */
    Task,
    /** 通知 */
    Notice,
} MessageTaskNoticeCellType;

@interface MessageTaskNoticeCell : UITableViewCell

@property (nonatomic, strong) MessageModel *model;

@property (nonatomic, assign) int type;

@end
