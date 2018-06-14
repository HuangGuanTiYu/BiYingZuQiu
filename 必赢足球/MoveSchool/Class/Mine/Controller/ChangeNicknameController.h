//
//  ChangeNicknameController.h
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import <UIKit/UIKit.h>

@protocol ChangeNicknameControllerDelegate <NSObject>

- (void) changeNickname : (NSString *) name;

@end

@interface ChangeNicknameController : UIViewController

@property (nonatomic, copy) NSString *name;

@property (nonatomic, weak) id<ChangeNicknameControllerDelegate> delegate;

@end
