//
//  ReleaseStudyController.h
//  MoveSchool
//
//  Created by edz on 2017/5/22.
//
//

#import <UIKit/UIKit.h>

@protocol ReleaseStudyControllerDelegate <NSObject>

//发布成功 刷新朋友圈
- (void) sendSuccessRefush;

@end

@interface ReleaseStudyController : UIViewController

@property (nonatomic, weak) id<ReleaseStudyControllerDelegate> delegate;

//是否是上传学习圈
@property (nonatomic, assign) BOOL releaseStudy;

@end
