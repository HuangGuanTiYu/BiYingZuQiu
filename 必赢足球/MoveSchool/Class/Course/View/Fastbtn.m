//
//  Fastbtn.m
//  课程
//
//  Created by 链酒电子商务有限公司 on 16/6/21.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "Fastbtn.h"
#define margin 6
#define cordius self.frame.size.height-margin*2
#define titley (self.frame.size.height-20)/2
#define titlew self.frame.size.width-cordius-3*margin

@implementation Fastbtn

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return  CGRectMake(margin*2+cordius, titley, titlew, 20);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
     return  CGRectMake(margin, margin, cordius, cordius);
}
@end
