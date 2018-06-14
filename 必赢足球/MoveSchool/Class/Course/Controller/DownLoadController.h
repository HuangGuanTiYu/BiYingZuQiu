//
//  DownLoadController.h
//  MoveSchool
//
//  Created by edz on 2017/9/22.
//
//

#import <UIKit/UIKit.h>

@interface DownLoadController : UIViewController

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) int format; ////课程格式 0 cc video 1 pdf 2 ztt video 4 h5课程

@property (nonatomic, strong) UIImage *image;

@end
