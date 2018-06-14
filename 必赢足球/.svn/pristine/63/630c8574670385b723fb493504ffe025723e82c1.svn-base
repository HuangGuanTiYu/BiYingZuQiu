//
//  HistorySearchCell.h
//  search
//
//  Created by 链酒电子商务有限公司 on 16/6/20.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HistorySearchCellSelectDelegate <NSObject>

- (void)History:(UITableViewCell *)cell;

@end
@interface HistorySearchCell : UITableViewCell
@property(nonatomic,strong)NSString *historystring;
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UIButton *deletebtn;
@property(nonatomic,weak)id <HistorySearchCellSelectDelegate>delegate;
@end
