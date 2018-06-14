//
//  CourseSpecialDetailOneCell.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/15.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseSpecialDetailCellOneModel.h"

@protocol CourseSpecialDetailOneCellDelegate <NSObject>

-(void)collectionDele;
-(void)moreInfomationWith:(UILabel *)label;

@end


@interface CourseSpecialDetailOneCell : UITableViewCell
@property(nonatomic,strong)CourseSpecialDetailCellOneModel *model;
@property(nonatomic,weak)id<CourseSpecialDetailOneCellDelegate> delegate;


@property(nonatomic,assign)BOOL selectedX;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *describeLebel;
@property(nonatomic,strong)UIButton *coloection;
@property(nonatomic,strong)UIButton *moreInformation;
@end
