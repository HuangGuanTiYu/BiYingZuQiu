//
//  CourseListController.h
//  MoveSchool
//
//  Created by edz on 2017/8/22.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "XLPhotoBrowser.h"

@interface CourseListController : UIViewController<XLPagerTabStripChildItem,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property(nonatomic, copy) NSString *studyTitle;

@property(nonatomic,copy) NSString *ID;

@property (nonatomic, assign) BOOL isFromSearch;

@property (nonatomic, copy) NSString *key;

//刷新数据
- (void) headerRefresh;

@end
