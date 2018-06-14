//
//  MenusModel.h
//  MoveSchool
//
//  Created by edz on 2017/9/11.
//
//

#import <Foundation/Foundation.h>

@interface MenusModel : NSObject<NSCoding>

//图标
@property (nonatomic, copy) NSString *icon;

//选中图标
@property (nonatomic, copy) NSString *iconSelected;

//ID
@property (nonatomic, assign) int ID;

//子菜单
@property (nonatomic, strong) NSArray *subs;

//标题
@property (nonatomic, copy) NSString *title;

@end
