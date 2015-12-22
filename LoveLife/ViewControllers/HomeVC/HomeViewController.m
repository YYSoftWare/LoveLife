
//
//  HomeViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "HomeViewController.h"
#import "ZCZBarViewController.h"
#import "ZLSwipeableView.h"
#import "HomeDetaiViewController.h"

@interface HomeViewController ()<ZLSwipeableViewDataSource,ZLSwipeableViewDelegate>
{
    ZLSwipeableView * _swipeView;
    
    //背景
    UIImageView * _bgImageView;
    
    int _index;
}
//数据源
@property(nonatomic,strong) NSMutableArray * dataArray;

//活动指示器
@property(nonatomic,strong) MBProgressHUD * hud;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createBgImageView];
    //[self loadData];
}

#pragma mark -  请求数据
-(void)loadData
{
    [self.hud show:YES];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:HOMEURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.dataArray = responseObject[@"data"][@"topic"];
        [self.hud hide:YES];
        [self createSwipeView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 创建背景图片

-(void)createBgImageView
{
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 24, SCREEN_W - 20, SCREEN_H - 88 - 49)];
    [_bgImageView setImage:[UIImage imageNamed:@"suite5_heartbeat_background"]];
    [self.view addSubview:_bgImageView];
    
    //创建活动指示器
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.labelText = @"正在加载...";
    self.hud.activityIndicatorColor = [UIColor whiteColor];
    self.hud.color = [UIColor colorWithWhite:0 alpha:0.2];
    [self.view addSubview:self.hud];
}

#pragma mark - 创建tableView
-(void)createSwipeView
{
    _swipeView = [[ZLSwipeableView alloc]initWithFrame:CGRectMake(10, _bgImageView.frame.origin.y + 30, SCREEN_W - 20, SCREEN_H - 88 - 49)];
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
    [self.view addSubview:_swipeView];
}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
           didSwipeUp:(UIView *)view
{
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeDown:(UIView *)view
{
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeLeft:(UIView *)view
{
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
        didSwipeRight:(UIView *)view
{
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view
{
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location
{
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation
{
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location
{
    
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView
{
    if (_index < self.dataArray.count)
    {
        //取值
        NSDictionary * dic = self.dataArray[_index];
        
        //背景
        UIView * viewShow=[[UIView alloc]init];
        viewShow.userInteractionEnabled = YES;
        viewShow.frame = CGRectMake(10,10, SCREEN_W - 20, SCREEN_H - 88 - 49);
        //添加点击手势
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [viewShow addGestureRecognizer:tapGesture];
        
        //大图
        UIImageView * mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, viewShow.frame.size.width, viewShow.frame.size.height - 60) imageName:nil];
        [viewShow addSubview:mainImageView];
        //special_palcehold
        [mainImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
        //标题
        UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, mainImageView.frame.size.height + 10, mainImageView.frame.size.width - 20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:20]];
        [viewShow addSubview:titleLabel];
        titleLabel.text = dic[@"tags"];
        //描述
        UILabel * detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, titleLabel.frame.size.height + titleLabel.frame.origin.y + 15, titleLabel.frame.size.width, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16]];
        detailLabel.numberOfLines = 0;
        detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [viewShow addSubview:detailLabel];
        detailLabel.text = dic[@"title"];
        
        _index ++;
        return viewShow;
    }
    return nil;
}

#pragma mark - 点击手势
-(void)tapGesture:(UITapGestureRecognizer *)gesture
{
    HomeDetaiViewController * vc = [[HomeDetaiViewController alloc]init];
    vc.stringUrl = self.dataArray[_index][@"id"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置导航

-(void)settingNav
{
    self.titleLabel.text = @"爱生活";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function.png"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
    
    //响应方法
    [self setLeftButtonSelector:@selector(leftButtonClick)];
    [self setRightButtonSelector:@selector(rightButtonClick)];
}

#pragma mark - 按钮响应方法
-(void)leftButtonClick
{
    
}

-(void)rightButtonClick
{
    ZCZBarViewController * ZBar = [[ZCZBarViewController alloc]initWithIsQRCode:NO Block:^(NSString * resultStr, BOOL isSucceed)
    {
        NSLog(@"%@",resultStr);
    }];
    
    [self presentViewController:ZBar animated:YES completion:nil];
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
