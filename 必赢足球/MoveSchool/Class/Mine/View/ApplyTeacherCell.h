//
//  ApplyTeacherCell.h
//  zhitongti
//
//  Created by edz on 2017/5/25.
//  Copyright © 2017年 caobohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyTeacherCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *placeholderString;

//输入框
@property (nonatomic, strong) UITextField *textField;

@end
