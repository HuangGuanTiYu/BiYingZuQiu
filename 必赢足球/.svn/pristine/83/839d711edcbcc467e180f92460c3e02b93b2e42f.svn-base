//
//  MineStudyZhuantiViewController.h
//  Main
//
//  Created by yuhongtao on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

typedef enum
{
    ZhuantiSourceStudy, //来自我的学习
    ZhuantiSourceCollection, //来自我的收藏
    ZhuantiSourceCause //来自 我的事业部
} ZhuantiSourceType;

@protocol MineStudyZhuantiViewControllerDelegate <NSObject>

//刷新标题专题数量
- (void) reloadButtonBarView;

@end

@interface MineStudyZhuantiViewController : UIViewController<XLPagerTabStripChildItem>

//标签名字
@property (nonatomic,copy) NSString *pageTitle;

@property (nonatomic,weak) id<MineStudyZhuantiViewControllerDelegate> delegate;

@property(nonatomic, assign) int ZhuantiSourceType;

@property (nonatomic, copy) NSString *zttid;

- (instancetype)initWithType : (int) type;


@end
