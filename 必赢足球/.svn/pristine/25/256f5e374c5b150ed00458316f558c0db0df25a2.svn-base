//
//  MyCareerViewCell.m
//  MoveSchool
//
//  Created by edz on 2017/6/7.
//
//

#import "MyCareerViewCell.h"
#import "MineCareerModel.h"

@interface MyCareerViewCell()

//索引
@property (nonatomic, strong) UILabel *indexLabel;

//名称
@property (nonatomic, strong) UILabel *nameLabel;

//积分
@property (nonatomic, strong) UILabel *careerLabel;

//箭头
@property (nonatomic, strong) UIImageView *nextImage;

//分割线
@property (nonatomic, strong) UIView *sepaView;

@end

@implementation MyCareerViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.indexLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.indexLabel];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        
        self.careerLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.careerLabel];
        
        self.nextImage = [[UIImageView alloc] init];
        self.nextImage.image = [UIImage imageNamed:@"common_narrow_right"];
        [self.contentView addSubview:self.nextImage];
        
        self.indexLabel.font = self.nameLabel.font = self.careerLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = self.careerLabel.textColor = kColorGray154;
        self.indexLabel.textColor = GreenColor;
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = DivisionColor;
        [self.contentView addSubview:self.sepaView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nextImage.frame = CGRectMake(self.contentView.width - 9 - mainSpacing, 0, 9, 16);
    self.nextImage.centerY = self.contentView.height * 0.5;
    
    self.indexLabel.frame = CGRectMake(mainSpacing, 0, 20, self.contentView.height);
    
    self.sepaView.frame = CGRectMake(0, self.contentView.height - 0.5, self.contentView.width, 0.5);
    
    self.careerLabel.frame = CGRectMake(self.nextImage.x - 100 - mainSpacing, 0, 100, self.contentView.height);
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.indexLabel.frame) + mainSpacing, 0, self.careerLabel.x - CGRectGetMaxX(self.indexLabel.frame) - 2 * mainSpacing, self.contentView.height);
}

- (void)setModel:(MineCareerModel *)model
{
    _model = model;
    
    self.indexLabel.text = model.index;
    self.careerLabel.text = [NSString stringWithFormat:@"%@积分",model.score];
    self.nameLabel.text = model.nickname;
}

@end
