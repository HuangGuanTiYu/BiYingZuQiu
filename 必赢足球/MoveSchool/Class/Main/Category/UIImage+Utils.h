//
//  UIImage+Utils.h
//  ImageBubble
//
//  Created by Richard Kirby on 3/14/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

- (UIImage *) renderAtSize:(const CGSize) size;
- (UIImage *) maskWithImage:(const UIImage *) maskImage;
- (UIImage *) maskWithColor:(UIColor *) color;

+ (UIImage *)imageWithBundleNamed:(NSString *)name andBundleName:(NSString *)bundle;
- (UIImage *)imageTo4b3AtSize:(CGSize)size;

- (UIImage *)imageToSize:(CGSize)size;
+ (CGFloat)scaleForPickImage:(UIImage *)image maxWidthPixelSize:(CGFloat)maxWidthPixelSize;
+ (UIImage *)scaleImage:(UIImage *)image scale:(CGFloat)scale;
@end
