//
//  MultileHeadView.h
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYScrollView.h"

@protocol MultileHeadViewSelectDelegate <NSObject>

- (void)fastbtnclick:(UIButton *)btn withType:(NSString *)type withID:(NSString *)ID withWebUrl:(NSString *)Url;

@end
@interface MultileHeadView : UICollectionReusableView<WYScrollViewLocalDelegate>
@property(nonatomic,weak)id <MultileHeadViewSelectDelegate>delegate;
@property(nonatomic,strong)  NSArray * tempArr;
@end
