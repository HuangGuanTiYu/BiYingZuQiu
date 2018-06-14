//
//  UserInfoTool.h
//  MoveSchool
//
//  Created by edz on 2017/4/19.
//
//

#import <Foundation/Foundation.h>
#import "AccountPwd.h"
@class UserInfo;

@interface UserInfoTool : NSObject

/**
 *  保存账号信息
 */
+ (void) saveUserInfo : (UserInfo *) userInfo;

/*
 *  保存账号密码
 */
+ (void) saveAccount : (AccountPwd *) accountPwd;

/**
 *  取出用户信息
 */
+ (UserInfo *) getUserInfo;

/**
 *  取出账号密码
 */
+ (UserInfo *) getAccount;

/**
 *  删除用户信息
 */
+ (void) delegateUserInfo;

/**
 *  用户是否登录
 */
+ (BOOL) isLogin;

/**
 * 是否是企业部门管理员角色
 */
+ (BOOL) isEnterprise;

/**
 *  用户是否登录
 */
+ (BOOL) isTeahcher;

@end
