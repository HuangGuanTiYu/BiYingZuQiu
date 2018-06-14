//
//  ELCImagePickerController.h
//  ELCImagePickerDemo
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCAssetSelectionDelegate.h"

@class ELCImagePickerController;

@protocol ELCImagePickerControllerDelegate <UINavigationControllerDelegate>

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker;
- (BOOL)elcImagePickerController:(ELCImagePickerController *)picker didSelcetedNumber:(NSInteger)number;

@end

@interface ELCImagePickerController : UINavigationController <ELCAssetSelectionDelegate> 
@property (nonatomic, assign) BOOL isHelp;         //是否是一件反馈来的图像

@property (nonatomic, weak) id<ELCImagePickerControllerDelegate> delegate;

- (void)cancelImagePicker;

@end

