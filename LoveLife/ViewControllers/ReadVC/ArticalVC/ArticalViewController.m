//
//  ArticalViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/15.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ArticalViewController.h"
#import "ArticalModel.h"
#import "ArticalTableViewCell.h"
#import "ArticalDetailViewController.h"
#import "UMSocial.h"

@interface ArticalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //分页
    int _page;

}

//活动指示器
@property(nonatomic,strong) MBProgressHUD * hud;

//数据源
@property(nonatomic,strong)NSMutableArray *dataArray1;

@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self createUI];
    [self createRefresh];
    [_tableView.header beginRefreshing];
}

#pragma mark - 创建美文的刷新
-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    
}

- (void)downRefresh{
    _page = 0;
    self.dataArray1 = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
}
- (void)upRefresh{
    _page++;
    [self loadData];
    
}

#pragma mark - 请求数据
//美文
-(void)loadData
{
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    //美文
    [manager GET:[NSString stringWithFormat:ARTICALURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * array = responseObject[@"data"];
        for (NSDictionary * dic in array)
        {
            ArticalModel * model = [[ArticalModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray1 addObject:model];
            
        }
        
        //数据刷新完成之后停止刷新，隐藏活动指示器，刷新界面
        [self.hud hide:YES];
        [_tableView reloadData];
        if (_page == 0)
        {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark - 创建UI
-(void)createUI
{
    //读美文
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor = RGB(255,156,187,1);
    
    //创建活动指示器
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.labelText = @"正在加载...";
    self.hud.activityIndicatorColor = [UIColor whiteColor];
    self.hud.color = [UIColor colorWithWhite:0 alpha:0.2];
    [self.view addSubview:self.hud];
}

#pragma mark - 实现tableView的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray1.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ArticalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell)
    {
        cell = [[ArticalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        //取消选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置尾部样式
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (self.dataArray1)
    {
        ArticalModel * model = self.dataArray1[indexPath.row];
        [cell configUI:model];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticalDetailViewController * vc = [[ArticalDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    ArticalModel * model = self.dataArray1[indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的显示动画为3D缩放
    //xy方向缩放的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:1.0f animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }];
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
