//
//  LoginViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocial.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"登录";
    [self setLeftButtonSelector:@selector(leftButtonClick)];
}

-(void)createUI
{
    NSArray * logoArray = @[@"qq",@"sina",@"weixin.jpg"];
    for (int i = 0; i < logoArray.count; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(70 + i * 80, 50, 40, 40);
        [button setImage:[UIImage imageNamed:logoArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
        [self.view addSubview:button];
    }
}

#pragma mark - 按钮响应函数
-(void)loginButtonClick:(UIButton *)button
{
    switch (button.tag - 10)
    {
        case 0:
        {
            //qq登录
            //确定登录的平台
            UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            //点击响应方法
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
                //判断回调成功之后获取用户信息
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity * account = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                    
                    NSLog(@"username%@ iconUrl%@ usid%@ token%@",account.userName,account.iconURL,account.usid,account.accessToken);
                    //保存昵称和头像
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    [user setObject:account.userName forKey:@"userName"];
                    [user setObject:account.iconURL forKey:@"iconURL"];
                   [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }
            break;
        case 1:
        {
            //新浪微博登录
            //确定登录的平台
            UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            //点击响应方法
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
                //判断回调成功之后获取用户信息
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity * account = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    NSLog(@"username%@ iconUrl%@ usid%@ token%@",account.userName,account.iconURL,account.usid,account.accessToken);
                    //保存昵称和头像
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    [user setObject:account.userName forKey:@"userName"];
                    [user setObject:account.iconURL forKey:@"iconURL"];
                   [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }
            break;
        case 2:
        {
            //微信登录
            //确定登录的平台
            UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            //点击响应方法
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
                //判断回调成功之后获取用户信息
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity * account = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
                    
                    NSLog(@"username%@ iconUrl%@ usid%@ token%@",account.userName,account.iconURL,account.usid,account.accessToken);
                    //保存昵称和头像
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    [user setObject:account.userName forKey:@"userName"];
                    [user setObject:account.iconURL forKey:@"iconURL"];
                    [self.navigationController popViewControllerAnimated:YES];
                  }
            });
        }
            break;
            
        default:
            break;
    }
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
