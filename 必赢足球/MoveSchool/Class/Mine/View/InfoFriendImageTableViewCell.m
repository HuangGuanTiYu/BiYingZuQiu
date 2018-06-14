//
//  InfoFriendImageTableViewCell.m
//  首页查看朋友
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import "InfoFriendImageTableViewCell.h"
#import "UIView+Extension.h"
@implementation InfoFriendImageTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *name = [[UILabel alloc] init];//每一个动态显示的label
        name.frame=CGRectMake(5, 0, 200, self.height);
        name.textColor=[UIColor colorWithRed:154/255.0f green:154/255.0f blue:154/255.0f alpha:1];
        self.name=name;
        [self addSubview:name];
        UIImageView *imagev = [[UIImageView alloc] init];//每一个动态显示的label
        imagev.image=[UIImage imageNamed:@""];//二维码图
        self.imagev=imagev;
        [self addSubview:imagev];
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.image=[UIImage imageNamed:@""];//尖头图片
        self.imageview=imageview;
        imageview.hidden=YES;
        [self addSubview:imageview];
    }
    return self;
}

-(void)setModel:(infoFriendsModel *)model{

    _model=model;
    self.imageview.hidden=model.imageIshidden;
    self.name.text=model.name;


}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.name.frame=CGRectMake(10, 0, 100, self.height);
    self.imageview.frame=CGRectMake(CGRectGetMaxX(self.frame)-30, 10, 20, 20);
}
@end
