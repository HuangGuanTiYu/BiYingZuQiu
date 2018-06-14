//
//  HotPointView.h
//  zhitongti
//
//  Created by yuhongtao on 16/6/28.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapGestureRecognizer.h"

@class RecommedModel;
@class HotPointModel;



@protocol iconClickAndRecommedListDelegate <NSObject>

-(void)iconClickAndRecommedListDelegate:(TapGestureRecognizer *)btn;

@end
@interface HotPointView : UIView


@property(nonatomic,strong)HotPointModel *model;
@property(nonatomic,strong)UILabel *imageLable;
@property(nonatomic,strong)TapGestureRecognizer *imgView;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,strong)UILabel *typeLable;
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong) UIImageView *seeView;
@property(nonatomic,strong)UILabel *whoSeeL;
@property(nonatomic,strong)UIImageView *recommedView;
@property(nonatomic,strong)UILabel *recommedL;
@property(nonatomic,strong)UIView * boardView;


@property(nonatomic,strong)NSMutableArray *recommendArr;//
@property(nonatomic,strong) NSMutableArray * messageArr;


@property(nonatomic,weak)id <iconClickAndRecommedListDelegate>delegate;
@end
