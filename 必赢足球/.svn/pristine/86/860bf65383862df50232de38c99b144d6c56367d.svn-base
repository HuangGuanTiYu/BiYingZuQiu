//
//  CourseHeaderTwo.m
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "CourseHeaderTwo.h"
#import "UIImage+RTTint.h"

@implementation CourseHeaderTwo

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor =[UIColor whiteColor];
        
        UILabel *lineOne = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineOne.backgroundColor = kColorGray240;
        [self addSubview:lineOne];
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(10, 22, 16, 16)];
        self.image = image;
        image.tintColor =[UIColor  greenColor];
        [self addSubview:image];
        
        self.name = [[UILabel alloc]init];
        self.name.frame = CGRectMake(35, 22, 100,16);
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textAlignment=NSTextAlignmentLeft;
        self.name.textColor=[UIColor blackColor];
        [self addSubview:self.name];
        
        UIButton *huanbtn=[[UIButton alloc]init];
        huanbtn.frame = CGRectMake(frame.size.width-15-55, 20, 70, 20);
        huanbtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [huanbtn setTitle:[ManyLanguageMag gethCourseStrWith:@"换一换"] forState:UIControlStateNormal];
        [huanbtn setTitleColor:kColorGray154 forState:UIControlStateNormal];
        [huanbtn setImage:[UIImage imageNamed:@"course_change"] forState:UIControlStateNormal];
        huanbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [huanbtn addTarget:self action:@selector(huanyihuan) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:huanbtn];
        UILabel *lineTwo =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, SCREEN_WIDTH, 1)];
        lineTwo.backgroundColor =kColorGray225;
        [self addSubview:lineTwo];
    }
    return self;
}

-(void)setSectionX:(NSInteger)sectionX{

    if (sectionX==1) {
        self.name.text=[ManyLanguageMag gethCourseStrWith:@"热门课程"];
        self.image.image = [UIImage imageNamed:@"course_hotcourse"];
    }if (sectionX==2) {
        self.name.text=[ManyLanguageMag gethCourseStrWith:@"猜你喜欢"];
        UIImage *image = [UIImage imageNamed:@"course_like"];
        UIImage *tinted = [image rt_tintedImageWithColor:GreenColor];
        self.image.image = tinted;
    }

}
-(void)huanyihuan{
    [self.delegate exchange:self];
}
@end
