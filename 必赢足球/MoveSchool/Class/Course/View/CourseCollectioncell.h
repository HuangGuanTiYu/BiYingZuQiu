//
//  CourseCollectioncell.h
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseHotModel.h"
@interface CourseCollectioncell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *courseImageview;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIButton *number;
@property(nonatomic,strong)CourseHotModel *model;
@end
