//
//  InfoFriendTableViewCell.m
//  首页查看朋友
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import "InfoFriendTableViewCell.h"
#import "UIView+Extension.h"
@implementation InfoFriendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *name = [[UILabel alloc] init];//每一个动态显示的label
        name.frame = CGRectMake(5, 0, 200, self.height);
        name.textColor = AuxiliaryColor;
        self.name=name;
        name.font=[UIFont systemFontOfSize:ys_f24];
        [self addSubview:name];
        
        UILabel *detail = [[UILabel alloc] init];//每一个动态显示的label
        self.detail=detail;
        detail.textColor = MainTextColor;
        detail.font=[UIFont systemFontOfSize:ys_f24];
        detail.numberOfLines=0;
        [self addSubview:detail];
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
    self.name.text=model.name;
    self.detail.text=model.detailName;
    self.imageview.hidden=model.imageIshidden;

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.name.frame=CGRectMake(15, 0, 75, self.height);
    self.detail.frame=CGRectMake(85, 0, SCREEN_WIDTH - 95, self.height);
    self.imageview.frame=CGRectMake(CGRectGetMaxX(self.frame) - 30, 10, 20, 20);
}

@end
