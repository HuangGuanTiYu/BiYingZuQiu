//
//  VideoCell.h
//  MoveSchool
//
//  Created by edz on 2018/1/6.
//

#import <UIKit/UIKit.h>
@class VideoModel, VideoCell;

@protocol VideoCellDelegate <NSObject>

- (void) deleteVideo : (VideoCell *) cell;

- (void) reUploadVideo : (VideoCell *) cell;

@end


@interface VideoCell : UITableViewCell

//图片
@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) VideoModel *model;

@property (nonatomic, weak) id<VideoCellDelegate> videoCellDelegate;

@end
