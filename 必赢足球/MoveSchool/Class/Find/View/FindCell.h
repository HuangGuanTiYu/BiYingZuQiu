//
//  FindCell.h
//  NewSchoolBus
//
//  Created by edz on 2017/8/18.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindModel,FindCell;

@protocol FindCellDelegate <NSObject>

- (void) findCellClick : (FindCell *) cell;

@end

@interface FindCell : UICollectionViewCell

@property (nonatomic, strong) FindModel *model;

@property (nonatomic, weak) id<FindCellDelegate> delegate;

@end
