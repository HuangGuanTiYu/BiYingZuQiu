//
//  StudyPraises.h
//  MoveSchool
//
//  Created by edz on 2017/5/8.
//
//

#import <Foundation/Foundation.h>

@interface StudyPraises : NSObject<NSCoding>

@property (nonatomic,copy) NSString *isPraise;

@property (nonatomic,copy) NSString *num;

//主贴点赞列表
@property (nonatomic, strong) NSArray *praiseUsers;

@end
