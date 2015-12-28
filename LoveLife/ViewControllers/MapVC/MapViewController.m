//
//  MapViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/28.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()
{
    MKMapView * _mapView;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMapView];
}

-(void)createMapView
{
    //创建地图
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    
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
