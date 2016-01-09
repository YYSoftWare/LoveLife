//
//  WeatherViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "WeatherViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface WeatherViewController ()<AMapSearchDelegate>
{
    AMapSearchAPI * _search;
    
    //控件
    UILabel * _cityLabel;
    UILabel * _weatherLabel;
    UILabel * _temperatureLabel;
    UILabel * _windDirectionLabel;
    UILabel * _windPowerLabel;
    UILabel * _humidityLabel;
    UILabel * _reportTimeLabel;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weatherImage.jpg"]];
    [self createUI];
    [self createWeatherSearch];
}

#pragma mark - 创建UI
-(void)createUI
{
    //返回按钮
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 20, 30, 30) title:nil titleColor:nil imageName:@"iconfont-back" backgroundImageName:nil target:self selector:@selector(backButtonClick)];
    [self.view addSubview:backButton];
    
    //城市名
    _cityLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 50, SCREEN_W, 50) text:nil textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:30]];
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_cityLabel];
    
    //温度
    _temperatureLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _cityLabel.frame.size.height + _cityLabel.frame.origin.y + 50, SCREEN_W / 2, 50) text:nil textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:60]];
    _temperatureLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_temperatureLabel];
    
    //天气现象
    _weatherLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W / 2 + 30, _temperatureLabel.frame.origin.y, SCREEN_W / 2, 50) text:nil textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:60]];
    _weatherLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_weatherLabel];
}

#pragma mark - 天气查询
-(void)createWeatherSearch
{
    //配置用户key
    [AMapSearchServices sharedServices].apiKey = @"ca14c615c81bd5a2e390368a62eca0ba";
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc]init];
    //设置代理
    _search.delegate = self;
    
    //构造对象，配置查询参数
    AMapWeatherSearchRequest * weatherRequest = [[AMapWeatherSearchRequest alloc]init];
    //设置城市
    weatherRequest.city = @"北京";
    //设置天气类型，为实时天气还是预报天气
    weatherRequest.type = AMapWeatherTypeLive;
    
    //发起行政区域规划
    [_search AMapWeatherSearch:weatherRequest];
}

//实时天气查询的回调函数
-(void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response
{
    //如果是实时天气
    if (request.type == AMapWeatherTypeLive)
    {
        if (response.lives.count == 0) {
            return;
        }
        
        for (AMapLocalWeatherLive  * live in response.lives) {
            //获取天气各项指标,刷新界面
            _cityLabel.text = live.city;
            _temperatureLabel.text = [NSString stringWithFormat:@"%@℃",live.temperature];
            _weatherLabel.text = live.weather;
        }
    }
    //如果是预报天气
    else
    {
        
    }
}

#pragma mark - 返回按钮
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
