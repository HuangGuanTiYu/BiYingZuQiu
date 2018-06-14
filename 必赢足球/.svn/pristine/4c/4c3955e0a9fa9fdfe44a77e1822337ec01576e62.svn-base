//
//  CollectionReusableView.h
//  MoveTag
//
//  Created by txx on 16/12/21.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionReusableViewDelegate <NSObject>

- (void) editState : (BOOL) buttonClick;

- (void) addTag;

@end

@interface CollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *editLabel;

@property (strong, nonatomic) UIView *imageTexgView;

@property (strong, nonatomic) UIImageView *noImage;

@property (strong, nonatomic) UIView *buttonView;

@property (strong, nonatomic) UILabel *toTestLabel;

//我的标签
@property (nonatomic, assign) BOOL isMy;

@property (nonatomic, weak) id<CollectionReusableViewDelegate> delegate;

@property (nonatomic, assign) BOOL buttonClick;

@property (nonatomic, strong) UIView *noCommentView;

@end
