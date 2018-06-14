//
//  RankCell.h
//  MoveSchool
//
//  Created by edz on 2017/10/27.
//
//

#import <UIKit/UIKit.h>
@class RankModel;

@interface RankCell : UITableViewCell

@property (nonatomic, strong) RankModel *model;


//皇冠
@property (nonatomic, strong) UIImageView *crownImage;

@end
