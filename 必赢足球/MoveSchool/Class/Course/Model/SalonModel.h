//
//  SalonModel.h
//  zhitongti
//
//  Created by edz on 2016/11/28.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalonModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *starttime;  //举办时间
@property(nonatomic,copy)NSString *limitPepole;  //报名总数
@property(nonatomic,copy)NSString *learnNum; //沙龙包名人数
@property(nonatomic,copy)NSString *userstatus;//沙龙用户状态
@property(nonatomic,copy)NSString *imgurl;


@end
