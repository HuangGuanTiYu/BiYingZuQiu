//
//  MyTestFinishControllerController.h
//  MoveSchool
//
//  Created by edz on 2017/9/13.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "XLPhotoBrowser.h"

@interface MyTestFinishController : UIViewController<XLPagerTabStripChildItem,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property(nonatomic, copy) NSString *studyTitle;

@end
