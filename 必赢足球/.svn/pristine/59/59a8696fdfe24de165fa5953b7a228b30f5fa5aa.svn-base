//
//  CourseSpecialViewCell.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/14.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "CourseSpecialViewCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation CourseSpecialViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    UIImageView *imagview = [[UIImageView alloc]initWithFrame:self.frame];
    self.imageview = imagview;
    [self addSubview:imagview];
    
    
    UILabel *titelLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.height/3, self.width/2, self.height/4)];
    self.titleLabel=titelLabel;
    titelLabel.textAlignment = NSTextAlignmentCenter;
    titelLabel.font=[UIFont systemFontOfSize:15];
    titelLabel.textColor=[UIColor whiteColor];
    titelLabel.backgroundColor=[UIColor colorWithRed:10/255.0f green:10/255.0f blue:10/255.0f alpha:0.6];
    [imagview addSubview:titelLabel];
    
    UILabel *timeLebel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.height/3*2, self.width/2, self.height/2)];
    self.timelabel=timeLebel;
    timeLebel.font=[UIFont systemFontOfSize:13];
    timeLebel.textAlignment = NSTextAlignmentCenter;
    timeLebel.textColor=[UIColor whiteColor];
    timeLebel.backgroundColor=[UIColor colorWithRed:2/255.0f green:2/255.0f blue:2/255.0f alpha:0.6];
    [imagview addSubview:timeLebel];
    
}
    return self;

}

-(void)setModel:(CourseSpecialModel *)model{
    
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    self.titleLabel.text = model.classesname;
    self.timelabel.text = model.descr;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageview.frame = CGRectMake(0, 0, self.width, self.width * 0.4);
    
    self.titleLabel.frame=CGRectMake(0, self.height / 4 + 10, self.width/3*2, self.height/4-10);
    self.timelabel.frame=CGRectMake(0, self.height / 2, self.width/3*2, self.height/4-10);
    
    self.titleLabel.centerX=self.imageview.centerX;
    self.timelabel.centerX= self.imageview.centerX;
}
@end
