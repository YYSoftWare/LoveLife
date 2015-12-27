//
//  AppDelegate.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "GuidePageView.h"
//抽屉
#import "FLSideSlipViewController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"

#import "UMSocial.h"
//支持qq
#import "UMSocialQQHandler.h"
//支持微信
#import "UMSocialWechatHandler.h"
//支持新浪微博的
#import "UMSocialSinaHandler.h"

@interface AppDelegate ()
//引导页
@property (nonatomic,strong)GuidePageView * guideView;

@property(nonatomic,strong) MyTabBarViewController * myTabBar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化页面
    //主页面
    self.myTabBar = [[MyTabBarViewController alloc]init];
    //左页面
    LeftViewController * leftVC = [[LeftViewController alloc]init];

    MMDrawerController * drawerVC = [[MMDrawerController alloc]initWithCenterViewController:self.myTabBar leftDrawerViewController:leftVC];
    //设置打开和关闭的手势
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    //设置左控制器显示的宽度
    drawerVC.maximumLeftDrawerWidth = SCREEN_W - 100;
    
    self.window.rootViewController = drawerVC;
    
    //引导页
    [self createGuidePage];
    //测试网络状态
    //[self checkNetWorkState];
    //注册友盟
    [self addUMShare];
    
    //设置状态栏的颜色为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}

#pragma mark - 创建引导页
-(void)createGuidePage
{
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isRuned"] boolValue])
    {
        NSArray * array = @[@"welcome2.png",
                          @"welcome6.png",
                          @"welcome7.png",
                          @"welcome4.png"];
        //创建引导页视图
        self.guideView = [[GuidePageView alloc]initWithFrame:self.window.bounds namesArray:array];
        [self.myTabBar.view addSubview:self.guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isRuned"];
    }else
    {
        [self checkNetWorkState];
    }
    
    //点击进入首页
    [self.guideView.guideBtn addTarget:self action:@selector(beginExperience:) forControlEvents:UIControlEventTouchUpInside];
}
//跳转进入首页
- (void)beginExperience:(UIButton *)sender
{
    [self.guideView removeFromSuperview];
    [self checkNetWorkState];
}

#pragma mark - 检测网络状态
-(void)checkNetWorkState
{
    //创建一个用于测试的url
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://www.apple.com"]];
    //判断不同的网络状态
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self createAlertView:@"您当前使用的是数据流量"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self createAlertView:@"您当前使用的是Wifi"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [self createAlertView:@"世界上最遥远的距离就是没网"];
                break;
            case AFNetworkReachabilityStatusUnknown:
                [self createAlertView:@"网络状况不明确"];
                break;
                
            default:
                break;
        }
    }];
    
}

//网络提示
-(void)createAlertView:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - 友盟分享和第三方登录
-(void)addUMShare
{
    //设置友盟的appkey
    [UMSocialData setAppKey:APPKEY];
    
    //设置qq的appid，appkey和url
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@" MnGtpPN5AiB6MNvj" url:nil];
    
    //设置微信的appid和appSecret
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    
    //设置新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    //隐藏未安装的微信和qq的客户端
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatTimeline, UMShareToWechatTimeline]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
