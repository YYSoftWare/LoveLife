//
//  FoodViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "FoodViewController.h"
#import "NBWaterFlowLayout.h"
#import "FoodCollectionViewCell.h"
#import "FoodTitleCollectionViewCell.h"
#import "FoodModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FoodPlayerViewController.h"
#import "FoodDetailViewController.h"

//如果工程是mrc而引入的某些类是arc模式，需要在编译源文件处添加-fobjc-arc标示，相反工程是arc而某些类是mrc模式，则为mrc的类添加-fno-objc-arc标示

@interface FoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout,PlayDelegte>
{
    //指示条
    UIView * _lineView;
    //筛选下拉菜单
    UIView * _menuBgView;
    //分页
    int _page;
    //区分id
    NSString * _dataID;
    
    //标题
    NSString * _titleString;
    
}
//活动指示器
@property(nonatomic,strong) MBProgressHUD * hud;

//按钮数组
@property(nonatomic,strong) NSMutableArray * buttonArray;
//集合视图
@property(nonatomic,strong) UICollectionView * collectionView;
//数据源
@property(nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation FoodViewController

//处理默认选中第一个按钮
-(void)viewWillAppear:(BOOL)animated
{
    for (UIButton * btn in self.buttonArray) {
        if (btn == [self.buttonArray firstObject]) {
            btn.selected = YES;
        }
    }
}

#pragma mark - 初始化数据
-(void)initsomeData
{
    _page = 1;
    _titleString = @"家常菜";
    _dataID = @"1";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initsomeData];
    [self settingNav];
    [self createHeaderView];
    [self createCollectionView];
    [self createRefresh];
    //程序第一次启动时自动刷新
    [_collectionView.header beginRefreshing];
}

#pragma mark - 刷新请求数据
-(void)createRefresh
{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
//下拉刷新
-(void)loadNewData
{
    _page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
}

//上拉加载
-(void)loadMoreData
{
    _page ++;
    [self loadData];
}

-(void)loadData
{
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id": _dataID, @"size": @"20"};
    
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0)
        {
            NSArray * array = responseObject[@"data"][@"data"];
            for (NSDictionary * dic in array)
            {
                FoodModel * model = [[FoodModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
        }
        
        //停止刷新
        [self.hud hide:YES];
        if (_page == 1)
        {
            [_collectionView.header endRefreshing];
        }
        else
        {
            [_collectionView.footer endRefreshing];
        }
        
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 创建网格视图
-(void)createCollectionView
{
    //创建网格布局对象
    NBWaterFlowLayout * flowLayout = [[NBWaterFlowLayout alloc]init];
    //设置网格大小
    flowLayout.itemSize = CGSizeMake((SCREEN_W - 20) / 2, 200);
    //设置列数
    flowLayout.numberOfColumns = 2;
    flowLayout.delegate = self;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H - 40) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerClass:[FoodTitleCollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];
    [_collectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:@"cell2"];
    
    //创建活动指示器
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.labelText = @"正在加载...";
    self.hud.activityIndicatorColor = [UIColor whiteColor];
    self.hud.color = [UIColor colorWithWhite:0 alpha:0.2];
    [self.view addSubview:self.hud];

}

#pragma mark - 实现collectionView的代理方法
//确定item的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count ? self.dataArray.count + 1 : 0;
}
//创建collectionViewCell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        FoodTitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell.titleLabel.text = _titleString;
        
        return cell;
    }
    else
    {
        FoodCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        //设置代理
        cell.delegate = self;
        //赋值
        FoodModel * model = self.dataArray[indexPath.row - 1];
        [cell configUI:model];
        return cell;
    }
}

#pragma mark - 瀑布效果高度
- (CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 && indexPath.row == 0){
        
        return 30;
    }
    
    return 180;
}
//点击传值
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController * detailVC =[[FoodDetailViewController alloc]init];
    
    //传值
    FoodModel * model = self.dataArray[indexPath.row];
    detailVC.dataId = model.dishes_id;
    detailVC.NavTitle = model.title;
    detailVC.videoUrl = model.video;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//设置动画
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的显示动画为3D缩放
    //xy方向缩放的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:1.0f animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }];
}
#pragma mark - 创建头部选择按钮
-(void)createHeaderView
{
    //初始化button数组
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    NSArray * headerButtonArray = @[@"家常菜",@"小炒",@"凉菜",@"烘培"];
    for (int i = 0; i < headerButtonArray.count; i ++) {
        UIButton * headerButton = [FactoryUI createButtonWithFrame:CGRectMake(i * SCREEN_W / 4, 0, SCREEN_W / 4, 40) title:headerButtonArray[i] titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerButtonClick:)];
        [headerButton setTitleColor:RGB(255,156,187,1) forState:UIControlStateSelected];
        headerButton.tag = 10 + i;
        [bgView addSubview:headerButton];
        [self.buttonArray addObject:headerButton];
    }
    
    //指示条
    _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, SCREEN_W / 4, 2)];
    _lineView.backgroundColor = RGB(255,156,187,1);
    [bgView addSubview:_lineView];
    
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"美食";
    self.leftButton.hidden = YES;
    
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-shaixuan"] forState:UIControlStateNormal];
    self.rightButton.hidden = YES;
    [self setRightButtonSelector:@selector(rightButtonClick:)];
}

#pragma mark - 按钮响应函数
-(void)rightButtonClick:(UIButton *)button
{
    
}

-(void)headerButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake((button.tag - 10) * SCREEN_W / 4, 38, SCREEN_W / 4, 2);
    }];
    
    //设置每次只选中一个按钮
    for (UIButton * btn in self.buttonArray) {
        if (btn.selected == YES) {
            btn.selected = NO;
        }
    }
    button.selected = YES;

    //改变标题和id
    _dataID = [NSString stringWithFormat:@"%ld",(button.tag - 10) + 1];
    switch (button.tag - 10) {
        case 0:
        {
            _titleString = @"家常菜";
            [_collectionView.header beginRefreshing];
        }
            break;
        case 1:
        {
            _titleString = @"小炒";
            [_collectionView.header beginRefreshing];
        }
            break;
        case 2:
        {
            _titleString = @"凉菜";
            [_collectionView.header beginRefreshing];
        }
            break;
        case 3:
        {
            _titleString = @"烘培";
            [_collectionView.header beginRefreshing];
        }
            break;
            
        default:
            break;
    }
    
    //刷新界面
    [_collectionView reloadData];
}

#pragma mark - 自定义的代理方法
-(void)deliverModel:(FoodModel *)model
{
    FoodPlayerViewController * playerVC = [[FoodPlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    //准备播放
    [playerVC.moviePlayer prepareToPlay];
    //播放
    [playerVC.moviePlayer play];
    //跳转页面
    [self presentViewController:playerVC animated:YES completion:nil];
    
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
