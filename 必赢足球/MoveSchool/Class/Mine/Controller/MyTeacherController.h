//
//  MyTeacherController.h
//  MoveSchool
//
//  Created by edz on 2017/5/4.
//
//

#import <UIKit/UIKit.h>
@class FriendModel;

@interface MyTeacherController : UIViewController

- (instancetype)initWithState : (int) state;

@property (nonatomic, strong) FriendModel *model;

@end
