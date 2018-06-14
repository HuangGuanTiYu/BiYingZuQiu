//
//  MineMapHeaderview.h
//  zhitongti
//
//  Created by 链酒电子商务有限公司 on 16/8/15.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineMapHeaderview : UITableViewHeaderFooterView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@property(strong,nonatomic)UILabel *lable;
@property(copy,nonatomic)NSString *num;

@end
