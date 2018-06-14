//
//  VideoPreviewController.h
//  MoveSchool
//
//  Created by edz on 2018/1/10.
//

#import <UIKit/UIKit.h>
@class H5CourseModel, DWDownloadItem;

@interface VideoPreviewController : UIViewController

@property(nonatomic, strong) H5CourseModel *model;

//是否是从离线下载进来的
@property (nonatomic, assign) BOOL fromDown;

@property (nonatomic, strong) DWDownloadItem *item;


@end
