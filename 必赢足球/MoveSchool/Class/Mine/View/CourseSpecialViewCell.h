//
//  CourseSpecialViewCell.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/14.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseSpecialModel.h"


@interface CourseSpecialViewCell : UITableViewCell

@property(nonatomic,strong)CourseSpecialModel *model;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *timelabel;

@end
