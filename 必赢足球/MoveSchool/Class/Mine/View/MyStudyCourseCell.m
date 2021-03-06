//
//  MyStudyCourseCell.m
//  MoveSchool
//
//  Created by edz on 2017/9/12.
//
//

#import "MyStudyCourseCell.h"
#import "TBCityIconFont.h"
#import "UILabel+Extension.h"
#import "HomePageModel.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"

@interface MyStudyCourseCell()

//图片
@property (nonatomic, strong) UIImageView *imgView;

//标题
@property (nonatomic, strong) UILabel *titleLabel;

//播放次数
@property (nonatomic, strong) UIButton *lookCountLabel;

//评论次数
@property (nonatomic, strong) UIButton *commentCountLabel;

//副标题（讲师名，免费）
@property (nonatomic, strong) UILabel *subtitleLabel;

//底部View
@property (nonatomic, strong) UIView *boomView;

//工具条
@property (nonatomic, strong) UIView *toolView;

//考试
@property (nonatomic, strong) UILabel *statueButton;

//分数
@property (nonatomic, strong) UILabel *sourLabel;

//分割线
@property (nonatomic, strong) UIView *sepaView2;

//间距
@property (nonatomic, strong) UIView *footView;

@end

@implementation MyStudyCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        self.titleLabel.textColor = MainTextColor;
        [self.contentView addSubview:self.titleLabel];
        
        self.boomView = [[UIView alloc] init];
        [self.contentView addSubview:self.boomView];
        
        self.lookCountLabel = [[UIButton alloc] init];
        self.lookCountLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.lookCountLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.lookCountLabel setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e629", 12, AuxiliaryColor)] forState:UIControlStateNormal];
        self.lookCountLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.lookCountLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.boomView addSubview:self.lookCountLabel];
        
        self.commentCountLabel = [[UIButton alloc] init];
        self.commentCountLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.commentCountLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.commentCountLabel setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e640", 12, AuxiliaryColor)] forState:UIControlStateNormal];
        self.commentCountLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.commentCountLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.boomView addSubview:self.commentCountLabel];
        
        self.subtitleLabel = [[UILabel alloc] init];
        self.subtitleLabel.text = @"免费";
        self.subtitleLabel.textAlignment = NSTextAlignmentRight;
        self.subtitleLabel.textColor = AuxiliaryColor;
        self.subtitleLabel.font = [UIFont systemFontOfSize:12];
        [self.boomView addSubview:self.subtitleLabel];
        
        self.toolView = [[UIView alloc] init];
        [self.contentView addSubview:self.toolView];
        
        self.sepaView2 = [[UIView alloc] init];
        self.sepaView2.backgroundColor = SepaViewColor;
        [self.toolView addSubview:self.sepaView2];
        
        self.statueButton = [[UILabel alloc] init];
        self.statueButton.textAlignment = NSTextAlignmentCenter;
        self.statueButton.font = [UIFont systemFontOfSize:ys_f24];
        [self.toolView addSubview:self.statueButton];
        
        self.sourLabel = [[UILabel alloc] init];
        self.sourLabel.textAlignment = NSTextAlignmentRight;
        self.sourLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.sourLabel.textColor = AuxiliaryColor;
        [self.toolView addSubview:self.sourLabel];
        
        self.footView = [[UIView alloc] init];
        self.footView.backgroundColor = ViewBackColor;
        [self.contentView addSubview:self.footView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图片
    self.imgView.frame = CGRectMake(mainSpacing15, mainSpacing15, 137, 77);
    
    //底部View
    self.boomView.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + mainSpacing, CGRectGetMaxY(self.imgView.frame) - 20, self.contentView.width - CGRectGetMaxX(self.imgView.frame) - mainSpacing15, 20);
    
    //标题
    CGFloat titleY = self.imgView.y + 5;
    self.titleLabel.frame = CGRectMake(self.boomView.x, titleY, self.boomView.width, self.boomView.y - titleY);
    
    [UILabel changeLineSpaceForLabel:self.titleLabel WithSpace:2.5];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.lookCountLabel.frame = CGRectMake(0, 0, 0,15);
    
    self.lookCountLabel.x = 0;
    self.lookCountLabel.width = 60;
    
    self.commentCountLabel.frame = CGRectMake(CGRectGetMaxX(self.lookCountLabel.frame) + 5, self.lookCountLabel.y, 50, self.lookCountLabel.height);
    
    CGFloat subTitleW = [NSString returnStringRect:@"免费" size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:[UIFont systemFontOfSize:12]].width + 5;
    self.subtitleLabel.frame = CGRectMake(self.boomView.width - subTitleW - mainSpacing, self.commentCountLabel.y, subTitleW, self.commentCountLabel.height);
    
    self.toolView.frame = CGRectMake(0, CGRectGetMaxY(self.boomView.frame) + mainSpacing15, self.contentView.width, 39);

    self.statueButton.frame = CGRectMake(0, 0, 45, 18);
    self.statueButton.centerX = self.toolView.width * 0.5;
    self.statueButton.centerY = self.toolView.height * 0.5;
    
    self.sourLabel.frame = CGRectMake(self.toolView.width - 50 - mainSpacing15, 0, 50, self.toolView.height);
    
    self.sepaView2.frame = CGRectMake(0, 0, self.toolView.width, 0.5);
    
    self.footView.frame = CGRectMake(0, CGRectGetMaxY(self.toolView.frame), self.contentView.width, mainSpacing);
}

