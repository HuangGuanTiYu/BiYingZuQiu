//
//  CourseStudyCommentModel.h
//  MoveSchool
//
//  Created by edz on 2017/6/2.
//
//

#import <Foundation/Foundation.h>

@interface CourseStudyCommentModel : NSObject

@property(nonatomic, copy) NSString *ID; //评论ID

@property(nonatomic, copy) NSString *mainid; //被讨论课程mainid

@property(nonatomic, copy) NSString *name; //标题

@property(nonatomic, copy) NSString *content; //讨论内容

@property(nonatomic, copy) NSString *time; //发布时间

@property(nonatomic, copy) NSString *username; //用户名

@property(nonatomic, copy) NSString *userid; //智同体用户ID

@property(nonatomic, assign) int userlv; //用户等级

@property(nonatomic, copy) NSString *praise; //点赞数

@property(nonatomic, assign) int existself; //自己是否点过赞  0 未点  1 已点

@property(nonatomic, copy) NSString *userheadpic; //头像

@property(nonatomic, assign) int replay_userid; //被回复用户id

@property(nonatomic, copy) NSString *replay_username; //被回复用户昵称

@property(nonatomic, copy) NSString *upid;

@property(nonatomic, copy) NSString *rootid;

@end
