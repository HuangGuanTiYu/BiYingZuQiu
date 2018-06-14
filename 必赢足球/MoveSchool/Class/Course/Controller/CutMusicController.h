//
//  CutMusicController.h
//  MoveSchool
//
//  Created by edz on 2017/12/22.
//
//

#import <UIKit/UIKit.h>
#import "AEAudioFilePlayer.h"

@protocol CutMusicControllerDelete <NSObject>

- (void) cutMusicSuccess : (NSString *) path currentTime : (int) currentTime;

@end

@interface CutMusicController : UIViewController

@property (nonatomic, copy) NSString *videoLength;

@property (nonatomic, copy) NSString *videoPath;

@property (nonatomic, strong) AEAudioController *audioController;

@property (nonatomic, weak) id<CutMusicControllerDelete> cutMusicControllerDelete;


@end
