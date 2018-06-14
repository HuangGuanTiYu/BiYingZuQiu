//
//  EmotionTool.m
//  MoveSchool
//
//  Created by edz on 2017/5/15.
//
//

#import "EmotionTool.h"

@implementation EmotionTool

+ (NSString *) imageNameWithString : (NSString *) str
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emotion_icons.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    if ([array containsObject:str]) {
        int index = (int)[array indexOfObject:str];
        return [NSString stringWithFormat:@"Expression_%d",index + 1];
    }
    
    return @"";
}

+ (NSArray *) getEmotionArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emotion_icons.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

@end
