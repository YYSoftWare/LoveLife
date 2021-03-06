//
//  AboutViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "AboutViewController.h"
#import "ZCZBarViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
}

#pragma mark - 创建UI
-(void)createUI
{
    //生成二维码
    UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake((SCREEN_W - 200) / 2,150, 200, 200) imageName:nil];
    [ZCZBarViewController createImageWithImageView:imageView String:@"www.baidu.com" Scale:4];
    [self.view addSubview:imageView];
    
    //标题
    UILabel * tipLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, SCREEN_H - 200, SCREEN_W, 25) text:@"扫一扫，关注我们" textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:22]];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"关于";
    [self setLeftButtonSelector:@selector(leftButtonClick)];
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
