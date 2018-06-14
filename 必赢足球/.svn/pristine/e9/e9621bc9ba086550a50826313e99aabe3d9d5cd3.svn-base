//
//  CountDownButton.h
//  SchoolBus
//
//  Created by 顾海波 on 2017/3/25.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountDownButton;

@protocol CountDownButtonDelegate <NSObject>

//获取验证码
- (void) getMobileCode : (CountDownButton *) button;

@end

@interface CountDownButton : UIButton

@property(nonatomic, weak) id<CountDownButtonDelegate> delegate;

@end
