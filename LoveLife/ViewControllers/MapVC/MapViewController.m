//
//  MapViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/28.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "MapViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>

@interface MapViewController ()<AMapSearchDelegate,MAMapViewDelegate>
{
    AMapSearchAPI * _search;
    MAMapView * _mapView;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //地图
    [self createMapView];
    //搜索
    [self createSearch];
    [self createUI];
}

#pragma mark - 创建地图
-(void)createMapView
{
    //设置地图key
    [MAMapServices sharedServices].apiKey = @"ca14c615c81bd5a2e390368a62eca0ba";
    
    //创建地图view
    _mapView = [[MAMapView alloc]initWithFrame:self.view.frame];
    //设置代理
    _mapView.delegate = self;
    //显示交通状况
    _mapView.showTraffic = YES;
    //显示定位
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
}

#pragma mark - 创建POI搜索
-(void)createSearch
{
    //配置用户key
    [AMapSearchServices sharedServices].apiKey = @"ca14c615c81bd5a2e390368a62eca0ba";
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc]init];
    //设置代理
    _search.delegate = self;
    
    //类型一：POI检索
    //构造搜索类，AMapPOIAroundSearchRequest搜索周边，AMapPOIKeywordsSearchRequest搜索关键字AMapPOIPolygonSearchRequest搜索多边形，配置周边请求参数
    AMapPOIAroundSearchRequest * poiSearchRequest = [[AMapPOIAroundSearchRequest alloc]init];
    //设置经纬度
    poiSearchRequest.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    //设置查询关键字
    poiSearchRequest.keywords = @"方恒";
    //设置搜索类型
    poiSearchRequest.types = @"餐饮服务|购物服务";
    //设置排序规则，默认为1，表示综合排序，0表示距离排序
    poiSearchRequest.sortrule = 0;
    //是否返回扩展信息，默认不返回
    poiSearchRequest.requireExtension = YES;
    //发起周边搜索
    [_search AMapPOIAroundSearch:poiSearchRequest];
    
    //类型二：路径规划查询
    //构造路径规划对象，配置路径规划请求参数
    AMapDrivingRouteSearchRequest * driveSearchRequest = [[AMapDrivingRouteSearchRequest alloc]init];
    //设置起点
    driveSearchRequest.origin = [AMapGeoPoint locationWithLatitude:39.994949 longitude:116.447265];
    //设置终点
    driveSearchRequest.destination = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    //设置驾车导航策略，默认速度优先
    driveSearchRequest.strategy = 1;//费用优先
    //是否返回扩展信息
    driveSearchRequest.requireExtension = YES;
    //发起路径规划
    [_search AMapDrivingRouteSearch:driveSearchRequest];
    
    //类型三：正向地理编码
    //构造请求对象，address为必选项，city是可选项
    AMapGeocodeSearchRequest * codeSearchRequest = [[AMapGeocodeSearchRequest alloc]init];
    //设置address
    codeSearchRequest.address = @"天安门";
    //发起正向地理编码
    [_search AMapGeocodeSearch:codeSearchRequest];
    
    //类型四：逆向地理编码
    //构造请求对象
    AMapReGeocodeSearchRequest * reCodeSearchRequest = [[AMapReGeocodeSearchRequest alloc]init];
    //设置位置
    reCodeSearchRequest.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    //设置查询半径。默认为1000；
    reCodeSearchRequest.radius = 500;
    //是否返回扩展信息
    reCodeSearchRequest.requireExtension = YES;
    
    //类型五：公交查询
    //1.公交站查询
    //构造请求对象
    AMapBusStopSearchRequest * busStopSearchRequest = [[AMapBusStopSearchRequest alloc]init];
    //设置关键字
    busStopSearchRequest.keywords = @"天安门";
    //设置城市
    busStopSearchRequest.city = @"北京";
    //发起公交站查询
    [_search AMapBusStopSearch:busStopSearchRequest];
    
    //2.公交路线查询
    //构建请求类
    AMapBusLineNameSearchRequest * busLineNameSearchRequest = [[AMapBusLineNameSearchRequest alloc]init];
    //设置关键字
    busStopSearchRequest.keywords = @"专66";
    //设置城市
    busLineNameSearchRequest.city = @"北京";
    //返回扩展信息
    busLineNameSearchRequest.requireExtension = YES;
    //发起公交线路查询
    [_search AMapBusLineNameSearch:busLineNameSearchRequest];
}

