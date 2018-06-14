//
//  VideoCourseController.h
//  MoveSchool
//
//  Created by edz on 2017/12/23.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

@interface VideoCourseController : UIViewController<XLPagerTabStripChildItem>

@property (nonatomic,copy) NSString *pageTitle;

@end
