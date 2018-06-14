//
//  FriendCheckViewController.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/22.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendCheckViewControllerDelegate <NSObject>

-(void)sendMsgAndDeleteFriendWith:(UIButton *)sender;

@end


@interface FriendCheckViewController : UITableViewCell


@property(nonatomic,weak)id<FriendCheckViewControllerDelegate> delegate;
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIImageView *deletaimageview;
@property(nonatomic,strong)UILabel *deletename;
@property(nonatomic,strong)UIImageView *line;//灰线


@property(nonatomic,strong)UIButton *  sendBtn;
@property(nonatomic,strong)UIButton *  deleteBtn;
@end
