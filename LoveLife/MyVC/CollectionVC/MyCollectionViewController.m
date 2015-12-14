//
//  MyCollectionViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/11.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"我的喜欢";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor.png"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    
    [self setLeftButtonSelector:@selector(leftButtonClick)];
    [self setRightButtonSelector:@selector(rightButtonClick)];
}

#pragma mark - 按钮响应事件
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//删除
-(void)rightButtonClick
{
    
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
