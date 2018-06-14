//
//  ZttApp.m
//  zhitongti
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 caobohua. All rights reserved.
//

#import "ZttApp.h"
#import "ColorTypeTools.h"
#import <UMSocialCore/UMSocialCore.h>

//types 1：网易足球朋友圈，2：网易足球好友（群）（暂无），3：QQ空间，4：新浪微博，5：微信朋友圈
typedef enum : int {
    ShareTypeNone,
    ShareTypeToYdxt,
    ShareTypeToYdxtFriend,
    ShareTypeToQQ,
    ShareTypeToSina,
    ShareTypeToWeiXin,
} ShareType;

@interface ZttApp ()

@end

@implementation ZttApp

/**
 *  跳转到webview
 *  url 地址
 *  title 标题
 */
-(void)goToUrl:(NSString *)url :(NSString *)title{

    if (![url containsString:@"locale="]) {
        url = [NSString stringWithFormat:[url containsString:@"?"]?@"%@&locale=%@":@"%@?locale=%@",url,[ManyLanguageMag getTypeWithWebDiscript]];
    }
    
    if (![url containsString:@"token="]) {
        url = [NSString stringWithFormat:@"%@&token=%@",url,[UserInfoTool getUserInfo].token];
    }
    if ([self.delegate respondsToSelector:@selector(passWebviewControllerWithtitle:and:)]) {
        [self.delegate passWebviewControllerWithtitle:title and:url];
    }
}

/**
 *  下载接口
 */
-(void)down:(NSString *)url{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
    [ColorTypeTools saveImageToAlbum:image];
    if ([self.delegate respondsToSelector:@selector(zttDelegateWith:type:)]) {
        [self.delegate zttDelegateWith:url type:H5SavePhoto];
    }
}

#pragma mark 沙龙分享
-(void)shareShalong:(NSString *)shareId :(NSString *)type :(NSString *)title :(NSString *)summary :(NSString *)picurl{
    if ([self.delegate respondsToSelector:@selector(shareWithId:::::)]) {
        [self.delegate shareWithId:shareId :type :title :summary :picurl];
    }
}

#pragma mark 证书分享
-(void)shareCert :(NSString *)type :(NSString *)title  :(NSString *)picurl{
    if ([self.delegate respondsToSelector:@selector(shareCert:::)]) {
        [self.delegate shareCert:type :title :picurl];
    }
}

#pragma mark 咨询分享
- (void)shareNews:(NSString *)newid :(NSString *)types :(NSString *)title :(NSString *)summary :(NSString *)picurl
{
    if ([self.delegate respondsToSelector:@selector(shareNews:::::)]) {
        [self.delegate shareNews:newid :types :title :summary :picurl];
    }
}

//传送到所有界面的点击信息。
-(void)showCourse:(NSString *)courseid :(int)type{
    //   1课程，2 直播，3沙龙，4 专题，5 H5页面
    
    if ([self.delegate respondsToSelector:@selector(passCourseid:andType:)]) {
        [self.delegate passCourseid:courseid andType:type];
    }
}

-(void)showCourseInfo:(NSString *)courseid{
    if ([self.delegate respondsToSelector:@selector(zttDelegateWith:type:)]) {
        [self.delegate zttDelegateWith:courseid type:PushToCourse];
    }
}

#pragma mark 开启直播
- (void) startLive : (NSString *) liveId
{
    if ([self.delegate respondsToSelector:@selector(startLive:)]) {
        [self.delegate startLive:liveId];
    }
}

#pragma mark 荣誉榜排行界面
-(void)showHonorCoinRoll:(NSString *)uid
{
    if ([self.delegate respondsToSelector:@selector(gloryClick:)]) {
        [self.delegate gloryClick:coinRoll];
    }
}

-(void)showHonorInteractionRoll:(NSString *)uid
{
    if ([self.delegate respondsToSelector:@selector(gloryClick:)]) {
        [self.delegate gloryClick:interactionRoll];
    }
}

-(void)showHonorStudyRoll:(NSString *)uid
{
    if ([self.delegate respondsToSelector:@selector(gloryClick:)]) {
        [self.delegate gloryClick:studyRoll];
    }
}

- (void) close : (NSString *) type
{
    if ([self.delegate respondsToSelector:@selector(close:)]) {
        [self.delegate close : type];
    }
}

- (void) showlogin
{
    if ([self.delegate respondsToSelector:@selector(showlogin)]) {
        [self.delegate showlogin];
    }
}

//选择图片或者拍照
- (void) selectPic
{
    if ([self.delegate respondsToSelector:@selector(selectPic)]) {
        [self.delegate selectPic];
    }
}

//选取录音
- (void)selectVoice
{
    if ([self.delegate respondsToSelector:@selector(selectVoice)]) {
        [self.delegate selectVoice];
    }
}

//webview 右上角菜单设置
- (void) setMenus : (NSString *) menuJson
{
    if ([self.delegate respondsToSelector:@selector(setMenus:)]) {
        [self.delegate setMenus:menuJson];
    }
}

//制作课件返回
- (void) autoSave : (NSString *) menuJson
{
    if ([self.delegate respondsToSelector:@selector(autoSave:)]) {
        [self.delegate autoSave: menuJson];
    }
}

//隐藏保存按钮
- (void)hideMenus : (NSString *) menuJson
{
    if ([self.delegate respondsToSelector:@selector(hideMenus:)]) {
        [self.delegate hideMenus:menuJson];
    }
}

//设置webview是否可以下拉刷新
- (void) pullRefreshEnable : (BOOL) refreshEnable
{
    if ([self.delegate respondsToSelector:@selector(pullRefreshEnable:)]) {
        [self.delegate pullRefreshEnable:refreshEnable];
    }
}

// H5分享统一
- (void) shareUrl : (NSString *)url :(NSString *)title :(NSString *)summary :(NSString *)picurl
{

    if ([self.delegate respondsToSelector:@selector(shareUrl::::)]) {
        [self.delegate shareUrl:url :title :summary :picurl];
    }
}

// H5 登录
- (void) remindLogin
{
    if ([self.delegate respondsToSelector:@selector(remindLogin)]) {
        [self.delegate remindLogin];
    }
}

//h5 返回
- (void) returnLastPage
{
    if ([self.delegate respondsToSelector:@selector(returnLastPage)]) {
        [self.delegate returnLastPage];
    }
}

//创建音频课程
- (void) createAudioCourse
{
    if ([self.delegate respondsToSelector:@selector(createAudioCourse)]) {
        [self.delegate createAudioCourse];
    }
}

@end

