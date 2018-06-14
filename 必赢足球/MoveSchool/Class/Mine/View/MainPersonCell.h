//
//  MainPersonCell.h
//  Main
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"

@class MainPersonCell;
@protocol MainPersonCellDelegate <NSObject>

-(void)addViewWithAddWith:(UIButton *)btn;

- (void) nameClick;

@end


@interface MainPersonCell : UITableViewCell

@property(nonatomic,weak)id<MainPersonCellDelegate> delegate;


@property(nonatomic,strong) UIImageView *view;//背景
@property(nonatomic,strong) UIImageView *ve;
@property(nonatomic,strong) UIButton *nameL;//名称
@property(nonatomic,strong) UIButton *icon;//头像
@property(nonatomic,strong) UILabel *vip;//vip等级
@property(nonatomic,strong) UILabel *IDL;//Id
@property(nonatomic,strong) UIButton *addBtn;//加号

@property(nonatomic,strong) UIButton *doCard;//打卡
@property(nonatomic,strong) FriendModel *model;//接口


@property(nonatomic)BOOL cardBtnenabled;

@end