#pragma mark - 实现POI搜索对应的回调函数
//POI搜索
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0) {
        return;
    }
    
    //通过AMapPOISearchResponse对象处理搜索结果
    //返回的POI数目
    NSString * strCount = [NSString stringWithFormat:@"%ld",response.count];
    //返回的关键字建议列表和城市建议列表
    NSString * strSuggestion = [NSString stringWithFormat:@"%@",response.suggestion];
    NSString * strPoi;
    //遍历POI数组
    for (AMapPOI * poi in response.pois) {
        strPoi = [NSString stringWithFormat:@"poi:%@",poi.description];
    }
    
    //总得结果
    NSString * result = [NSString stringWithFormat:@"%@ \n %@ \n %@",strCount,strSuggestion,strPoi];
    NSLog(@"POI搜索~~~~~~%@",result);
    NSLog(@"%@~~~~%@",response.suggestion.cities,response.suggestion.keywords);
}

#pragma mark - 实现路径规划对应的回调函数
-(void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil) {
        return;
    }
    
    NSString * routeStr = [NSString stringWithFormat:@"路径规划~~~%@",response.route];
    NSLog(@"%@",routeStr);
}

#pragma mark - 正向地理编码的回调函数
-(void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count) {
        return;
    }
    
    //处理结果
    NSString * strCount = [NSString stringWithFormat:@"%ld",response.count];
    NSString * strGeocodes;
    for (AMapTip * tip in response.geocodes) {
        strGeocodes = [NSString stringWithFormat:@"%@",tip.description];
    }
    
    NSString * result = [NSString stringWithFormat:@"%@~~~~%@",strCount,strGeocodes];
    NSLog(@"正向地理编码结果~~~%@",result);
}

#pragma mark - 实现逆地理编码的回调函数
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil) {
        //处理逆地理编码结果
        NSString * result = [NSString stringWithFormat:@"%@",response.regeocode];
        NSLog(@"逆地理编码结果~~~%@",result);
    }
}

#pragma mark - 实现公交站查询的回调函数
-(void)onBusStopSearchDone:(AMapBusStopSearchRequest*)request response:(AMapBusStopSearchResponse *)response
{
    if(response.busstops.count == 0)
    {
        return;
    }
    
    //通过AMapBusStopSearchResponse对象处理搜索结果
    NSString * strCount = [NSString stringWithFormat:@"%ld",response.count];
    NSString *strStop = @"";
    for (AMapBusStop * busStop in response.busstops)
    {
        strStop = [NSString stringWithFormat:@"%@",busStop.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@%@", strCount,strStop];
    NSLog(@"公交站查询路线: %@", result);
}

#pragma mark - 实现公交线路查询的回调函数
-(void)onBusLineSearchDone:(AMapBusLineBaseSearchRequest*)request response:(AMapBusLineSearchResponse *)response
{
    if(response.buslines.count == 0)
    {
        return;
    }
    
    //通过AMapBusLineSearchResponse对象处理搜索结果
    NSString * strCount = [NSString stringWithFormat:@"%ld",response.count];
    NSString * strLine = @"";
    for (AMapBusLine * busLine in response.buslines)
    {
        strLine = [NSString stringWithFormat:@"%@",busLine.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@%@", strCount,strLine];
    NSLog(@"公交线路查询结果: %@", result);
}


#pragma mark - 创建UI
-(void)createUI
{
    //创建返回按钮
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 20, 30, 30) title:nil titleColor:nil imageName:@"iconfont-back" backgroundImageName:nil target:self selector:@selector(backButtonClick)];
    [self.view addSubview:backButton];
}

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
