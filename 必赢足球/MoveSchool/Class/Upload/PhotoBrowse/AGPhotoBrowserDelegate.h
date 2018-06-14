//
//  AGPhotoBrowserDelegate.h
//  AGPhotoBrowser
//
//  Created by Hellrider on 7/28/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGPhotoBrowserView;
@class CHShowPhotoView;

@protocol AGPhotoBrowserDelegate <NSObject>

@optional

- (void)photoBrowser:(AGPhotoBrowserView *)photoBrowser didTapOnDoneButton:(UIButton *)doneButton;
- (void)showPhotoView:(CHShowPhotoView *)photoBrowser didTapOnDoneButton:(UIButton *)doneButton;
- (void)photoBrowser:(CHShowPhotoView *)photoBrowser didTapOnDeleteButton:(UIButton *)actionButton atIndex:(NSInteger)index;

- (void)photoBrowser:(CHShowPhotoView *)photoBrowser OnChecked:(UIButton *)actionButton checked:(BOOL)checked atIndex:(NSInteger)index;

@end
