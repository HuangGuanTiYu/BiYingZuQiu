//
//  CourseSpecialModel.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/15.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseSpecialModel : NSObject

@property(nonatomic,copy)NSString * pic;
@property(nonatomic,copy)NSString * descr;
@property(nonatomic,copy)NSString * createtime;
@property(nonatomic,copy)NSString * SpecialID;
@property(nonatomic,copy)NSString *classesname ;//名称
@property(nonatomic, copy) NSString *isfavorited;//0未收藏，1已收藏

/*我的收藏使用字段*/
@property(nonatomic,copy)NSString *imgurl;

@property(nonatomic,copy)NSString *indate;

@property(nonatomic,copy)NSString *favorite_id;

@property(nonatomic,copy)NSString *title;

@property (nonatomic,copy) NSString *image;

@property (nonatomic, copy) NSString *businessid;

@property (nonatomic, copy) NSString *contentNum;

@property (nonatomic, copy) NSString *learnNum;

@property (nonatomic, copy) NSString *coursenum;

@property (nonatomic, copy) NSString *membernum;



@end
