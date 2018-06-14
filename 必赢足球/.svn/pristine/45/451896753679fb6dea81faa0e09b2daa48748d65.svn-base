//
//  CHShowPhotoView.h
//  ChildHoodStemp
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGPhotoBrowserDataSource.h"
#import "AGPhotoBrowserDelegate.h"
#import "ELCAsset.h"

@class CHFriendFeed;

@interface CHShowPhotoView : UIView

@property (nonatomic, weak) id<AGPhotoBrowserDelegate> delegate;
@property (nonatomic, weak) id<AGPhotoBrowserDataSource> dataSource;
@property (nonatomic, weak) UIViewController *subVc;
@property (nonatomic, strong) CHFriendFeed *feed;

@property (nonatomic, strong) NSMutableArray *elcAssets;

@property (nonatomic,assign)BOOL isShowEditMenu;


- (id)initWithFrame:(CGRect)frame andEdit:(BOOL)isEdit;

- (void)show;
- (void)showFromIndex:(NSInteger)initialIndex;
- (void)showFromIndex:(NSInteger)initialIndex checked:(BOOL)checked elcAssets:(NSMutableArray *)elcAssets;
- (void)hideWithCompletion:( void (^) (BOOL finished) )completionBlock;
- (id)initWithFrame:(CGRect)frame;
-(void)hideDeleteBtn;
-(void)showEditMenu;

@end
