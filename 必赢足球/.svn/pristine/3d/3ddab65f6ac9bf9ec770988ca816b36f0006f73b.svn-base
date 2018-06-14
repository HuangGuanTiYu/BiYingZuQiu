//
//  MineOrderViewCell.h
//  我的定制
//
//  Created by yuhongtao on 16/7/9.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineOrderViewCell;
@protocol MineOrderViewCellDelegate <NSObject>

-(void)passBtnClick:(UIButton *)btn tableviewcell:(UITableViewCell *)cell;
-(void)add:(NSInteger )tag;
@end
@interface MineOrderViewCell : UITableViewCell
@property(nonatomic,weak)id<MineOrderViewCellDelegate>delegate;
@property(nonatomic,assign)BOOL isHide;
@property(nonatomic,assign)NSInteger isEnterprise;

@property(nonatomic,strong)NSArray *arry;//数据源数组
@property(nonatomic,strong)NSMutableArray *btnArr;//存储btn的临时数组用于编辑删除。
@property(nonatomic,strong)NSMutableArray *addBtnArr;//存储btn的临时数组用于编辑删除。
@property(nonatomic,assign)NSString *attriName;//用于区分是哪个section 的大加号；
@property(nonatomic,strong)UIView *contentview;//数据源数组



@property(nonatomic,strong)NSMutableArray  *addBtnArrBG;
@end
