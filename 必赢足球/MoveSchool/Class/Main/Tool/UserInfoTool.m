//
//  UserInfoTool.m
//  MoveSchool
//
//  Created by edz on 2017/4/19.
//
//
#import "UserInfoTool.h"

#define recommendFilePath FilePathWithName(UserInfoFileName)

#define accountFilePath FilePathWithName(AccountFileName)

@implementation UserInfoTool

/**
 *  保存账号信息
 */
+ (void) saveUserInfo : (UserInfo *) userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo toFile:recommendFilePath];
}

/**
 *  保存账号信息
 */
+ (void) saveAccount : (AccountPwd *) accountPwd
{
    [NSKeyedArchiver archiveRootObject:accountPwd toFile:accountFilePath];
}


/**
 *  取出用户信息
 */
+ (UserInfo *) getUserInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];

}

/**
 *  取出账号密码
 */
+ (UserInfo *) getAccount
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:accountFilePath];
    
}

/**
 *  删除用户信息
 */
+ (void) delegateUserInfo
{
    UserInfo *userInfo = [self getUserInfo];
    userInfo = nil;
    [self saveUserInfo:userInfo];
}

/**
 *  用户是否登录
 */
+ (BOOL) isLogin
{
    return [self getUserInfo] != nil;
}

/**
 *  用户是否登录
 */
+ (BOOL) isTeahcher
{
    return [self getUserInfo].isteacher == 1;
}

/**
 * 是否是企业部门管理员角色
 */
+ (BOOL) isEnterprise
{
    return [self getUserInfo].type == 2 || [self getUserInfo].type == 4 || [self getUserInfo].type == 8;
}
@end
