//
//  CommentCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/31.
//
//

#import <UIKit/UIKit.h>
@class CommentModel, CommentCell;

@protocol CommentCellDelegate <NSObject>

- (void) goodButtonClick : (CommentCell *) cell;

//删除评论
- (void) deleteComment : (CommentCell *) cell;

@end

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) CommentModel *model;

@property (nonatomic, weak) id<CommentCellDelegate> delegate;

//赞
@property (nonatomic, strong) UIButton *goodButton;

//分割线
@property (nonatomic, strong) UIView *sepaView;

@end
