
//
//  RootViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRootNav];
}

#pragma mark - 设置导航统一属性

-(void)createRootNav
{
    //设置导航不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航颜色
    self.navigationController.navigationBar.barTintColor = RGB(255,156,187,1);
    //修改状态栏的颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //左按钮
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, 44, 44);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];

    //右按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 44, 44);
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
    //标题
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.titleLabel;
}
//左按钮响应事件
-(void)setLeftButtonSelector:(SEL)leftSelector
{
    [self.leftButton addTarget:self action:leftSelector forControlEvents:UIControlEventTouchUpInside];
}
//右按钮响应事件
-(void)setRightButtonSelector:(SEL)rightSelector
{
    [self.rightButton addTarget:self action:rightSelector forControlEvents:UIControlEventTouchUpInside];
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
