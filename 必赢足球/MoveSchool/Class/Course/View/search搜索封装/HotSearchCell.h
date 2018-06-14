//
//  HotSearchCell.h
//  search
//
//  Created by 链酒电子商务有限公司 on 16/6/20.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HotSearchCellSelectDelegate <NSObject>

- (void)Hot:(UIButton *)btn;

@end
@interface HotSearchCell : UITableViewCell
@property(nonatomic,strong)NSArray *hotArry;
@property(nonatomic,weak)id <HotSearchCellSelectDelegate>delegate;
@end
