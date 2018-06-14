//
//  HistorySearchCell.m
//  search
//
//  Created by 链酒电子商务有限公司 on 16/6/20.
//  Copyright © 2016年 链酒电子商务有限公司. All rights reserved.
//

#import "HistorySearchCell.h"
#define kSize [[UIScreen mainScreen]bounds].size
#import "UIView+Extension.h"

@implementation HistorySearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat margin=10;
        
        CGFloat deleteW=15;
        self.lable=[[UILabel alloc]initWithFrame:CGRectMake(margin+3,0 , 200, 30)];
        self.lable.font=[UIFont systemFontOfSize:12];
        
        self.lable.textColor=kColorGray154;
        [self addSubview:self.lable];
        self.deletebtn=[[UIButton alloc]initWithFrame:CGRectMake(kSize.width-margin-deleteW,0, deleteW, deleteW)];
        [self.deletebtn addTarget:self action:@selector(deleteclick) forControlEvents:UIControlEventTouchUpInside];
        [self.deletebtn setImage:[UIImage imageNamed:@"search_cancel"] forState:UIControlStateNormal];
        [self addSubview:self.deletebtn];
    }
    return self;
}

-(void)setHistorystring:(NSString *)historystring{
    self.lable.text=historystring;
    self.lable.centerY=25;
    self.deletebtn.centerY=25;
}
-(void)deleteclick{
    [self.delegate History:self];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
