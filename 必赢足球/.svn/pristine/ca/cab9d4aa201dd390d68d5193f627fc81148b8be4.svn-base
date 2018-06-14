//
//  MineModel.h
//  MoveSchool
//
//  Created by edz on 2017/9/11.
//
//

#import <Foundation/Foundation.h>
@class MineUser;

@interface MineModel : NSObject

@property (nonatomic, copy) NSString *isqiyexuanyuan; //0普通学员 1企业学员 如果是企业学员接着判断是否是企业管理员,否则直接判断是否是讲师

@property (nonatomic, copy) NSString *isqiyeadmin; //0不是企业管理员 1是企业管理员, 如果不是企业管理员,接着判断是否是讲师

@property (nonatomic, copy) NSString *isteacher;//0不是讲师 1是讲师

@property (nonatomic, copy) NSString *sign; //1未签到 2已签到

@property (nonatomic, strong) MineUser *user;

@end
