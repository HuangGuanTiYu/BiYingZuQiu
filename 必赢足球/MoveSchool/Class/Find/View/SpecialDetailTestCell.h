//
//  SpecialDetailTestCell.h
//  MoveSchool
//
//  Created by edz on 2017/10/27.
//
//

#import <UIKit/UIKit.h>
@class MyTestModel;

@interface SpecialDetailTestCell : UITableViewCell

@property (nonatomic, strong) MyTestModel *model;

//分割线
@property (nonatomic,strong) UIView *sepaView;

@end
