//
//  MenusSubModel.m
//  MoveSchool
//
//  Created by edz on 2017/9/11.
//
//

#import "MenusSubModel.h"
#import "MJExtension.h"
#import "MenusSubModel.h"

@implementation MenusSubModel

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

- (void)setTitle:(NSString *)title
{
    _title = title;
}

- (void)setID:(int)ID
{
    _ID = ID;
}

@end
