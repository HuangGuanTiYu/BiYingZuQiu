//
//  ShalonModel.h
//  MoveSchool
//
//  Created by edz on 2017/8/24.
//
//

#import <Foundation/Foundation.h>

@interface ShalonModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *indate;

@property (nonatomic, copy) NSString *singupstart;

@property (nonatomic, copy) NSString *learnNum;

@property (nonatomic, copy) NSString *businessid;

@property (nonatomic, copy) NSString *jumpUrl;

@end
