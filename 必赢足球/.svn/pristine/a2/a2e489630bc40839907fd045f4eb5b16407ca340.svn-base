//
//  DownLoadCell.h
//  MoveSchool
//
//  Created by edz on 2017/9/22.
//
//

#import <UIKit/UIKit.h>
@class ChapterModel, DownLoadCell;

@protocol DownLoadCellDelegate <NSObject>

- (void) downLoadCellClick : (DownLoadCell *) cell selected : (BOOL) selected;

@end

@interface DownLoadCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) UIButton *chapter; //章节

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) ChapterModel *model;

@property (nonatomic, weak) id<DownLoadCellDelegate> delegate;

@end
