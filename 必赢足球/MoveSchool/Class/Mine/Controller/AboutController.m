//
//  AboutController.m
//  XiuMei
//
//  Created by edz on 2017/12/2.
//  Copyright © 2017年 xiuMie. All rights reserved.
//

#import "AboutController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 84, 106, 106)];
    logoImage.centerX = self.view.width * 0.5;
    logoImage.image = [UIImage imageNamed:@"AppIcon"];
    [self.view addSubview:logoImage];
    
    self.title = @"关于我们";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImage.frame) + 10, self.view.width, 30)];
    label.text = @"必赢足球";
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

}

- (void) back
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
