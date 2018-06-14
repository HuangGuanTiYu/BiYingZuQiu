//
//  MainSecCell.h
//  Main
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSecCellModel.h"

@protocol MainSecCellDelegate <NSObject>

-(void)scoreBtnClick:(UIButton *)btn;

@end


@interface MainSecCell : UITableViewCell

@property(nonatomic,weak)id<MainSecCellDelegate>delegate;

@property(nonatomic,strong)UIButton *scoreBtn;//积分按钮
@property(nonatomic,strong)UIButton *cardBtn;//证书按钮
@property(nonatomic,strong)UIView *view;


@property(nonatomic,strong)MainSecCellModel *model;
@end
