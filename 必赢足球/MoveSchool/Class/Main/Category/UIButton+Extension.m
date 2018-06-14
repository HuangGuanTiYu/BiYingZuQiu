//
//  UIButton+Extension.m
//  SchoolBus
//
//  Created by 顾海波 on 2017/3/25.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

/*
 *  开始倒计时
 */
- (void) startTime : (CGFloat) width
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.width = 100;
                self.x = SCREEN_WIDTH - 120;
                [self setTitle:@"获取手机验证码" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{

            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.width = 130;
                self.x = SCREEN_WIDTH - width;
                [self setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

@end
