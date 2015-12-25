
//
//  FoodDetailViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/21.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "DetailModel.h"
#import "StepModel.h"
#import "StepCell.h"
#import "FoodPlayerViewController.h"

@interface FoodDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * _mainBgView;
    //背景大图
    UIImageView * _mainImageView;
    //菜品名称
    UILabel * _titleLabel;
    //详情描述
    UILabel * _detailLabel;
    
    UITableView * _tableView;
    
    //矢量
    UILabel * _levelLabel;
    UILabel * _timeLabel;
    UILabel * _tasteLabel;
}
//数据源
@property(nonatomic,strong) NSMutableArray * dataArray;
//model
@property(nonatomic,strong) DetailModel * model;

@end

@implementation FoodDetailViewController

#pragma mark - 隐藏导航条
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setingNav];
    [self createTableHeaderView];
    [self createTableView];
    [self loadData];
}

#pragma mark - 请求数据
-(void)loadData
{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"dishes_id": self.dataId, @"methodName": @"DishesView"};
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0)
        {
            NSDictionary * detailDic = responseObject[@"data"];
            _model = [[DetailModel alloc]init];
            _model.image = detailDic[@"image"];
            _model.dishes_name= detailDic[@"dishes_name"];
            _model.material_desc = detailDic[@"material_desc"];
            _model.step = detailDic[@"step"];
            for (NSDictionary * dic in _model.step)
            {
                StepModel * stepModel = [[StepModel alloc]init];
                stepModel.dishes_step_desc = dic[@"dishes_step_desc"];
                stepModel.dishes_step_image = dic[@"dishes_step_image"];
                [self.dataArray addObject:stepModel];
            }
            
            [self refreshUI:_model];
            [_tableView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 刷新UI
-(void)refreshUI:(DetailModel *)model
{
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.dishes_name;
    _detailLabel.text = model.material_desc;
    
    //难易程度
    NSArray * array = @[@"",@"",@""];
    
}

#pragma mark - 创建头部视图
-(void)createTableHeaderView
{
    _mainBgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H + 64)];
    _mainBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainBgView];
    
    //背景
    _mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_W, (SCREEN_H + 64) / 3 * 2) imageName:nil];
    _mainImageView.userInteractionEnabled = YES;
    [_mainBgView addSubview:_mainImageView];
    
    //返回按钮
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 10, 30, 30) title:nil titleColor:nil imageName:@"iconfont-back" backgroundImageName:nil target:self selector:@selector(leftButtonClick)];
    [_mainImageView addSubview:backButton];
    
    //名称
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _mainImageView.frame.size.height + 15, SCREEN_W - 20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:20]];
    [_mainBgView addSubview:_titleLabel];
    
    //详情描述
    _detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 10, SCREEN_W - 20, 50) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    _detailLabel.numberOfLines = 0;
    _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_mainBgView addSubview:_detailLabel];
    
    //难度
    UIImageView * levelImageView = [FactoryUI createImageViewWithFrame:CGRectMake(30, SCREEN_H - 40, 30, 30) imageName:@"矢量智能对象难易度"];
    [_mainBgView addSubview:levelImageView];
    _levelLabel = [FactoryUI createLabelWithFrame:CGRectMake(levelImageView.frame.origin.x - 20, levelImageView.frame.size.height + levelImageView.frame.origin.y + 5,levelImageView.frame.size.width + 40, 15) text:@"难度：适中" textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:10]];
    _levelLabel.textAlignment = NSTextAlignmentCenter;
    [_mainBgView addSubview:_levelLabel];
    //时长
    UIImageView * timeImageView = [FactoryUI createImageViewWithFrame:CGRectMake(levelImageView.frame.size.width + levelImageView.frame.origin.x + (SCREEN_W - 150) / 2, levelImageView.frame.origin.y, 30, 30) imageName:@"矢量智能对象时长"];
    [_mainBgView addSubview:timeImageView];
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(timeImageView.frame.origin.x - 20, _levelLabel.frame.origin.y,timeImageView.frame.size.width + 40, 15) text:@"时间：15分钟" textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:10]];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [_mainBgView addSubview:_timeLabel];
    //口味
    UIImageView * tasteImageView = [FactoryUI createImageViewWithFrame:CGRectMake(timeImageView.frame.size.width + timeImageView.frame.origin.x + (SCREEN_W - 150) / 2, timeImageView.frame.origin.y, 30, 30) imageName:@"矢量智能对象口味"];
    [_mainBgView addSubview:tasteImageView];
    _tasteLabel = [FactoryUI createLabelWithFrame:CGRectMake(tasteImageView.frame.origin.x - 20,_levelLabel.frame.origin.y, tasteImageView.frame.size.width + 40, 15) text:@"口味：鲜" textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:10]];
    _tasteLabel.textAlignment = NSTextAlignmentCenter;
    [_mainBgView addSubview:_tasteLabel];
    
    //播放按钮
    UIButton * palyButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 50, 50) title:nil titleColor:nil imageName:@"iconfont-bofang-3" backgroundImageName:nil target:self selector:@selector(playButtonClick)];
    palyButton.center = _mainImageView.center;
    [_mainImageView addSubview:palyButton];
    
    //详细按钮
    UIView * subView = [FactoryUI createViewWithFrame:CGRectMake(0, _mainImageView.frame.size.height - 30, SCREEN_W, 30)];
    subView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [_mainImageView addSubview:subView];
    
    NSArray * imageArray = @[@"iconfont-bofang-4",@"iconfont-bofang-4",@"iconfont-xiazai"];
    NSArray * titleArray = @[@"食材准备",@"制作步骤",@"下载"];
    for (int i = 0; i < imageArray.count; i ++)
    {
        UIButton * subButton = [FactoryUI createButtonWithFrame:CGRectMake(i * SCREEN_W / 3, 5, SCREEN_W / 3, 20) title:titleArray[i] titleColor:[UIColor whiteColor] imageName:imageArray[i] backgroundImageName:nil target:self selector:@selector(detailPlayerButtonClick:)];
        [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        subButton.titleLabel.font = [UIFont systemFontOfSize:14];
        subButton.tag = 200 + i;
        [subView addSubview:subButton];
    }
    
}

