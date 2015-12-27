//
//  WeatherViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherModel.h"
#import "WeatherViewCell.h"
#import "ChooseProvinceViewController.h"
@interface WeatherViewController ()<ChooseProvinceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    WeatherModel *_model;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSString *_cityName;
}
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
     _cityName = @"北京";
    [self createNavBar];
    [self getTheDataUseAF];
    [self createTableView];
    [self reloadLocalData];
    
}

//读取本地数据
- (void)reloadLocalData
{
    NSData *data = [self readLocal];
    if (data)
    {
        [self analyzeTheData:data];
        
    }
}

#pragma maek - 创建tableView
- (void)createTableView
{
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceVertical = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:NSClassFromString(@"WeatherViewCell") forCellReuseIdentifier:@"110"];
    [self.view addSubview:_tableView];
}

#pragma mark - 设置导航
- (void)createNavBar
{
    UIBarButtonItem *chooseCity = [[UIBarButtonItem alloc]initWithTitle:@"切换城市" style:UIBarButtonItemStyleDone target:self action:@selector(goChooseCity)];
    self.navigationItem.rightBarButtonItem = chooseCity;
}

#pragma mark - 读取网络数据
- (void)getTheDataUseAF
{
    [_dataArr removeAllObjects];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *urlStr = [NSString stringWithFormat:WEATHER,_cityName];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        [self writeToLocal:responseObject];
        [self analyzeTheData:responseObject];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
}

#pragma maek - 解析数据
- (void)analyzeTheData:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _model = [[WeatherModel alloc]init];
    _model.date = dic[@"date"];
    _model.results = dic[@"results"];
    _model.weather_data = dic[@"results"][0][@"weather_data"];
    [_dataArr addObject:_model];
    [_tableView reloadData];
   
}

#pragma mark tableViewDelegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height-64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"110" forIndexPath:indexPath];
    if (!cell) {
        cell = [[WeatherViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"110"];
    }
    WeatherModel *model = _dataArr[indexPath.row];
    [cell relyoutUI:model];
    
    return cell;
}

#pragma mark - 选择城市
- (void)goChooseCity
{
    ChooseProvinceViewController *chooseVC = [[ChooseProvinceViewController alloc]init];
    chooseVC.delegate = self;
    [self.navigationController pushViewController:chooseVC animated:YES];
}

//返回城市名称
- (void)backTheCityName:(NSString *)city{
    _cityName = city;
    [self getTheDataUseAF];
}

#pragma mark - 做数据的本地化
- (void)writeToLocal:(NSData *)data
{
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/huancun/%@.txt",NSStringFromClass([self class])];
    
    [data writeToFile:path atomically:YES];
}

#pragma mark - 从本地读取数据
- (NSData *)readLocal
{
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/huancun/%@.txt",NSStringFromClass([self class])];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        return [NSData dataWithContentsOfFile:path];
    }
    return nil;
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
