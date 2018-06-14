//
//  HBTabBarView.m
//  HBIOSFrame
//
//  Created by 吴迪 on 15/10/23.
//  Copyright © 2015年 HB. All rights reserved.
//

#import "HBTabBarView.h"
#import "TBCityIconFont.h"
#import "MenusModelTool.h"
#import "MenusModel.h"
#import "MianTabBarController.h"
#import "MainNavigationController.h"
#import "MyDownLoadsViewController.h"

@interface HBTabBarView()

@property (nonatomic,strong) UIButton *addButton;

@property (nonatomic, assign) BOOL needChangeStyle;

@end

@implementation HBTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.addButton = [[UIButton alloc] init];

        [self.addButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e67c", 35, MainColor)] forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStyle) name:ChangeTabBarStyle object:nil];
        
    }
    return self;
}

- (void)layoutSubviews
{
    UIViewController *vc = [self getCurrentVC];
    if ([vc isKindOfClass:[MyDownLoadsViewController class]]) {
        return;
    }
    
    [super layoutSubviews];

    if (self.needChangeStyle) {
        NSArray *menus = [MenusModelTool menus];
        
        BOOL hasAddMenu = NO;
        for (MenusModel *model in menus) {
            if (model.ID == MenuID) {
                hasAddMenu = YES;
            }
        }
        
        //需要加号
        if (hasAddMenu) {
            CGFloat buttonW = SCREENWIDTH * 0.2;
            for (int i = 0; i < self.subviews.count; i ++) {
                UIView *view = self.subviews[i];
                if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                    view.width = buttonW;
                    view.height = self.height;
                    view.y = 0;
                    if (i < 4) {
                        view.x = (i - 2) * buttonW;
                    }else
                    {
                        view.x = (i - 1) * buttonW;
                    }
                }
            }
            
            self.addButton.width = buttonW;
            self.addButton.height = self.height;
            self.addButton.y = 0;
            self.addButton.x = 2 * buttonW;
            
            self.addButton.hidden = NO;
            self.needChangeStyle = NO;
        }else{
            self.addButton.hidden = YES;
        }
    }
    
}

- (void) changeStyle
{
   
    self.needChangeStyle = YES;
    [self setNeedsLayout];
    
}

- (void)addClick
{
    if ([self.hbDelegate respondsToSelector:@selector(hBTabBarViewDidClick:)]) {
        [self.hbDelegate hBTabBarViewDidClick:self];
    }
}

- (UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}


@end
