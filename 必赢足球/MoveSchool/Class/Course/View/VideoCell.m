//
//  VideoCell.m
//  MoveSchool
//
//  Created by edz on 2018/1/6.
//

#import "VideoCell.h"
#import "VideoModel.h"
#import "TBCityIconFont.h"

@interface VideoCell()

//标题
@property (nonatomic, strong) UILabel *titleLabel;

//时间
@property (nonatomic, strong) UILabel *timeLabel;

//状态
@property (nonatomic, strong) UILabel *stateButton;

//课件ID
@property (nonatomic, copy) NSString *ccid;

@property (nonatomic, strong) UIView *sepaView;

@property (nonatomic, strong) UIButton *timeButton;

@property (nonatomic, strong) UIView *boomView;

@property (nonatomic, strong) UIView *sepaView2;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIButton *uploadButton;

@end

@implementation VideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.headerView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.timeLabel.textColor = RGBColor(143,143,143);
        [self.contentView addSubview:self.timeLabel];
        
        self.stateButton = [[UILabel alloc] init];
        self.stateButton.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.stateButton];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = ViewBackColor;
        [self.contentView addSubview:self.sepaView];
        
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
        self.boomView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.boomView];
        
        self.sepaView2 = [[UIView alloc] init];
        self.sepaView2.backgroundColor = SepaViewColor;
        [self.boomView addSubview:self.sepaView2];
        
        self.deleteButton = [[UIButton alloc] init];
        [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:MainColor forState:UIControlStateNormal];
        [self.boomView addSubview:self.deleteButton];
        
        self.uploadButton = [[UIButton alloc] init];
        [self.uploadButton addTarget:self action:@selector(uploadButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.uploadButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.uploadButton setTitle:@"重新上传" forState:UIControlStateNormal];
        [self.uploadButton setTitleColor:MainColor forState:UIControlStateNormal];
        [self.boomView addSubview:self.uploadButton];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat headerViewH = 125 - mainSpacing * 4;
    self.headerView.frame = CGRectMake(mainSpacing, 0, headerViewH / 9 * 16, headerViewH);
    self.headerView.centerY = 125 * 0.5;
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + mainSpacing, self.headerView.y, self.width - 2 * mainSpacing - CGRectGetMaxX(self.headerView.frame), self.headerView.height * 0.5);
    [self.titleLabel sizeToFit];
    
    self.timeLabel.frame = CGRectMake(self.titleLabel.x, CGRectGetMaxY(self.headerView.frame) - 20, 50, 20);
    [self.timeLabel sizeToFit];
    
    self.stateButton.frame = CGRectMake(0, 0, 0, 20);
    self.stateButton.centerY = self.timeLabel.centerY;
    [self.stateButton sizeToFit];
    self.stateButton.x = self.contentView.width - mainSpacing - self.stateButton.width;
    
    self.sepaView.frame = CGRectMake(0, self.contentView.height - mainSpacing, self.contentView.width, mainSpacing);
    
    self.timeButton.frame = CGRectMake(0, 0, self.headerView.width * 0.6, headerViewH * 0.4);
    self.timeButton.center = self.headerView.center;
    
    self.boomView.frame = CGRectMake(0, self.contentView.height - 44 - mainSpacing, self.contentView.width, 44);
    
    self.sepaView2.frame = CGRectMake(mainSpacing, 0, self.boomView.width - mainSpacing, 0.5);
    
    self.deleteButton.frame = CGRectMake(0, CGRectGetMaxY(self.sepaView2.frame), self.boomView.width * 0.5, 44);
    
    self.uploadButton.frame = CGRectMake(self.boomView.width * 0.5, CGRectGetMaxY(self.sepaView2.frame), self.boomView.width * 0.5, 44);

}

- (void)setModel:(VideoModel *)model
{
    
    _model = model;
    
    self.headerView.image = model.bjImage;
    
    self.titleLabel.text = model.title;
    
    self.timeLabel.text = model.time;
    
    if (model.uploadFaile) {
        self.stateButton.text = @"上传失败";
        self.stateButton.textColor = AuxiliaryColor;
    }else
    {
        self.stateButton.text = @"正在上传";
        self.stateButton.textColor = MainColor;
    }

    [self.timeButton setTitle:model.videoLength forState:UIControlStateNormal];
    
    self.boomView.hidden = !model.uploadFaile;
}

- (void) deleteButtonClick
{
    
    if ([self.videoCellDelegate respondsToSelector:@selector(deleteVideo:)]) {
        [self.videoCellDelegate deleteVideo:self];
    }
}

- (void) uploadButtonClick
{
    if ([self.videoCellDelegate respondsToSelector:@selector(reUploadVideo:)]) {
        [self.videoCellDelegate reUploadVideo:self];
    }
}

@end
