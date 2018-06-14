//
//  StudyReply.h
//  MoveSchool
//
//  Created by edz on 2017/5/8.
//
//

#import <Foundation/Foundation.h>

@interface StudyReply : NSObject<NSCoding>

@property (nonatomic,assign) NSInteger userid;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,assign) NSInteger touserid;

@property (nonatomic,copy) NSString *indate;

@property (nonatomic,copy) NSString *headpic;

@property (nonatomic,copy) NSString *nickname;

@property (nonatomic,copy) NSString *tonickname;

@property (nonatomic,copy) NSString *tocontent;

@property (nonatomic,copy) NSString *cid;

@property (nonatomic, copy) NSString *rid; //评论ID

//富文本
@property(nonatomic, copy) NSMutableAttributedString *replyString;

@end
