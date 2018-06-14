//
//  MenusSubModel.h
//  MoveSchool
//
//  Created by edz on 2017/9/11.
//
//

#import <Foundation/Foundation.h>

@interface MenusSubModel : NSObject<NSCoding>

//ID
@property (nonatomic, assign) int ID;

@property (nonatomic, copy) NSString *icon;

//子菜单
@property (nonatomic, strong) NSArray *subs;

//标题
@property (nonatomic, copy) NSString *title;

//积分富文本
@property (nonatomic, strong) NSMutableAttributedString *coinString;

//证书富文本
@property (nonatomic, strong) NSMutableAttributedString *certString;

@end
