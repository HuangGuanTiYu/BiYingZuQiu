//
//  HBTabBarView.h
//  HBIOSFrame
//
//  Created by 吴迪 on 15/10/23.
//  Copyright © 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBTabBarView;

@protocol HBTabBarViewDelegate <NSObject>

- (void) hBTabBarViewDidClick : (HBTabBarView *)hBTabBarView;

@end

@interface HBTabBarView : UITabBar

@property (nonatomic,weak) id<HBTabBarViewDelegate> hbDelegate;

@end
