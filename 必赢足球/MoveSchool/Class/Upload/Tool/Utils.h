//
//  Utils.h
//  TXChatDemo
//
//  Created by Cloud on 15/6/1.
//  Copyright (c) 2015年 IST. All rights reserved.
//

#ifndef TXChatDemo_Utils_h
#define TXChatDemo_Utils_h

#import "UIColor+Hex.h"
//


#define IOS7_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"7"] != NSOrderedAscending)
#define IOS8AFTER           ([[[UIDevice currentDevice] systemVersion] compare:@"8"] == NSOrderedAscending)


#define kStatusBarHeight        20.f    //状态栏高度
#define kNavigationHeight       40.f    //导航栏高度
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height
#define kLineHeight             0.5f
#define kEdgeInsetsLeft         10
#define kTabBarHeight           50.f

#define kChatToolBarHeight       50

#define kImageMaxWidthPixelSize  1024

#define DEGREES_TO_RADIANS(degrees) (degrees * M_PI / 180)
#define RADIANS_TO_DERREES(radians) (radians * 180 / M_PI)

#define kMessageAvatarWidth         42
#define kMessageBubbleTextMargin    5
#define kMessageCellSpace           10
#define kMessageViewMargin          6
#define kMessageSendNameHeight      20
#define kMessageVoiceBubbleMinWidth    80
#define kMessageVoiceBubbleMaxWidth    160
#define kMessageBubbleMinWidth      60
#define kMessageBubbleMinHeight     42

#define kMessageBubbleWidthMargin   22

#define kMessageIncomingLeftMargin  15
#define kMessageIncomingRightMargin 8
#define kMessageOutgoingLeftMargin  8
#define kMessageOutgoingRightMargin 15
#define kMessageBubbleTopMarigin    10
#define kMessageBubbleBottomMargin  10

#define kMessageIncomingImageLeftMargin     13
#define kMessageIncomingImageRightMargin    6
#define kMessageOutgoingImageLeftMargin     6
#define kMessageOutgoingImageRightMargin    13
#define kMessageBubbleImageTopMarigin    6
#define kMessageBubbleImageBottomMargin  6

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//判断字符串是不是空字符串
#define KISSTRNULL(a) ((a) == nil || (a).length == 0 )
//字符串处理成@""
#define KCONVERTSTRVALUE(a) (KISSTRNULL(a)?@"":a)
//
#define SCUSER_DEFAULT [NSUserDefaults standardUserDefaults]
//ios8版本
#define __IOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

//颜色
#define kColorGray3             [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]
#define kColorGray4             [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]
#define kColorGray5             [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]
#define kColorGray6             [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1]
#define kColorBlue1              [UIColor colorWithRed:48/255.0 green:183/255.0 blue:239/255.0 alpha:1]
#define kColorPinkLine          [UIColor colorWithRed:247/255.0 green:111/255.0 blue:113/255.0 alpha:0.3]
#define KColorNormalTxt             RGBCOLOR(75, 75, 75)          //
#define KColorTitleTxt              RGBCOLOR(0x4a, 0x4a, 0x4a) //标题颜色
#define KColorSubTitleTxt           RGBCOLOR(0xab, 0xab, 0xab) //子标题颜色

//新定义颜色
#define kColorBackground        [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]

#define kColorClear                 [UIColor clearColor]
#define kColorWhite                 RGBCOLOR(254,254,254)           //白色字体
#define kColorBlack                 RGBCOLOR(68,68,68)              //黑色字体
#define kColorGray                  RGBCOLOR(115,115,115)           //灰色字体
#define kColorGray1                 RGBCOLOR(73, 104, 119)
#define kColorLightGray             RGBCOLOR(159,160,160)           //浅灰色字体
#define kColorLine                  RGBCOLOR(216,216,216)           //分割线颜色
#define kColorPink                  RGBCOLOR(253,133,132)           //粉色
#define kColorBlue                  RGBCOLOR(0, 160, 233)
#define kColorItem                  RGBCOLOR(147, 158, 166)         //底部导航颜色
#define kColorOrange                RGBCOLOR(250, 111, 19)          //


//新定义字体
#define kFontNormal                 [UIFont systemFontOfSize:18]
#define kFontNormal_b               [UIFont boldSystemFontOfSize:18]
#define kFontMiddle                 [UIFont systemFontOfSize:15]
#define kFontMiddle_b               [UIFont boldSystemFontOfSize:15]
#define kFontSmall                  [UIFont systemFontOfSize:13]
#define kFontSmall_b                [UIFont boldSystemFontOfSize:13]
#define kFontLarge                  [UIFont systemFontOfSize:16]
#define kFontLarge_b                [UIFont boldSystemFontOfSize:16]
#define kFontSubTitle               [UIFont systemFontOfSize:12]
#define kFontTitle                  [UIFont systemFontOfSize:14]
#define kFontTimeTitle              [UIFont systemFontOfSize:9]