- (void)setModel:(HomePageModel *)model
{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"zwt_kecheng"]];
    self.lookCountLabel.hidden = self.commentCountLabel.hidden = NO;
    
    if (model.title.length > 0) {
        self.titleLabel.text = model.title;
    }else if(model.mainTitle.length > 0)
    {
        self.titleLabel.text = model.mainTitle;
    }else
    {
        self.titleLabel.text = @"标题";
    }
    
    [self.lookCountLabel setTitle:model.learnNum forState:UIControlStateNormal];
    [self.commentCountLabel setTitle:model.discussNum forState:UIControlStateNormal];
    self.sourLabel.text = [NSString stringWithFormat:@"%@分",model.score];
    
    self.sourLabel.hidden = [model.score intValue] == 0;
    
    switch ([model.status intValue]) {
        case 1: //无考试未学完显示
            self.statueButton.text = @"继续学";
            self.statueButton.textColor = MainColor;
            self.statueButton.layer.borderColor = MainColor.CGColor;
            self.statueButton.layer.borderWidth = 0.5;
            self.statueButton.layer.cornerRadius = fillet;
            self.statueButton.layer.masksToBounds = YES;
            break;
        case 2: //有考试已学完显示
            self.statueButton.text = @"去考试";
            self.statueButton.textColor = MainColor;
            self.statueButton.layer.borderColor = MainColor.CGColor;
            self.statueButton.layer.borderWidth = 0.5;
            self.statueButton.layer.cornerRadius = fillet;
            self.statueButton.layer.masksToBounds = YES;
            break;
        case 3: //有考试未通过考试
            self.statueButton.text = @"去补考";
            self.statueButton.textColor = MainColor;
            self.statueButton.layer.borderColor = MainColor.CGColor;
            self.statueButton.layer.borderWidth = 0.5;
            self.statueButton.layer.cornerRadius = fillet;
            self.statueButton.layer.masksToBounds = YES;
            break;
        case 4: //有考试通过考试
            self.statueButton.text = @"已通过";
            self.statueButton.textColor = AuxiliaryColor;
            self.statueButton.layer.borderColor = [UIColor clearColor].CGColor;
            break;
        case 5: //有考试补考未通过
            self.statueButton.text = @"未通过";
            self.statueButton.textColor = MainRedColor;
            self.statueButton.layer.borderColor = [UIColor clearColor].CGColor;
            break;
        case 6: //无考试已学完
            self.statueButton.text = @"已学完";
            self.statueButton.textColor = AuxiliaryColor;
            self.statueButton.layer.borderColor = [UIColor clearColor].CGColor;
            break;
        default:
            break;
    }
    
}

@end
