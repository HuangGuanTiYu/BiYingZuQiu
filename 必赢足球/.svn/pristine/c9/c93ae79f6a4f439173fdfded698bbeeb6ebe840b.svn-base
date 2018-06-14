//
//  StudyCircleCell.h
//  MoveSchool
//
//  Created by edz on 2017/5/6.
//
//

#import <UIKit/UIKit.h>
@class StudyCircleFrame,StudyCircleCell,AllTitleButton,StudyCircleModel,StudyReply,StudyReplyCell;

@protocol StudyCircleCellDelegate <NSObject>

//全文+收起
- (void) allButtonClick : (AllTitleButton *) allButton cell : (StudyCircleCell *) cell;

//评论 赞按钮点击
- (void) commentClick : (StudyCircleCell *) cell;

/**
 * 赞 取消赞
 * cid 主贴ID
 * isPraise YES 赞 NO 取消赞
 */
- (void) praiseWithCid : (NSString *) cid cell : (StudyCircleCell *) cell button : (UIButton *) button;

/**
 * 图片点击浏览
 * imageCount 图片数组个数
 * index 当前点击的索引值
 * currentImageView 当前点击的imageView
 */
- (void) imageClick : (NSUInteger) imageCount index : (NSInteger) index currentImageView : (NSArray *) imageViewArray;

/**
 * 删除按钮点击
 * cid 主贴ID
 */
- (void) deleteCircle : (StudyCircleCell *) cell cid : (NSString *) cid studyCircleModel : (StudyCircleModel *) studyCircleModel;

/**
 * 评论按钮点击
 * studyCircleModel 主贴Model
 */
- (void) replyButtonCic : (StudyCircleCell *) cell studyCircleModel :(StudyCircleModel *) studyCircleModel;

/**
 * 昵称点击
 */
- (void) nameLabelClick : (StudyCircleCell *) cell;

/**
 * 评论列表点击 回复 或者删除 自己的评论
 * reply 评论model
 */
- (void) replyListClick : (StudyCircleCell *) cell reply :(StudyReply *) reply studyCircleModel :(StudyCircleModel *) studyCircleModel studyReplyCell : (StudyReplyCell *) studyReplyCell;

/**
 * 点击空白区域 关闭 键盘
 */
- (void) closeKeyboard : (StudyCircleCell *) cell;

/**
 * 人名点击 跳转到 详情界面
 */
- (void) nameClick : (StudyCircleCell *) cell userId : (NSInteger) userId;

/**
 * 课程或者沙龙播放按钮点击
 * type;//1 图片附件 3 课程附件
 * courseID 课程ID
 */
- (void) startButtonClick : (NSString *) attach_businesscode courseID : (NSString *) courseID;


//跳转到详情界面
- (void) pushDetailVc : (StudyCircleCell *) cell;

@end

@interface StudyCircleCell : UITableViewCell

@property(nonatomic, strong) StudyCircleFrame *studyCircleFrame;

//点赞按钮
@property(nonatomic, strong) UIButton *goodButton;

//评论列表
@property(nonatomic, strong) UITableView *commentTableView;

@property(nonatomic, weak) id<StudyCircleCellDelegate> delegate;

//收起 赞和 评论的弹框
- (void) closeReplyAlertView;

//收起 赞和 评论的弹框 带动画
- (void) closeReplyAlertViewWithAnimate;

//设置赞按钮状态
- (void) setGoodButtonStatus : (BOOL) isPraise;



@end
