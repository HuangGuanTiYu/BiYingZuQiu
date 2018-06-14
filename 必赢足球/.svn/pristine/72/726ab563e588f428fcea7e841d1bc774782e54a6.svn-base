//
//  AlbumPickerController.h
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetTablePicker.h"
@protocol ELCAlbumPickerControllerDelegate;

@interface ELCAlbumPickerController : UITableViewController <ELCAssetSelectionDelegate>

@property (nonatomic, weak) id<ELCAssetSelectionDelegate> parent;
@property (nonatomic, strong) NSMutableArray *assetGroups;
@property (nonatomic, assign) BOOL singleSelection;         //单选
@property (nonatomic, assign) id<ELCAlbumPickerControllerDelegate> delegate;

@end
@protocol ELCAlbumPickerControllerDelegate <NSObject>

@optional
- (void)ELCAlbumPickerController:(ELCAlbumPickerController*)controller didSelectAlbumn:(ALAssetsGroup *)assetsGroup;
- (void)ELCAlbumPickerControllerDidSelectingAlbumn:(ELCAlbumPickerController*)controller;
- (void)ELCAlbumPickerControllerSelectingDisabled:(ELCAlbumPickerController*)controller;

@end
