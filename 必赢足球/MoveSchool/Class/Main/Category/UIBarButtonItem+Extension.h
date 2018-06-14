//
//  UIBarButtonItem+Extension.h
//  TattooMan
//
//  Created by 吴迪 on 15/10/19.
//  Copyright © 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)setRightNavigationBarBackGroundImgName:(NSString*)imageName target : (UIViewController *)target selector: (SEL)selector;

+ (instancetype)setRightNavigationBarBackGroundImgName:(NSString *)imageName target : (UIViewController *)target selector: (SEL)selector imageColor : (UIColor *) imageColor imageFont : (int) imageFont;

@end
