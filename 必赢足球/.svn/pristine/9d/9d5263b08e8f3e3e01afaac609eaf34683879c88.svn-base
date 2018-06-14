//
//  HotSearchCell.m
//  search
//
//  Created by 链酒电子商务有限公司 on 16/6/20.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "HotSearchCell.h"
#define kSize [[UIScreen mainScreen]bounds].size

@implementation HotSearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setHotArry:(NSArray *)hotArry{
    
    CGFloat oneLineBtnWidtnLimit = kSize.width-20;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = 0;//btn的x间距
    CGFloat btnGapY = 10;
    NSInteger BtnlineNum = 0;
    CGFloat BtnHeight = 30;
    CGFloat minBtnLength =  50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0;//每个btn的起始位置
    Btnx += btnGap;
    for (int i = 0; i < hotArry.count; i++) {
        NSString *str =hotArry[i];
        CGFloat btnWidth = [self WidthWithString:str fontSize:12 height:BtnHeight];
        btnWidth += 20;//让文字两端留出间距
        
        if(btnWidth<minBtnLength)
            btnWidth = minBtnLength;
        
        if(btnWidth>maxBtnLength)
            btnWidth = maxBtnLength;
        
        
        if(Btnx + btnWidth > oneLineBtnWidtnLimit)
        {
            BtnlineNum ++;//长度超出换到下一行
            Btnx = btnGap;
        }
        
        
        UIButton *btn = [[UIButton alloc] init];
        
        CGFloat height =  (BtnlineNum*(BtnHeight+btnGapY));
        btn.frame = CGRectMake(Btnx, height,
                               btnWidth,BtnHeight );
        
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:kColorGray154 forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        Btnx = btn.frame.origin.x + btn.frame.size.width + btnGap;
        
        [self addSubview:btn];
        
    }
}
#pragma mark - self tools
//    根据字符串计算宽度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
    {
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}
-(void)standardBtnClick:(UIButton *)btn{
    [self.delegate Hot:btn];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
