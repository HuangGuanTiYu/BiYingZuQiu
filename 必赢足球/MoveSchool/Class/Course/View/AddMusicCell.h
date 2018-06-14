//
//  AddMusicCell.h
//  MoveSchool
//
//  Created by edz on 2017/12/16.
//
//

#import <UIKit/UIKit.h>
@class AddMusicCell;

@protocol AddMusicCellDelegate <NSObject>

- (void) addMusic : (AddMusicCell *) cell;

@end

@interface AddMusicCell : UITableViewCell

@property (nonatomic, weak) id<AddMusicCellDelegate> addMusicCellDelegate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *selectedName;


@end
