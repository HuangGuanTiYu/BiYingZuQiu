//
//  VideoModel.h
//  MoveSchool
//
//  Created by edz on 2018/1/10.
//

#import <Foundation/Foundation.h>

@interface FindVideoModel : NSObject

@property (nonatomic, assign) int businesscode;

@property (nonatomic, copy) NSString *businessid;

@property (nonatomic, assign) int discussNum;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *imgurl;

@property (nonatomic, copy) NSString *indate;

@property (nonatomic, assign) int learnNum;

@property (nonatomic, copy) NSString *mainid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSDictionary *priceView;

@property (nonatomic, copy) NSString *showDuration;

@property (nonatomic, copy) NSString *starttime;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *typeName;

@end
