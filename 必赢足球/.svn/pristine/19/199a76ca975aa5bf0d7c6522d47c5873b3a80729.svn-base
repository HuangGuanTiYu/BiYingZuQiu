//
//  StudyReplyCell.h
//  MoveSchool
//
//  Created by edz on 2017/5/15.
//
//

#import <UIKit/UIKit.h>
@class StudyReply;

@protocol StudyReplyCellDelegate <NSObject>

/**
 * 人名点击 跳转到 详情界面
 */
- (void) nameClick : (NSInteger) userId;

@end

@interface StudyReplyCell : UITableViewCell

@property(nonatomic, strong) StudyReply *model;

@property(nonatomic, weak) id<StudyReplyCellDelegate> delegate;


@end
