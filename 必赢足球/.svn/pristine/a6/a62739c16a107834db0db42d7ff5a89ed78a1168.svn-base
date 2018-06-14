//
//  MessageNoticeController.h
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

@protocol MessageNoticeControllerDelegate <NSObject>

//设置红点
- (void) setRedNoticePoint : (int) count;

@end

@interface MessageNoticeController : UIViewController<XLPagerTabStripChildItem>

@property (nonatomic, weak) id<MessageNoticeControllerDelegate> delegate;

- (void)setTableViewHeight: (BOOL) hasRole;

@end
