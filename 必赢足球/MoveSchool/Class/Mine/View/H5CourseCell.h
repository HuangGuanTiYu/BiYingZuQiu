//
//  H5CourseCell.h
//  MoveSchool
//
//  Created by edz on 2017/6/28.
//
//

#import <UIKit/UIKit.h>
@class H5CourseModel,H5CourseCell;

@protocol H5CourseCellDelegate <NSObject>

//编辑按钮点击
- (void) editButtonClick : (H5CourseCell *) h5CourseCell;

@end

@interface H5CourseCell : UITableViewCell

@property (nonatomic, strong) H5CourseModel *h5CourseModel;

@property (nonatomic, weak) id<H5CourseCellDelegate> delegate;

//图片
@property (nonatomic, strong) UIImageView *headerView;

@end
