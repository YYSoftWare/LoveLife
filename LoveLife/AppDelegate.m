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

@interface AppDelegate ()
//引导页
@property (nonatomic,strong)GuidePageView * guideView;

@property(nonatomic,strong) MyTabBarViewController * myTabBar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.myTabBar = [[MyTabBarViewController alloc]init];
    self.window.rootViewController = self.myTabBar;
    
    //引导页
    [self createGuidePage];
    
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

- (void)beginExperience:(UIButton *)sender
{
    [self.guideView removeFromSuperview];
    [self checkNetWorkState];
}

#pragma mark - 检测网络状态
-(void)checkNetWorkState
{
    
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
