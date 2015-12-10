
//
//  HomeViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "HomeViewController.h"
#import "ZCZBarViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
}

#pragma mark - 设置导航

-(void)settingNav
{
    self.titleLabel.text = @"爱生活";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function.png"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fonticonerweima02"] forState:UIControlStateNormal];
    
    //响应方法
    [self setLeftButtonSelector:@selector(leftButtonClick)];
    [self setRightButtonSelector:@selector(rightButtonClick)];
}

#pragma mark - 按钮响应方法
-(void)leftButtonClick
{
    
}

-(void)rightButtonClick
{
    ZCZBarViewController * ZBar = [[ZCZBarViewController alloc]initWithIsQRCode:NO Block:^(NSString * resultStr, BOOL isSucceed)
    {
        NSLog(@"%@",resultStr);
    }];
    
    [self presentViewController:ZBar animated:YES completion:nil];
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
