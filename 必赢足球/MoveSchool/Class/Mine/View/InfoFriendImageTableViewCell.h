//
//  InfoFriendImageTableViewCell.h
//  首页查看朋友
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoFriendsModel.h"

@interface InfoFriendImageTableViewCell : UITableViewCell
@property(nonatomic,strong) infoFriendsModel *model;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *imagev;
@property (strong, nonatomic) UIImageView *imageview;
@end
