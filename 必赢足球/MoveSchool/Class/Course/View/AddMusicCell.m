//
//  AddMusicCell.m
//  MoveSchool
//
//  Created by edz on 2017/12/16.
//
//

#import "AddMusicCell.h"

@interface AddMusicCell()

@property (nonatomic, strong) UIView *bjView;

@property (nonatomic, strong) UIView *sepaView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation AddMusicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        self.bjView = [[UIView alloc] init];
        [self.contentView addSubview:self.bjView];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = ViewBackColor;
        [self.contentView addSubview:self.sepaView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = MainTextColor;
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.bjView addSubview:self.titleLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.text = @"时长 00:16";
        self.timeLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.timeLabel.textColor = AuxiliaryColor;
        [self.bjView addSubview:self.timeLabel];
        
        self.addButton = [[UIButton alloc] init];
        [self.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
        [self.addButton setTitle:@"已添加" forState:UIControlStateSelected];
        [self.addButton setTitleColor:MainColor forState:UIControlStateNormal];
        [self.addButton setTitleColor:AuxiliaryColor forState:UIControlStateSelected];
        self.addButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.addButton.layer.borderColor = MainColor.CGColor;
        self.addButton.layer.borderWidth = 0.5;
        self.addButton.layer.cornerRadius = 2;
        self.addButton.layer.masksToBounds = YES;
        [self.bjView addSubview:self.addButton];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setSelectedName:(NSString *)selectedName
{
    
    _selectedName = selectedName;
    
    if ([selectedName isEqualToString:self.title]) {
        self.addButton.selected = YES;
        self.addButton.layer.borderColor = AuxiliaryColor.CGColor;
    }else
    {
        self.addButton.selected = NO;
        self.addButton.layer.borderColor = MainColor.CGColor;
    }
}

- (void)layoutSubviews
{

    [super layoutSubviews];
    
    self.bjView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height - mainSpacing);
    
    self.sepaView.frame = CGRectMake(0, self.contentView.height - mainSpacing, self.contentView.width, mainSpacing);

    
    self.addButton.frame = CGRectMake(self.contentView.width - 45 - mainSpacing15, 0, 45, 18);
    self.addButton.centerY = self.contentView.height * 0.5;

    self.titleLabel.frame = CGRectMake(mainSpacing15, 0, self.addButton.x - mainSpacing15 * 2, 30);
    [self.titleLabel sizeToFit];
    self.titleLabel.y = 15;
    
    self.timeLabel.frame = CGRectMake(mainSpacing15, 0, self.titleLabel.width, 20);
    [self.timeLabel sizeToFit];
    self.timeLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 5;

}

- (void) addButtonClick
{

    if ([self.addMusicCellDelegate respondsToSelector:@selector(addMusic:)]) {
        [self.addMusicCellDelegate addMusic:self];
    }
}

@end
