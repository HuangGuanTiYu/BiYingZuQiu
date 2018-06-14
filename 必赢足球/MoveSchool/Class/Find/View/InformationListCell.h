//
//  InformationListCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/21.
//
//

#import <UIKit/UIKit.h>
@class InformationListModel;

@interface InformationListCell : UITableViewCell

@property (nonatomic, strong) InformationListModel *model;

@property (nonatomic, strong) UIView *sepaView;

@end
