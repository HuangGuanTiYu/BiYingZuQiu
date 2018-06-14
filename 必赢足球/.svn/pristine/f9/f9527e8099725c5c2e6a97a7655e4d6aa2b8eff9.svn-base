//
//  MineMapHeaderview.m
//  zhitongti
//
//  Created by 链酒电子商务有限公司 on 16/8/15.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "MineMapHeaderview.h"
#define  H 35
#import "ManyLanguageMag.h"

@implementation MineMapHeaderview

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIView *backview=[[UIView alloc] initWithFrame:self.bounds];
         backview.backgroundColor=GreenColor;
        [self addSubview:backview];
        
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,3, H-20)];
        linelable.backgroundColor=GreenColor;
        [backview addSubview:linelable];
        
        
        UILabel *courselable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(linelable.frame)+6, 0, 80, H)];
        courselable.text=[ManyLanguageMag getMineStrWith:@"待学课程"];
         courselable.font=[UIFont systemFontOfSize:13];
        [backview addSubview:courselable];
        
        
        self.lable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110,0, 100, H)];
        self.lable.font=[UIFont systemFontOfSize:13];
        self.lable.textAlignment=NSTextAlignmentRight;
        self.lable.text=@"7/15门课程";
        [backview addSubview:self.lable];
        
        
        
     
        
    }
    return self;
}
-(void)setNum:(NSString *)num{

    self.lable.text =  [NSString stringWithFormat:@"%@%@",num,[ManyLanguageMag getMineStrWith:@"门课程"]];
}

@end
