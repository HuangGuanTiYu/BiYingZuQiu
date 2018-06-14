//
//  StudyCircleModel.h
//  MoveSchool
//
//  Created by edz on 2017/5/8.
//
//

#import <Foundation/Foundation.h>

@class StudyPraises;

@interface StudyCircleModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *ID;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *headpic;//用户头像

@property (nonatomic,copy) NSString *nickname;//用户昵称

@property (nonatomic,copy) NSString *indate;

@property (nonatomic,assign) NSInteger isself;//0 非自己发布 1 自己发布

@property (nonatomic,assign) int64_t userid;

@property (nonatomic,copy) NSString *commentcount;


//主贴回复列表
@property (nonatomic, strong) NSArray *comments;

//主贴点赞列表
@property (nonatomic, strong) StudyPraises *praise;

//主贴附件列表
@property (nonatomic, strong) NSArray *attachs;


@end
