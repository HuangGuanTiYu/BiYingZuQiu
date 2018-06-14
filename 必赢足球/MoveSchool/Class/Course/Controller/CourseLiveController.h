//
//  CourseLiveController.h
//  MoveSchool
//
//  Created by edz on 2017/6/3.
//
//

#import <UIKit/UIKit.h>
@class ChapterModel;

@protocol CourseLiveControllerDelegate <NSObject>

- (void) fullButtonClick : (BOOL) buttonSelected;

@end

@interface CourseLiveController : UIViewController

//0 CC视频 2自己服务器视频
@property(nonatomic, assign) int format;

//自己服务器视频URL
@property(nonatomic, copy) NSString *videoLocalPath;

//CC视频ID
@property (copy, nonatomic)NSString *videoId;

//视频标题
@property (copy, nonatomic) NSString *liveTitle;

//章节ID
@property (copy, nonatomic) NSString *chapterid;

//章节列表
@property(nonatomic, strong) NSArray *captions;

//当前播放的章节信息
@property(nonatomic, strong) ChapterModel *model;

//当前是否是小屏
@property (nonatomic, assign) BOOL isSmall;

- (void) changeFrame : (BOOL) isFull;

@property (nonatomic, weak) id<CourseLiveControllerDelegate> delegate;

- (void) test;

@end
