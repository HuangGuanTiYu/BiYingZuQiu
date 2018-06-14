//
//  MainThirdCell.m
//  Main
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainThirdCell.h"
#import "UIView+Extension.h"
#import "ManyLanguageMag.h"
#import "TopImageButton.h"

#define space 30
#define kSize [[UIScreen mainScreen]bounds].size

@implementation MainThirdCell

//设置界面的按钮名称
-(NSMutableArray *)SetStrArr{
    
    if (!_SetStrArr) {
        
        if (!_isEnterPirse) {
            
            if ([UserInfoTool isTeahcher]) {
                _SetStrArr = [NSMutableArray arrayWithObjects:@"我的学习",@"我的收藏",@"我的下载",@"我的定制",@"我是讲师",@"问卷",@"我的课件",@"我的消息",@"设置",nil];
                _imageArr = [NSMutableArray arrayWithObjects:@"mine_study",@"mine_collection",@"mine_donwload",@"mine_label",@"mine_teacher",@"mine_questions",@"common_kejian",@"mine_news",@"mine_setting", nil];
            }else
            {
                _SetStrArr = [NSMutableArray arrayWithObjects:@"我的学习",@"我的收藏",@"我的下载",@"我的定制",@"我是讲师",@"问卷",@"我的消息",@"设置",nil];
                _imageArr = [NSMutableArray arrayWithObjects:@"mine_study",@"mine_collection",@"mine_donwload",@"mine_label",@"mine_teacher",@"mine_questions",@"mine_news",@"mine_setting", nil];
            }

        }else{
            if ([UserInfoTool isTeahcher]) {
                _SetStrArr=[NSMutableArray arrayWithObjects:@"我的学习",@"我的考试",@"我的收藏",@"我的下载",@"我的事业部",@"我的定制",@"学习地图",@"我是讲师",@"问卷",@"我的课件",@"我的消息",@"设置",nil];
                _imageArr = [NSMutableArray arrayWithObjects:@"mine_study",@"mine_examination",@"mine_collection",@"mine_donwload",@"mine_groups",@"mine_label",@"mine_map",@"mine_teacher",@"mine_questions",@"common_kejian",@"mine_news",@"mine_setting", nil];
            }else
            {
                _SetStrArr=[NSMutableArray arrayWithObjects:@"我的学习",@"我的考试",@"我的收藏",@"我的下载",@"我的事业部",@"我的定制",@"学习地图",@"我是讲师",@"问卷",@"我的消息",@"设置",nil];
                _imageArr = [NSMutableArray arrayWithObjects:@"mine_study",@"mine_examination",@"mine_collection",@"mine_donwload",@"mine_groups",@"mine_label",@"mine_map",@"mine_teacher",@"mine_questions",@"mine_news",@"mine_setting", nil];
            }
        }
    }
    
    return _SetStrArr;
}

-(void)click:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(passBtnTag:)]) {
        [self.delegate passBtnTag:btn];
    }
}

-(void)setIsEnterPirse:(BOOL)isEnterPirse{
    
    _isEnterPirse = isEnterPirse;
    
    //语言设置
    for (int i = 0; i <self.SetStrArr.count; i++) {
        NSString *name = self.SetStrArr[i];
        self.SetStrArr[i]= [ManyLanguageMag getMineMenuStrWith:name];
    }
    
    NSInteger number = 4; //4列
    
    CGFloat Width = kSize.width / number;
    CGFloat Height = Width;
    
    for (int i = 0; i < self.SetStrArr.count; i ++) {
        TopImageButton *view = [[TopImageButton alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        view.tag = i;
        view.x = (i % number) * Width;
        view.y = (i / number) * Height;
        [view setTitleColor:[UIColor colorWithRed:72/255.0f green:72/255.0f blue:72/255.0f alpha:1.0] forState:UIControlStateNormal];
        [view setTitle:self.SetStrArr[i] forState:UIControlStateNormal];
        [view setImage:[UIImage imageNamed:self.imageArr[i]] forState:UIControlStateNormal];
        [view addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view];
    }
}

@end
