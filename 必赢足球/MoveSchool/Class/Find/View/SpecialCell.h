//
//  SpecialCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/24.
//
//

#import <UIKit/UIKit.h>
@class CourseSpecialModel,SpecialCell;

@protocol SpecialCellDelegate <NSObject>

- (void) collectionLabelClick : (SpecialCell *) cell;

@end

@interface SpecialCell : UITableViewCell

@property (nonatomic, strong) CourseSpecialModel *model;

//是否是来自我的学习
@property (nonatomic, assign) BOOL isFromMyStudy;

@property (nonatomic, weak) id<SpecialCellDelegate> delegate;

@property (nonatomic, strong) UIButton *collectionLabel;

@end
