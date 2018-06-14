//
//  AddMusicController.h
//  MoveSchool
//
//  Created by edz on 2017/12/16.
//
//

#import <UIKit/UIKit.h>

@protocol AddMusicControllerDelgate <NSObject>

- (void) addMusic : (NSString *) filePath name : (NSString *) name;

@end

@interface AddMusicController : UIViewController

@property (nonatomic, weak) id<AddMusicControllerDelgate> addMusicControllerDelgate;

@property (nonatomic, copy) NSString *selectedName;

@end
