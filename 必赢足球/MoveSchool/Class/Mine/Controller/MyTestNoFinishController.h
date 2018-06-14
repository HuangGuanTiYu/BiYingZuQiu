//
//  MyTestNoFinishController.h
//  MoveSchool
//
//  Created by edz on 2017/9/13.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "XLPhotoBrowser.h"

@interface MyTestNoFinishController : UIViewController<XLPagerTabStripChildItem,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property(nonatomic, copy) NSString *studyTitle;

@end
