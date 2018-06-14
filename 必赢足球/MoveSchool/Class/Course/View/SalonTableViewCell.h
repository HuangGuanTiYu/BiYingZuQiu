//
//  SalonTableViewCell.h
//  zhitongti
//
//  Created by edz on 2016/11/28.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalonModel.h"

@interface SalonTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *studyStatusL;
@property(nonatomic,strong) UIImageView  *imgView;
@property(nonatomic,strong) UILabel *titel;
@property(nonatomic,strong) UILabel *startTimme;
@property(nonatomic,strong) UILabel *startTimmeD;
@property(nonatomic,strong) UILabel *learnnum;
@property(nonatomic,strong)  UILabel *linelable;
@property(nonatomic,strong)  UILabel *limitPepole;
@property(nonatomic,strong)  UIProgressView *Progress;
@property(nonatomic,strong) UILabel *typeL;
@property(nonatomic,strong)  SalonModel *model;
@end
