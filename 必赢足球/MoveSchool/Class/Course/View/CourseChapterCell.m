//
//  CourseChapterCell.m
//  MoveSchool
//
//  Created by edz on 2017/8/30.
//
//

#import "CourseChapterCell.h"
#import "ChapterModel.h"
#import "UIImageView+CornerRadius.h"

@interface CourseChapterCell()


@end

@implementation CourseChapterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.chapter = [[UIButton alloc] init];
        self.chapter.titleLabel.font = [UIFont systemFontOfSize:ys_22];
        [self.chapter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.chapter];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.contentView addSubview:self.titleLabel];
        
        self.speed = [[UILabel alloc] init];
        self.speed.textAlignment = NSTextAlignmentCenter;
        self.speed.font = [UIFont systemFontOfSize:ys_22];
        self.speed.layer.borderWidth = 0.5;
        self.speed.layer.cornerRadius = fillet;
        self.speed.layer.masksToBounds = YES;
        [self.contentView addSubview:self.speed];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.chapter.frame = CGRectMake(15, 0, 45, 18);
    self.chapter.centerY = self.contentView.height * 0.5;
    
    CGFloat titleX = CGRectGetMaxX(self.chapter.frame) + mainSpacing;
    self.titleLabel.frame = CGRectMake(titleX, 0, 0, self.chapter.height);
    self.titleLabel.centerY = self.chapter.centerY;

    UIImageView *normalImage = [[UIImageView alloc] initWithFrame:self.chapter.bounds];
    [normalImage zy_cornerRadiusAdvance:fillet rectCornerType:UIRectCornerAllCorners];

    self.speed.frame = CGRectMake(self.contentView.width - 45 - 15, 0, 45, self.chapter.height);
    self.speed.centerY = self.chapter.centerY;

    //没有学习
    if ([self.model.progress intValue] == 0) {
        normalImage.image = [UIImage createImageWithColor:AuxiliaryColor];
    }else
    {
        if ([self.model.progress intValue] < 100){ //正在学习
            normalImage.image = [UIImage createImageWithColor:MainColor];
        }else
        {
            normalImage.image = [UIImage createImageWithColor:CourseFinish];
        }
    }
    
    self.titleLabel.width = self.contentView.width - titleX - 15 - 45 - mainSpacing;
    
    [self.chapter setBackgroundImage:normalImage.image forState:UIControlStateNormal];
    self.chapter.layer.cornerRadius = fillet;

}

- (void)setModel:(ChapterModel *)model
{
    _model = model;
        
    //没有学习
    if ([model.progress intValue] == 0) {
        self.speed.hidden = NO;
        self.titleLabel.textColor = MainTextColor;
        self.speed.textColor = AuxiliaryColor;
        self.speed.layer.borderColor = AuxiliaryColor.CGColor;
    }else if ([model.progress intValue] < 100) //正在学习
    {
        self.titleLabel.textColor = MainColor;
        self.speed.layer.borderColor = MainColor.CGColor;
        self.speed.textColor = MainColor;
        self.speed.hidden = NO;
        self.chapter.backgroundColor = MainColor;
    }else //学完
    {
        self.titleLabel.textColor = CourseFinish;
        self.speed.textColor = CourseFinish;
        self.speed.layer.borderColor = CourseFinish.CGColor;
        self.speed.hidden = NO;
        self.chapter.backgroundColor = CourseFinish;
    }
    
    self.speed.text = [NSString stringWithFormat:@"%@%%",model.progress];
    self.titleLabel.text = model.chapterTitle;
}


@end
