//
//  LiveListPastCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/23.
//
//

#import <UIKit/UIKit.h>
@class HomePageModel, LiveListPastCell;

@protocol LiveListPastCellDelegate <NSObject>

- (void) liveButtonClick : (LiveListPastCell *) cell;

@end

@interface LiveListPastCell : UITableViewCell

@property (nonatomic, strong) HomePageModel *model;

@property (nonatomic, strong) UIView *sepaView;

//来自我是讲师 和 讲师详情 判断是否显示名字
@property (nonatomic, assign) BOOL isFromStudyDetail;

//来自我是讲师 判断是否显示直播按钮
@property (nonatomic, assign) BOOL isFromStudy;

@property (nonatomic, copy) NSString *teacherid;

@property (nonatomic, weak) id<LiveListPastCellDelegate> delegate;


@end
