//
//  RemindTextField.m
//  MoveSchool
//
//  Created by edz on 2017/4/20.
//
//

#import "RemindTextField.h"

@interface RemindTextField()

@property(assign, nonatomic) BOOL isRemiding;

@property(copy, nonatomic) NSString *tmpText;

@property(assign, nonatomic) UIColor *tmpTextColor;

@property(assign, nonatomic) BOOL tmpSecureTextEntry;

@end

@implementation RemindTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tmpTextColor = [UIColor whiteColor];
    }
    return self;
}

- (void) remind :(NSString *) msg
{
    if (self.isRemiding) {
        return;
    }
    
    self.isRemiding = YES;
    self.enabled = false;
    self.tmpText = self.text;
    self.tmpTextColor = self.textColor;
    self.textColor = [UIColor orangeColor];
    self.text = msg;
    self.tmpSecureTextEntry = self.secureTextEntry;
    if (self.tmpSecureTextEntry) {
        self.secureTextEntry = false;
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(remindFinish) userInfo:nil repeats:NO];
}

- (void) remindFinish
{
    if (self.tmpSecureTextEntry) {
        self.secureTextEntry = true;
    }
    self.text = self.tmpText;
    self.textColor = self.tmpTextColor;
    self.enabled = YES;
    self.isRemiding = NO;
}

@end
