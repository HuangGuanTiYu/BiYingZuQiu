//
//  AssetCell.m
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCAssetTablePicker.h"

@interface ELCAssetCell ()

@property (nonatomic, strong) NSArray *rowAssets;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *overlayViewArray;

@end

@implementation ELCAssetCell

@synthesize rowAssets = _rowAssets;

- (id)initWithAssets:(NSArray *)assets reuseIdentifier:(NSString *)identifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	if(self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:[assets count]];
        self.imageViewArray = mutableArray;
        
        NSMutableArray *overlayArray = [[NSMutableArray alloc] initWithCapacity:[assets count]];
        self.overlayViewArray = overlayArray;

        self.backgroundColor = kViewBackgroundColor;
        
        [self setAssets:assets];
	}
	return self;
}

- (void)setAssets:(NSArray *)assets
{
    self.rowAssets = assets;
	for (UIView *view in [self subviews]) {
        if ([view isKindOfClass:UIImageView.class]) {
            [view removeFromSuperview];
        }
	}
    //set up a pointer here so we don't keep calling [UIImage imageNamed:] if creating overlays
    UIImage *overlayImage = nil;
    for (int i = 0; i < [_rowAssets count]; ++i) {

        ELCAsset *asset = [_rowAssets objectAtIndex:i];

        if (i < [_imageViewArray count]) {
            UIImageView *imageView = [_imageViewArray objectAtIndex:i];
            imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageWithCGImage:asset.asset.thumbnail];
        } else {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.asset.thumbnail]];
            imageView.userInteractionEnabled = YES;
            [_imageViewArray addObject:imageView];
        }
        
        if (i < [_overlayViewArray count]) {
            UIImageView *overlayView = [_overlayViewArray objectAtIndex:i];
            if (asset.selected) {
                overlayView.image = [UIImage imageNamed:@"04选中"];//04未选
            }else
            {
                overlayView.image = [UIImage imageNamed:@"04未选"];
            }
            //overlayView.hidden = asset.selected ? NO : YES;
        } else {
            if (overlayImage == nil) {
                overlayImage = [UIImage imageNamed:@"04选中"];
            }
            UIImageView *overlayView = [[UIImageView alloc] initWithImage:overlayImage];
            [_overlayViewArray addObject:overlayView];
            if (asset.selected) {
                overlayView.image = [UIImage imageNamed:@"04选中"];//04未选
            }else
            {
                overlayView.image = [UIImage imageNamed:@"04未选"];
            }
            //overlayView.hidden = asset.selected ? NO : YES;
        }
    }
}

- (void)cellTapped:(UITapGestureRecognizer *)tapRecognizer
{
    int totalCount = self.bounds.size.width / CellWidth;
    
    double spaceWidth = (self.frame.size.width - totalCount*CellPhotoWidth)/(totalCount +1);
    
    CGRect frame = CGRectMake(spaceWidth, ColumnSpaceHeght, CellPhotoWidth, CellPhotoWidth);
    
    //CGRect overLayFrame = CGRectMake(frame.origin.x + frame.size.width- (23 + 5) , 20, 23, 23);
    
    CGPoint point = [tapRecognizer locationInView:self];
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
        
        UIImageView *overlayView = [_overlayViewArray objectAtIndex:i];
        
        CGRect overLayFrame = overlayView.frame;
        
        overLayFrame.origin.y = overLayFrame.origin.y - 5;
        overLayFrame.size.height = overLayFrame.size.height + 5;
        overLayFrame.size.width =  overLayFrame.size.width + 5;
        
        if (CGRectContainsPoint(overLayFrame, point)) {
            
            ELCAsset *asset = [_rowAssets objectAtIndex:i];
            if (!asset.selected && ![self.delegate isValidTapped]) {
                break;
            }
            asset.selected = !asset.selected;
            
            //overlayView.hidden = !asset.selected;
            if (asset.selected) {
                overlayView.image = [UIImage imageNamed:@"04选中"];//04未选
            }else
            {
                overlayView.image = [UIImage imageNamed:@"04未选"];
            }
            break;
            
        }else if (CGRectContainsPoint(frame, point)) {
            ELCAsset *asset = [_rowAssets objectAtIndex:i];
//            if (!asset.selected && ![self.delegate isValidTapped]) {
//                break;
//            }
//            asset.selected = !asset.selected;
//            
//            //overlayView.hidden = !asset.selected;
//            if (asset.selected) {
//                overlayView.image = [UIImage imageNamed:@"04选中"];//04未选
//            }else
//            {
//                overlayView.image = [UIImage imageNamed:@"04未选"];
//            }
            
            if (asset) {
                [asset showPhotoAtIndex:asset];
            }
            break;
        }
        
        frame.origin.x = frame.origin.x + frame.size.width + spaceWidth;
    }
}

- (void)layoutSubviews
{
    int totalCount = self.bounds.size.width / CellWidth;
    
    double spaceWidth = (self.frame.size.width - totalCount*CellPhotoWidth)/(totalCount +1);
    
	CGRect frame = CGRectMake(spaceWidth, ColumnSpaceHeght, CellPhotoWidth, CellPhotoWidth);
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
		UIImageView *imageView = [_imageViewArray objectAtIndex:i];
		[imageView setFrame:frame];
		[self addSubview:imageView];
        
        UIImageView *overlayView = [_overlayViewArray objectAtIndex:i];
        
         ELCAsset *asset = [_rowAssets objectAtIndex:i];
        
        if (asset.selected) {
            overlayView.image = [UIImage imageNamed:@"04选中"];//04未选
        }else
        {
            overlayView.image = [UIImage imageNamed:@"04未选"];
        }
        
        
        [overlayView setFrame:CGRectMake(frame.origin.x + frame.size.width- (23 + 5) , 20, 23, 23)];
        [self addSubview:overlayView];
		
		frame.origin.x = frame.origin.x + frame.size.width + spaceWidth;
	}
}

@end
