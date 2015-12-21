
//
//  MyTabBarViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "HomeViewController.h"
#import "ReadViewController.h"
#import "FoodViewController.h"
#import "HealthyViewController.h"
#import "MyViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createControllers];
    [self createTabBar];
}

#pragma mark - 创建viewControllers
-(void)createControllers
{
    //首页
    HomeViewController * homeVC = [[HomeViewController alloc]init];
    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    //阅读
    ReadViewController * readVC = [[ReadViewController alloc]init];
    UINavigationController * readNav = [[UINavigationController alloc]initWithRootViewController:readVC];
    
    //美食
    FoodViewController * foodVC = [[FoodViewController alloc]init];
    UINavigationController * foodNav = [[UINavigationController alloc]initWithRootViewController:foodVC];
    
    //健康
    HealthyViewController * healthyVC = [[HealthyViewController alloc]init];
    UINavigationController * healthyNav = [[UINavigationController alloc]initWithRootViewController:healthyVC];
    
    //我的
    MyViewController * myVC = [[MyViewController alloc]init];
    UINavigationController * myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    
    //将导航页面添加到数组中
    NSArray * ViewControllersArray = @[homeNav,readNav,foodNav,healthyNav,myNav];
    self.viewControllers = ViewControllersArray;
}

#pragma mark - 创建tabBar

-(void)createTabBar
{
    //未选中的图片
    NSArray * unselectedImageArray = @[@"ic_tab_home_normal",@"ic_tab_select_normal@2x.png",  @"iconfont-iconfontmeishi",@"health",@"ic_tab_profile_normal_female@2x.png"];
    //选中的图片
    NSArray * selectedImageArray = @[@"ic_tab_home_selected.png",@"ic_tab_select_selected@2x.png", @"iconfont-iconfontmeishi-2", @"health2",@"ic_tab_profile_selected_female@2x.png"];
    //标题
    NSArray * titleArray = @[@"首页",@"阅读",@"美食",@"娱乐",@"我的"];
    
    for(int i = 0;i < self.tabBar.items.count;i ++)
    {
        //设置未选中的图片并对图片做处理，使用图片原尺寸
        UIImage * unselectedImage = [UIImage imageNamed:unselectedImageArray[i]];
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //同样的，处理选中的图片
        UIImage * selectedImage = [UIImage imageNamed:selectedImageArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //获取tabBarItem
        UITabBarItem * item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
    }
    
    //设置选中时候的标题颜色,appearance属性全局修改某个属性
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
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
