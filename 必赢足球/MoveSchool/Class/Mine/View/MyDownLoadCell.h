//
//  MyDownLoadCell.h
//  MoveSchool
//
//  Created by edz on 2017/6/5.
//
//

#import <UIKit/UIKit.h>
@class DWDownloadItem,MyDownLoadCell;

@protocol MyDownLoadCellDelegate <NSObject>

- (void) downLoadCellClick : (MyDownLoadCell *) cell selected : (BOOL) selected;

@end

@interface MyDownLoadCell : UITableViewCell

@property (nonatomic, strong) DWDownloadItem *item;

//是否可以编辑
@property (nonatomic, assign) BOOL isEdit;

//选中按钮
@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, weak) id<MyDownLoadCellDelegate> myDownLoadCellDelegate;

@end