#pragma mark - 创建tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H + 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //设置tableHeaderView
    _tableView.tableHeaderView = _mainBgView;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorColor = RGB(255,156,187,1);
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StepCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FoodDetailID"];
    if (!cell) {
        cell = [[StepCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FoodDetailID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataArray) {
        StepModel * model = self.dataArray[indexPath.row];
        [cell config:model indexPath:indexPath];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, SCREEN_W, 40) text:@"制作步骤" textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:20]];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    label.textColor = [UIColor darkGrayColor];
    
    UIView * lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 37, SCREEN_W, 3)];
    lineView.backgroundColor = RGB(255,156,187,1);
    [label addSubview:lineView];
    
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView)
    {
        if (scrollView.contentOffset.y >= SCREEN_H + 64)
        {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.navigationController.navigationBar.hidden = NO;
                _tableView.frame = CGRectMake(0, 44, SCREEN_W, SCREEN_H);
            }];
            
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.navigationController.navigationBar.hidden = YES;
                _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H + 64);
            }];
            
        }
    }
}


#pragma mark - 设置导航
-(void)setingNav
{
    self.titleLabel.text = self.NavTitle;
    [self setLeftButtonSelector:@selector(leftButtonClick)];
}

#pragma mark - 按钮响应函数
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//详细制作步骤视频按钮
-(void)detailPlayerButtonClick:(UIButton *)button
{
    switch (button.tag - 200) {
        case 0:
        {
            //食材准备
            FoodPlayerViewController * playerVC = [[FoodPlayerViewController alloc]initWithContentURL:[NSURL URLWithString:_model.material_video]];
            //准备播放
            [playerVC.moviePlayer prepareToPlay];
            //播放
            [playerVC.moviePlayer play];
            //跳转页面
            [self presentViewController:playerVC animated:YES completion:nil];
        }
            break;
        case 1:
        {
            //制作步骤
            FoodPlayerViewController * playerVC = [[FoodPlayerViewController alloc]initWithContentURL:[NSURL URLWithString:_model.process_video]];
            //准备播放
            [playerVC.moviePlayer prepareToPlay];
            //播放
            [playerVC.moviePlayer play];
            //跳转页面
            [self presentViewController:playerVC animated:YES completion:nil];
        }
            break;
        case 2:
        {
            //下载
            
        }
            break;
            
        default:
            break;
    }
}

//主视频播放按钮
-(void)playButtonClick
{
    FoodPlayerViewController * playerVC = [[FoodPlayerViewController alloc]initWithContentURL:[NSURL URLWithString:self.videoUrl]];
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
