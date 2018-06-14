//
//  ShalonModel.m
//  MoveSchool
//
//  Created by edz on 2017/8/24.
//
//

#import "ShalonModel.h"
#import "MJExtension.h"

@implementation ShalonModel

MJCodingImplementation

- (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id"
             };
}

@end
