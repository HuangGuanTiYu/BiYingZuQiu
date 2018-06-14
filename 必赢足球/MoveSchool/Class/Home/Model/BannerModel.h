//
//  BannerModel.h
//  NewSchoolBus
//
//  Created by edz on 2017/8/15.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

@property (nonatomic, copy) NSString *_id;

//业务ID
@property(nonatomic, copy) NSString *businesscode;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *imgurl;

@property (nonatomic, copy) NSString *businessid;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, copy) NSString *jumpUrl;

@end
