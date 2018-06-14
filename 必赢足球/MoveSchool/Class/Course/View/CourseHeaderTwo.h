//
//  CourseHeaderTwo.h
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CourseHeaderTwoSelectDelegate <NSObject>

- (void)exchange:(UICollectionReusableView *)resuableView;

@end
@interface CourseHeaderTwo : UICollectionReusableView
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,assign)NSInteger sectionX;
@property(nonatomic,strong)UIImageView *image;
@property(nonatomic,weak)id <CourseHeaderTwoSelectDelegate>delegate;
@end
