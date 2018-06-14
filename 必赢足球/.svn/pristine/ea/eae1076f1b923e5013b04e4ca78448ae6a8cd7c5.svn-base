//
//  UserInfo.h
//  MoveSchool
//
//  Created by edz on 2017/4/19.
//
//

#import <Foundation/Foundation.h>

typedef enum
{
    LOGIN_TYPE_MOBILE = 0, //手机登录
    LOGIN_TYPE_EMAIL = 1 //邮箱登录
} LoginType;

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic, copy) NSString *ID;

//登录方式
@property(nonatomic, assign) int loginType;

//登录记住密码 记住的账号
@property(nonatomic, copy) NSString *loginId;

//登录记住密码 记住的密码
@property(nonatomic, copy) NSString *loginPwd;

//0未申请，1正常，2审批中，3禁用讲师，4未通过
@property(nonatomic, assign) int isteacher;

@property(nonatomic, copy) NSString *openId;

@property(nonatomic, strong) NSData *expird;

@property(nonatomic, copy) NSString *accessToken;

@property(nonatomic, copy) NSString *code;

@property(nonatomic, assign) int checkinstatus;

@property(nonatomic, assign) int exp;

@property(nonatomic, assign) int lv;

@property(nonatomic, copy) NSString *nickname;

@property(nonatomic, assign) int service;

@property(nonatomic, assign) int star;

@property(nonatomic, copy) NSString *token;

@property(nonatomic, assign) int type;

@property(nonatomic, copy) NSString *userkey;

@property(nonatomic, copy) NSString *username;

@property(nonatomic, copy) NSString *headimg;

@property(nonatomic, copy) NSString *sex; //1 男、2 女、3 其他、4 保密

@property(nonatomic, assign) int coin; //积分

@property(nonatomic, assign) int cert; //证书

@property(nonatomic, copy) NSString *zttid; //用户ID

@property(nonatomic, copy) NSString *qq;

@property(nonatomic, copy) NSString *email;

@property(nonatomic, copy) NSString *mobile;

@property(nonatomic, copy) NSString *company;

@property (nonatomic, copy) NSString *companyID;

@property(nonatomic, copy) NSString *department;

@property(nonatomic, copy) NSString *position;

@property(nonatomic, strong) NSDateFormatter *dateFormat;

@property(nonatomic, strong) NSString *headimgurl; //头像

@property (nonatomic, strong) NSString *headpic_path;

@end
