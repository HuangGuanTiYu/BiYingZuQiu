//
//  CourseStudyCommentFrame.h
//  MoveSchool
//
//  Created by edz on 2017/6/2.
//
//

#import <Foundation/Foundation.h>
@class CourseStudyCommentModel;

@interface CourseStudyCommentFrame : NSObject

@property(nonatomic, strong) CourseStudyCommentModel *model;

//头像frame
@property(nonatomic, assign) CGRect headerFrame;

//昵称Frame
@property(nonatomic, assign) CGRect nickNameFrame;

//赞Frame
@property(nonatomic, assign) CGRect goodFrame;

//内容
@property(nonatomic, assign) CGRect contentFrame;

//时间
@property(nonatomic, assign) CGRect timeFrame;

//cell高度
@property(nonatomic, assign) CGFloat cellHeight;

@end
