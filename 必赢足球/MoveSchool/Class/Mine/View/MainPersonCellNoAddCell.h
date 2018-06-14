//
//  MainPersonCellNoAddCell.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/22.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"
@class MainPersonCellNoAddCell;
@protocol MainPersonCellNoAddCellDelegate <NSObject>

-(void)addViewWithAddWith:(UIButton *)btn;

@end

@interface MainPersonCellNoAddCell : UITableViewCell

@property(nonatomic,weak)id<MainPersonCellNoAddCellDelegate> delegate;

@property(nonatomic,strong)  UIButton *nameL;//名称
@property(nonatomic,strong)  UIButton *icon;//头像
@property(nonatomic,strong)  UILabel *vip;//vip等级
@property(nonatomic,strong)   UILabel *IDL;//Id
@property(nonatomic,strong)  UIImageView *ve;

@property(nonatomic,strong)UIImageView *view;
@property(nonatomic,strong) FriendModel *model;//接口
@end
