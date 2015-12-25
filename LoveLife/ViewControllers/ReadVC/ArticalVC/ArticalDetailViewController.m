//
//  ArticalDetailViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/16.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ArticalDetailViewController.h"
#import "UMSocial.h"
#import "GDDataManager.h"

@interface ArticalDetailViewController ()
{
    UIWebView * _webView;
    //收藏按钮
    UIButton * _collectButton;
}

@end

@implementation ArticalDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    GDDataManager * manager = [GDDataManager shareManager];
    __block BOOL isHas = [manager findDataWithTitle:self.model.title];
    if (isHas) {
        _collectButton.selected = YES;
    }
}

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
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID]]]];
    [self.view addSubview:_webView];
    
    //收藏按钮
    UIButton * collectButton = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_W - 60, 70, 30, 30) title:nil titleColor:nil imageName:@"iconfont-iconfontshoucang" backgroundImageName:nil target:self selector:@selector(collecButtonClick:)];
    [collectButton setImage:[UIImage imageNamed:@"iconfont-iconfontshoucang-2"] forState:UIControlStateSelected];
    [self.view addSubview:collectButton];
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
    UIImage * shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:@"%@%@",self.model.title,[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID]] shareImage:shareImage shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToRenren] delegate:nil];
}

//收藏
-(void)collecButtonClick:(UIButton *)button
{
    button.selected = YES;
    if (button.selected == YES) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        //判断是否收藏过
        GDDataManager * manager = [GDDataManager shareManager];
        __block BOOL isHas = [manager findDataWithTitle:self.model.title];
        
        if (isHas)
        {
            [button setImage:[UIImage imageNamed:@"iconfont-iconfontshoucang"] forState:UIControlStateNormal];
            [manager deleteWith:self.model.title];
        }
        else
        {
            [button setImage:[UIImage imageNamed:@"iconfont-iconfontshoucang-2"] forState:UIControlStateSelected];
            NSDictionary * dict = @{@"id":self.model.dataID,@"title":self.model.title,@"pic":self.model.pic,@"createtime":self.model.createtime,@"author":self.model.author};
            [manager saveDic:dict];
        }
        isHas = !isHas;
        
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已取消收藏" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
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
