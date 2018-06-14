//
//  CourseSpecialDetailViewController.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/15.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseSpecialModel.h"

@interface CourseSpecialDetailViewController : UIViewController

@property(nonatomic,strong) CourseSpecialModel *tempModel;//专题@“rows”的列表

@property(nonatomic,copy) NSString *ID;//接口，专题详情Id

@end
