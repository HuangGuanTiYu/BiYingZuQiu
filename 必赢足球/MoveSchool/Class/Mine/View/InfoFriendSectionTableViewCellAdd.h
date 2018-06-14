//
//  InfoFriendSectionTableViewCellAdd.h
//  首页查看朋友
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol InfoFriendSectionTableViewCellAddDelegate <NSObject>

-(void)addFirend;

@end

@interface InfoFriendSectionTableViewCellAdd : UITableViewCell
@property(nonatomic,weak)id<InfoFriendSectionTableViewCellAddDelegate>delegate;
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIButton *btn;
@end
