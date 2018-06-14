//
//  MainThirdCell.h
//  Main
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainThirdCell;

@protocol MainThirdCellDelegate <NSObject>

-(void)passBtnTag:(UIButton *)btn;

@end


@interface MainThirdCell : UITableViewCell

@property(nonatomic,assign)BOOL isEnterPirse;//是否企业帐户

@property(nonatomic,weak)id <MainThirdCellDelegate> delegate;
@property(nonatomic,assign) NSInteger indexCount;
@property(nonatomic,strong)NSMutableArray *SetStrArr;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)UIView *bgview;

@end
