//
//  MyTestModel.h
//  MoveSchool
//
//  Created by edz on 2017/9/13.
//
//

#import <Foundation/Foundation.h>

@interface MyTestModel : NSObject

@property (nonatomic, copy) NSString *testid; //考试id

@property (nonatomic, copy) NSString *testinfoid; //考试信息id

@property (nonatomic, copy) NSString *title; //考试名称

@property (nonatomic, copy) NSString *btime; //开始时间

@property (nonatomic, copy) NSString *etime; //结束时间

@property (nonatomic, copy) NSString *testdate; //考试时间

@property (nonatomic, assign) int testnum; //考试次数 0即参加考试

@property (nonatomic, copy) NSString *status; //0参加补考2阅卷中

@property (nonatomic, assign) int score; //分数

@property (nonatomic, copy) NSString *timeLength; //分钟

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *usernum;


@end
