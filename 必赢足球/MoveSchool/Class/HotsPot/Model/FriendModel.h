//
//  FriendModel.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <Foundation/Foundation.h>

//增加麻烦
typedef enum : NSInteger {
    Friend_TYPE_UNKNOWN = 0, //陌生人，初始值
    Friend_TYPE_CUSTOM = 1, //客服
    Friend_TYPE_NORMAL, //普通好友
    Friend_TYPE_COLLEAGUE, //同事
} ftype;
@interface FriendModel : NSObject

@property(nonatomic,copy)NSString *company;//主体
@property(nonatomic,copy)NSString *companyid;//主体
@property(nonatomic,copy)NSString *department;//部门
@property(nonatomic,copy)NSString *ftype;  //类型
@property(nonatomic,copy)NSString *headimgurl;
@property(nonatomic,copy)NSString *lv;
@property(nonatomic,copy)NSString *mail;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *praisenum;
@property(nonatomic,copy)NSString *qq;
@property(nonatomic,copy)NSString *star;
@property(nonatomic,copy)NSString *zttid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *sex;//1男2女
@property(nonatomic,copy)NSString *username;//工号
@property(nonatomic,copy)NSString *job_phone;
@property(nonatomic,copy)NSString *tengroup;//事业部
@property(nonatomic)ftype friendType;//好友类型


@property(nonatomic,copy)NSString *headpic;//??

@end
