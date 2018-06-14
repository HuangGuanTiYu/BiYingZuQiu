//
//  H5CourseModel.h
//  MoveSchool
//
//  Created by edz on 2017/6/28.
//
//

#import <Foundation/Foundation.h>

@interface H5CourseModel : NSObject

@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *ccid;

@property(nonatomic,copy)NSString *mainid;

@property (nonatomic, copy) NSString *title;

@property(nonatomic,copy)NSString *desc;

//分享 简介
@property(nonatomic,copy)NSString *descClearHtml;

@property(nonatomic,copy)NSString *headimgurl;

@property(nonatomic,copy)NSString *labels;

@property (nonatomic, copy) NSString *showDuration;

@property(nonatomic,assign)NSInteger duration;

@property(nonatomic,assign)NSInteger status;

@property (nonatomic, copy) NSString *indate;

@end
