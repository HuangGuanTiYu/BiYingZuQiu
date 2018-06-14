//
//  MessageTaskController.h
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

@protocol MessageTaskControllerDelegate <NSObject>

//设置红点
- (void) setRedTaskPoint : (int) count;

@end

@interface MessageTaskController : UIViewController<XLPagerTabStripChildItem>

@property (nonatomic, weak) id<MessageTaskControllerDelegate> delegate;

- (void) setTableViewHeight : (BOOL) hasRole;


@end
