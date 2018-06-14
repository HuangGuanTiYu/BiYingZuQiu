//
//  MyStudyCourseController.h
//  MoveSchool
//
//  Created by edz on 2017/9/12.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "XLPhotoBrowser.h"

@interface MyStudyCourseController : UIViewController<XLPagerTabStripChildItem,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property(nonatomic, copy) NSString *studyTitle;

@end
