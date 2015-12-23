
//
//  HealthyViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "HealthyViewController.h"
#import "MyCollectionViewCell.h"
#import "MusicViewController.h"

@interface HealthyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView * _collectionView;
}
//数据源
@property(nonatomic,strong) NSArray * nameArray;
@property(nonatomic,strong) NSArray * urlArray;
@property(nonatomic,strong) NSArray * imageArray;

@end

@implementation HealthyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
    [self getData];
}

#pragma mark - 数据
-(void)getData
{
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语",@"歌曲排行榜"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu,paihangbang];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13",@"shili24"];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"娱乐";
    self.leftButton.hidden = YES;
}

#pragma mark - 创建UI
-(void)createUI
{
    //创建网格布局对象
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    //    UICollectionViewScrollDirectionVertical,纵向
    //    UICollectionViewScrollDirectionHorizontal  横向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_W, SCREEN_H + 10) collectionViewLayout:flowLayout];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //设置背景色，系统默认颜色为黑色
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    //注册cell类
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - 实现代理方法
//返回section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回每个section对应的item的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
//创建cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.item]];
    cell.label.text = self.nameArray[indexPath.item];
    return cell;
    
    //设置渐变动画
    //[self addAnimationWithCell1:cell];
    //设置倾斜动画
    //[self addAnimationWithCell2:cell];
    
}
//设置网格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width - 20) / 2, 150);
}

//设置边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//设置水平网格间隙，水平和垂直的默认的间隙都是10
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//设置垂直网格间隙
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicViewController * VC = [[MusicViewController alloc]init];
    //传值
    VC.urlString = self.urlArray[indexPath.item];
    VC.typeString = self.nameArray[indexPath.item];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
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
