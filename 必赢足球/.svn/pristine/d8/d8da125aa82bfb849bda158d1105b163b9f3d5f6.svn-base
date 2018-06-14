//
//  CollectionViewCell.h
//  MoveTag
//
//  Created by txx on 16/12/21.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionViewCell;

@protocol CollectionViewCellDelegate <NSObject>

- (void) deleteButtonClick : (CollectionViewCell *) cell;

@end

@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIButton *titleLabel;

@property (nonatomic, strong) UIButton *deleteButton;

@property(nonatomic,assign)BOOL editeState;

@property (nonatomic, weak) id<CollectionViewCellDelegate> delegate;

@end
