//
//  MenusModel.m
//  MoveSchool
//
//  Created by edz on 2017/9/11.
//
//

#import "MenusModel.h"
#import "MJExtension.h"
#import "MenusSubModel.h"

@implementation MenusModel

MJCodingImplementation

- (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id"
             };
}

- (NSDictionary *)objectClassInArray
{
    return @{@"subs": [MenusSubModel class]};
}

@end
