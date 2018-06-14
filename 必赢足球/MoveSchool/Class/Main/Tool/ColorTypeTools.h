//
//  ColorTypeTools.h
//  Main
//
//  Created by yuhongtao on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorTypeTools : NSObject

+(NSString *)getTypeStringWith:(NSString *)type;

+(NSString *) aes256_encrypt:(NSString *)key withString:(NSString *)str;
+(NSString *) aes256_decrypt:(NSString *)key withString:(NSString *)str;

+(void)saveImageToAlbum:(UIImage *)image;

+(NSString *)getStudyStatusWith:(NSString *)type;

+(UIBarButtonItem *)itemWithTitleName:(NSString *)TitleName highTitleName:(NSString *)hightTitleName addTarget:(id )class action:(SEL)action;

+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName  addTarget:(id )class action:(SEL)action;

//清除缓存
+(void)clearCache:(NSString *)path;

+(NSString *)clearTmpPics;

@end