//font
#define kFontSuper              [UIFont systemFontOfSize:20]
#define kFontSuper_b            [UIFont boldSystemFontOfSize:20]
#define kFontLarge_1            [UIFont systemFontOfSize:17]
#define kFontLarge_1_b          [UIFont boldSystemFontOfSize:17]

#define kFontSmallBold          [UIFont boldSystemFontOfSize:12]
#define kFontTiny               [UIFont systemFontOfSize:11]
#define kFontMini               [UIFont systemFontOfSize:10]
#define kMessageTextFont        [UIFont systemFontOfSize:16]



//最大输入字符
#define kMaxInputCharacterCount   200
#define KMaxVerifyCode 6  //校验验证码的最大长度


#define NOTIFY_UPDATE_CIRCLE                    @"NOTIFY_UPDATE_CIRCLE"     //刷新圈子

#define kHideMoreView                           @"hideMoreView"             //隐藏圈子操作框

#define kErrorMessage                           @"MESSAGE"

#define KGROUPUPDATES                           @"updateGroups" //更新好友Id
#define NOTIFY_GROUP_UPDATED                    @"NOTIFY_GROUP_UPDATED" //群组信息更新（群组信息跟新）
#define NOTIFY_NEWFRIEND_UPDATE                 @"NOTIFY_NEWFRIEND_UPDATE" //有新天好友请求（添加好友的请求）
#define NOTIFY_ROOMLIST_UPDATE                  @"NOTIFY_ROOMLIST_UPDATE" //聊天群组（列表）更新
#define NOTIFY_MYFRIEND_UPDATE                  @"NOTIFY_MYFRIEND_UPDATE" //我的好友
#define NOTIFY_ROOMMEMBERS_UPDATE               @"NOTIFY_ROOMMEMBERS_UPDATE" //聊天群组成员变更
#define NOTIFY_GROUP_CREATE                     @"NOTIFY_GROUP_CREATE" //群组信息更新（群组创建）
#define NOTIFY_MSG_RECEIVED                     @"NOTIFY_MSG_RECEIVED" //收到新消息
#define NOTIFY_CIRCLE_NEWMSGPUSH                @"NOTIFY_CIRCLE_NEWMSGPUSH" //圈子新消息推送
#define NOTIFY_APP_BACKGROUND                   @"NOTIFY_APP_BACKGROUND" //app隐藏到后台

//第一次刷新好友列表 完成通知
#define NOTIFY_UPDATE_FRIENDS @"NOTIFY_UPDATE_FRIENDS"


//其他属性


#define KRESCODE                @"rescode" //rescode
#define KDATA                   @"data"//data
#define KROWS                   @"rows" //rows
#define KMESSAGE                @"msg" //msg
#define KDEPTNAME               @"deptname" //部门名字
#define KNICKNAME               @"nickname" //昵称
#define KHEADIMGURL             @"headimgurl" //头像
#define KDEPARTMENT             @"department" //部门
#define KVERTIME                @"vertime" //时间
#define KZTTID                  @"zttid" //zttid
#define KDEPTFIRST              @"deptfrist" //部门第一部分
#define KDEPTOTHER              @"deptother" //部门其他部分
#define KDOTYPE                 @"dotype" //好友操作
#define KOFURL                  @"ofurl" //即时通讯服务器地址
#define KOFHOST                 @"ofhost" //openfire服务器host
#define KOFSERVER               @"ofserver" //openfire服务器server
#define KOFPORT                 @"ofport" //openfire服务器端口
#define KFILESERVERRUL          @"fileserverurl" //文件上传服务器地址


#define KCircleUnreadKey       @"CircleUnreadKey" //圈子未读标识


#define kNavBarColor    [UIColor whiteColor]

#define kMajorColor [UIColor colorWithHexString:@"#556677"]//主色值

#define kCommonColor [UIColor colorWithHexString:@"#FF6600"]//辅色值

#define kMajorTextColor [UIColor colorWithHexString:@"#4A4A4A"]//文本颜色黑色

#define kCommonGrayTextColor [UIColor colorWithHexString:@"#9B9B9B"]//文本颜色灰色

#define kCommonTextBorderColor [UIColor colorWithHexString:@"#9B9B9B"]//文本框颜色

#define kCommonGreenTextColor [UIColor colorWithHexString:@"#3D7C00"]//绿色文本颜色

#define kCommonBackgroundColorColor [UIColor colorWithHexString:@"#4A4A4A"]//背景色值

#define KTokenTimeOutErrorCode 20002

#endif
