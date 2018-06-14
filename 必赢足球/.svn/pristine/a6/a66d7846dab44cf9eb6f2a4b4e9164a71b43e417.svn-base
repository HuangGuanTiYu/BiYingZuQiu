//
//  MessageInteractionController.h
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

@protocol MessageInteractionControllerDelegate <NSObject>

//设置红点
- (void) setRedInteractionPoint: (int) count;

@end

@interface MessageInteractionController : UIViewController<XLPagerTabStripChildItem>

@property (nonatomic, weak) id<MessageInteractionControllerDelegate> delegate;

- (void)setTableViewHeight: (BOOL) hasRole;

@end
