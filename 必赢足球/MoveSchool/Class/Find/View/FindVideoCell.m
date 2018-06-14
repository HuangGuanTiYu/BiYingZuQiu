//
//  VideoCell.m
//  MoveSchool
//
//  Created by edz on 2018/1/10.
//

#import "FindVideoCell.h"
#import "TBCityIconFont.h"
#import "FindVideoModel.h"
#import "UIImageView+WebCache.h"

@interface FindVideoCell()

//图片
@property (nonatomic, strong) UIImageView *headerView;

//标题
@property (nonatomic, strong) UILabel *titleLabel;

//时长
@property (nonatomic, strong) UIButton *timeButton;

//播放次数
@property (nonatomic, strong) UIButton *lookCountLabel;

//评论次数
@property (nonatomic, strong) UIButton *commentCountLabel;

//底部View
@property (nonatomic, strong) UIView *boomView;

@end

@implementation FindVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headerView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];
        
        self.timeButton = [[UIButton alloc] init];
        self.timeButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.timeButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.timeButton.layer.borderWidth = 0.5;
        self.timeButton.layer.cornerRadius = 3;
        self.timeButton.layer.masksToBounds = YES;
        [self.timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.timeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.timeButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e695", ys_f24, [UIColor whiteColor])] forState:UIControlStateNormal];
        [self.contentView addSubview:self.timeButton];
        self.timeButton.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
        
        self.boomView = [[UIView alloc] init];
        [self.contentView addSubview:self.boomView];
        
        self.lookCountLabel = [[UIButton alloc] init];
        self.lookCountLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.lookCountLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.lookCountLabel setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e629", 12, AuxiliaryColor)] forState:UIControlStateNormal];
        self.lookCountLabel.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.lookCountLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.boomView addSubview:self.lookCountLabel];
        
        self.commentCountLabel = [[UIButton alloc] init];
        self.commentCountLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.commentCountLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.commentCountLabel setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e640", 12, AuxiliaryColor)] forState:UIControlStateNormal];
        self.commentCountLabel.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.commentCountLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.boomView addSubview:self.commentCountLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat headerViewH = self.height - mainSpacing * 4;
    self.headerView.frame = CGRectMake(mainSpacing, 0, headerViewH / 9 * 16, headerViewH);
    self.headerView.centerY = self.height * 0.5;
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + mainSpacing, self.headerView.y, self.width - 2 * mainSpacing - CGRectGetMaxX(self.headerView.frame), self.headerView.height * 0.5);
    [self.titleLabel sizeToFit];
    
    self.timeButton.frame = CGRectMake(0, 0, self.headerView.width * 0.6, headerViewH * 0.4);
    self.timeButton.center = self.headerView.center;
    
    //底部View
    self.boomView.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + mainSpacing, CGRectGetMaxY(self.headerView.frame) - 20, self.contentView.width - CGRectGetMaxX(self.headerView.frame) - mainSpacing15 - mainSpacing, 20);
    
    self.lookCountLabel.frame = CGRectMake(0, 0, 60, 15);
    
    self.commentCountLabel.frame = CGRectMake(CGRectGetMaxX(self.lookCountLabel.frame) + 5, self.lookCountLabel.y, 50, self.lookCountLabel.height);

}

- (void)setModel:(FindVideoModel *)model
{
    
    _model = model;
    
    self.titleLabel.text = model.title;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    
    [self.commentCountLabel setTitle:[NSString stringWithFormat:@"%d",model.discussNum] forState:UIControlStateNormal];
    
    [self.lookCountLabel setTitle:[NSString stringWithFormat:@"%d",model.learnNum] forState:UIControlStateNormal];
    
    [self.timeButton setTitle:model.showDuration forState:UIControlStateNormal];

}

@end
