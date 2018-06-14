//
//  Asset.h
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class ELCAsset;

@protocol ELCAssetDelegate <NSObject>

@optional
- (void)assetSelected:(ELCAsset *)asset;

-(void)assetUnSelected:(ELCAsset *)asset;

-(void)showPhotoFromIndex:(ELCAsset*) asset;

@end

@interface ELCAsset : NSObject

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, weak) id<ELCAssetDelegate> parent;
@property (nonatomic) BOOL selected;

- (id)initWithAsset:(ALAsset *)asset;

-(void)showPhotoAtIndex:(ELCAsset*) asset;

@end