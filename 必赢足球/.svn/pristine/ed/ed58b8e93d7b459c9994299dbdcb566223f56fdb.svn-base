//
//  CourseStudyAdsCell.m
//  MoveSchool
//
//  Created by edz on 2017/6/3.
//
//

#import "CourseStudyAdsCell.h"
#import "CourseAdModel.h"
#import "UIImageView+WebCache.h"

@interface CourseStudyAdsCell()

@property(nonatomic, strong) UIImageView *picView;

@end

@implementation CourseStudyAdsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.picView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.picView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.picView.frame = self.contentView.bounds;
}

- (void)setAdModel:(CourseAdModel *)adModel
{
    _adModel = adModel;
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:adModel.pic] placeholderImage:[UIImage imageNamed:@""]];
}

@end
