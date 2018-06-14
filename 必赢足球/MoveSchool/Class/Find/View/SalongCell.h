//
//  SalongCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/24.
//
//

#import <UIKit/UIKit.h>
@class ShalonModel, SalongCell;

@protocol SalongCellDelegate <NSObject>

//报名成功
- (void) signUpSuccess : (SalongCell *) cell;

@end

@interface SalongCell : UITableViewCell

@property (nonatomic, strong) ShalonModel *model;

//type 1已报名 2未报名
@property (nonatomic, assign) int type;

@property (nonatomic, weak) id<SalongCellDelegate> delegate;

@end
