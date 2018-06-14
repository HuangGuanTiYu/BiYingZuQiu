//
//  InfoFriendSectionTableViewCellAdd.m
//  首页查看朋友
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import "InfoFriendSectionTableViewCellAdd.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation InfoFriendSectionTableViewCellAdd


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
 
        
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.image=[UIImage imageNamed:@"common_add_friend"];//尖头图片
        self.imageview=imageview;
        [self addSubview:imageview];
        
        UILabel *name = [[UILabel alloc] init];//每一个动态显示的label
        name.textColor=[UIColor colorWithRed:154/255.0f green:154/255.0f blue:154/255.0f alpha:1];
        self.name=name;
        name.text=@"加为好友";
        name.textColor = GreenColor;
        name.font=[UIFont systemFontOfSize:14];
        [self addSubview:name];
        
        
        UIButton *btn=[[UIButton alloc]initWithFrame:self.frame];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        self.btn=btn;
        [self addSubview:btn];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.name.frame = CGRectMake(self.width/2-20, 0, 200, 0);
    self.imageview.frame=CGRectMake(CGRectGetMinX(self.name.frame)-30, 10, 20, 17);
    self.name.centerY=self.height/2;
        self.imageview.centerY=self.name.centerY;
    self.btn.frame=CGRectMake(0, 0, self.width, self.height);
}

-(void)click{

    [self.delegate addFirend];
}
@end
