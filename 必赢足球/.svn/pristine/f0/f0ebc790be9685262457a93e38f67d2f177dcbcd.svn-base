//
//  TeacherListCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/23.
//
//

#import <UIKit/UIKit.h>
@class TeacherListModel,TeacherListCell;

@protocol TeacherListCellDelegate <NSObject>

//取消关注
- (void) cancleFollow : (TeacherListCell *) cell;

@end

@interface TeacherListCell : UITableViewCell

@property (nonatomic, strong) TeacherListModel *model;

//是否是从 我的关注进入的 如果是 显示 取消关注按钮
@property (nonatomic, assign) BOOL isFromMyFollow;

@property (nonatomic, weak) id<TeacherListCellDelegate> delegate;

@end
