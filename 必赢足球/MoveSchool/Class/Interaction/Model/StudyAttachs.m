//
//  StudyAttachs.m
//  MoveSchool
//
//  Created by edz on 2017/5/8.
//
//

#import "StudyAttachs.h"
#import "MJExtension.h"

@implementation StudyAttachs

MJCodingImplementation

- (void)setUrl:(NSString *)url
{

    if (url.length > 0) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HudongImage" ofType:@"plist"];
        NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
        
        int x = arc4random() % 21;

        _url = dicArr[x];
    }
}

@end
