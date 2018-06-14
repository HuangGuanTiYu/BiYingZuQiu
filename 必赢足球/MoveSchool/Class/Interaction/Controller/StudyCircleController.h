//
//  StudyCircleController.h
//  MoveSchool
//
//  Created by edz on 2017/5/6.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "XLPhotoBrowser.h"

@interface StudyCircleController : UIViewController<XLPagerTabStripChildItem,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property(nonatomic, copy) NSString *studyTitle;


@end
