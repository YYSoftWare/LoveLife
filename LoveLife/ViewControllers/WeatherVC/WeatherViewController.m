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
    UILabel * _timeLabel;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
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
    
    //发布时间
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, SCREEN_H + 64 - 30, SCREEN_W - 20, 20) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_timeLabel];
    
    //风向和风级
    _windPowerLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _weatherLabel.frame.size.height + _weatherLabel.frame.origin.y + 100 , SCREEN_W, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:25]];
    _windPowerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_windPowerLabel];
    
    //湿度
    _humidityLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _windPowerLabel.frame.size.height + _windPowerLabel.frame.origin.y + 70, SCREEN_W, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:25]];
    _humidityLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_humidityLabel];
    
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
    
    //构造请求对象，配置查询参数
    AMapWeatherSearchRequest * weatherRequest = [[AMapWeatherSearchRequest alloc]init];
    //设置城市
    weatherRequest.city = @"北京";
    //设置天气类型，为实时天气还是预报天气
    weatherRequest.type = AMapWeatherTypeLive;
    
    //发起行政区域规划
    [_search AMapWeatherSearch:weatherRequest];
}

//实现天气查询的回调函数
-(void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response
{
    //如果是实时天气
    if (request.type == AMapWeatherTypeLive)
    {
        if (response.lives.count == 0) {
            return;
        }
        
        //查找各项参数
        for (AMapLocalWeatherLive  * live in response.lives) {
            //获取天气各项指标,刷新界面
            _cityLabel.text = live.city;
            _temperatureLabel.text = [NSString stringWithFormat:@"%@℃",live.temperature];
            _weatherLabel.text = live.weather;
            _timeLabel.text = [NSString stringWithFormat:@"数据更新时间：%@",live.reportTime];
            _windPowerLabel.text = [NSString stringWithFormat:@"%@风：%@级",live.windDirection,live.windPower];
            _humidityLabel.text = [NSString stringWithFormat:@"湿度:%@%%",live.humidity];
            
            //根据天气情况设置图片
            if ([live.weather isEqualToString:@"晴"])
            {
                //晴天
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qingtian.jpg"]];
            }
            else if ([live.weather isEqualToString:@""])
            {
                //阴天
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yintian.jpg"]];
            }
            else if ([live.weather isEqualToString:@""])
            {
                //雪天
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xuetian.jpg"]];
            }
            else
            {
                //雨天
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yutian.jpg"]];
            }
        }
    }
    //如果是预报天气
    else
    {
        if (response.lives.count == 0) {
            return;
        }
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
