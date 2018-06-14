//
//  CourseStudyCommentCell.h
//  MoveSchool
//
//  Created by edz on 2017/6/2.
//
//

#import <UIKit/UIKit.h>
@class CourseStudyCommentFrame, CourseStudyCommentCell;

@protocol CourseStudyCommentCellDelegate <NSObject>

//点赞成功
- (void) courseDiscussPraise : (CourseStudyCommentCell *) cell praise : (NSString *) praise;

@end

@interface CourseStudyCommentCell : UITableViewCell

@property(nonatomic, strong) CourseStudyCommentFrame *modelFrame;

@property(nonatomic, weak) id<CourseStudyCommentCellDelegate> delegate;

@end
