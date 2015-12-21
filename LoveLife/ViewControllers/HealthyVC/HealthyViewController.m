
//
//  HealthyViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "HealthyViewController.h"

@interface HealthyViewController ()

@end

@implementation HealthyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
}

-(void)settingNav
{
    self.leftButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
