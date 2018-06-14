//
//  LocationTool.m
//  qqqq
//
//  Created by 链酒电子商务有限公司 on 16/6/1.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "LocationTool.h"
#define ZJPLocationFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"location.plist"]
@implementation LocationTool
+(void)saveLocation:(NSMutableArray *)selectLocation{
    [NSKeyedArchiver archiveRootObject:selectLocation toFile:ZJPLocationFile];
}
+(NSMutableArray *)showSelectLocation{
    NSMutableArray *selectLocation  = [NSKeyedUnarchiver unarchiveObjectWithFile:ZJPLocationFile];
    return selectLocation;
}
@end
