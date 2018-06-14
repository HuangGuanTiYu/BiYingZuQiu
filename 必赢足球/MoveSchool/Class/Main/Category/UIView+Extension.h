//
//  UIView+Extension.h
//  sinaWeibo
//
//  Created by chok'chok on 14-10-7.
//  Copyright (c) 2014年 chok'chok. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Extension)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGSize size;

/**
 *  @author Ali
 *
 *  将当前view画出一条竖向的虚线  注意:view.size.wight 就是线条的宽度
 *
 *  @param lineHeight  单个线条长度
 *  @param lineSpacing 单个线条间距
 *  @param lineColor   单个线条颜色
 *
 *  将当前view画出一条竖向的虚线  注意:view.size.wight 就是线条的宽度
 */
- (void)drawVerticalDotterLineWithHeight:(CGFloat)lineHeight lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor;

/**
 * 删除View的所有子控件
 */
- (void)removeAllSubviews;

@end
