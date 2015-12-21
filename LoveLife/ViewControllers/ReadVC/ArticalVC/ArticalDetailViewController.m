//
//  ArticalDetailViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/16.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ArticalDetailViewController.h"

@interface ArticalDetailViewController ()
{
    UIWebView * _webView;
}

@end

@implementation ArticalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self makeUI];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"详情";
    [self setLeftButtonSelector:@selector(leftButtonClick)];
    [self setRightButtonSelector:@selector(rightButtonClick)];
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
}

#pragma mark - 创建UI
-(void)makeUI
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.stringUrl]]]];
    [self.view addSubview:_webView];
}

#pragma mark - 按钮响应函数
//返回
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
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
