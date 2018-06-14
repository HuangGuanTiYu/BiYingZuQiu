//
//  AGPhotoBrowserDataSource.h
//  AGPhotoBrowser
//
//  Created by Hellrider on 7/28/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGPhotoBrowserView;
@class CHShowPhotoView;

@protocol AGPhotoBrowserDataSource <NSObject>

@optional

- (NSInteger)numberOfPhotosForPhotoBrowser:(AGPhotoBrowserView *)photoBrowser;
- (UIImage *)photoBrowser:(AGPhotoBrowserView *)photoBrowser imageAtIndex:(NSInteger)index;
- (NSInteger)numberOfPhotosForShowPhotoView:(CHShowPhotoView *)photoBrowser;
- (id)showPhotoView:(CHShowPhotoView *)photoBrowser imageAtIndex:(NSInteger)index;


- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser titleForImageAtIndex:(NSInteger)index;
- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser descriptionForImageAtIndex:(NSInteger)index;

@end
