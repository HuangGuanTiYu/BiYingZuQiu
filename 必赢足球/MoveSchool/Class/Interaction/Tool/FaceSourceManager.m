//
//  FaceSourceManager.m
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/30.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "FaceSourceManager.h"

@implementation FaceSourceManager

//从持久化存储里面加载表情源
+ (NSArray *)loadFaceSource
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    NSString *plistName = @"emotion_icons";
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    
    FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
    themeM.themeStyle = FaceThemeStyleCustomEmoji;
//    themeM.themeDecribe = [NSString stringWithFormat:@"f%d", 0];
//    themeM.themeIcon = @"section0_emotion0";
    
    NSMutableArray *modelsArr = [NSMutableArray array];
    
    for (int i = 0; i < array.count; ++i) {
        NSString *name = array[i];
        FaceModel *fm = [[FaceModel alloc] init];
        fm.faceTitle = name;
        fm.faceIcon = [NSString stringWithFormat:@"Expression_%d",i + 1];
        [modelsArr addObject:fm];
    }
    themeM.faceModels = modelsArr;
    
    [subjectArray addObject:themeM];
    
    
    return subjectArray;
}


@end
