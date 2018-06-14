//
//  Asset.m
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import "ELCAsset.h"
#import "ELCAssetTablePicker.h"

@implementation ELCAsset

- (id)initWithAsset:(ALAsset*)asset
{
	self = [super init];
	if (self) {
		self.asset = asset;
        _selected = NO;
    }
    
	return self;	
}

- (void)toggleSelection
{
    self.selected = !self.selected;
}


-(void)showPhotoAtIndex:(ELCAsset*) asset
{
    if (_parent != nil && [_parent respondsToSelector:@selector(showPhotoFromIndex:)]) {
        [_parent showPhotoFromIndex:asset];
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        if (_parent != nil && [_parent respondsToSelector:@selector(assetSelected:)]) {
            [_parent assetSelected:self];
        }
    }else
    {
        if (_parent != nil && [_parent respondsToSelector:@selector(assetUnSelected:)]) {
            [_parent assetUnSelected:self];
        }
    }
}

@end

