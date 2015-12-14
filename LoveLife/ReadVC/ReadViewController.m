//
//  ReadViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticalModel.h"
#import "UtteranceModel.h"
#import "ArticalTableViewCell.h"
#import "UtteranceTableViewCell.h"

@interface ReadViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView1;
    UITableView * _tableView2;
    
    //分页
    int _page1;
    int _page2;
    
    //刷新
    MJRefreshHeaderView * _header1;
    MJRefreshFooterView * _footer1;
    
    MJRefreshHeaderView * _header2;
    MJRefreshFooterView * _footer2;
    
}

//活动指示器
@property(nonatomic,strong) MBProgressHUD * hud;

//数据源
@property(nonatomic,strong)NSMutableArray* dataArray1;
@property(nonatomic,strong) NSMutableArray * dataArray2;

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page1 = 1;
    [self settingNav];
    [self createUI];
    [self createRefresh1];
    [self createRefresh2];
}

#pragma mark - 修改导航属性
-(void)settingNav
{
    //创建分段选择器
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    [segment insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [segment insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor whiteColor];
    [segment addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
}

#pragma mark - 创建语录的刷新
-(void)createRefresh2
{
    __weak ReadViewController * weakVC = self;
    
    //下拉刷新
    _header2 = [MJRefreshHeaderView header];
    _header1.beginRefreshingBlock = ^(MJRefreshBaseView * refresh)
    {
        [weakVC addRefresh2:refresh];
    };
    _header2.scrollView = _tableView2;
    
    //上拉加载
    _footer2 = [MJRefreshFooterView footer];
    _footer2.beginRefreshingBlock = ^(MJRefreshBaseView * refresh)
    {
        [weakVC addRefresh2:refresh];
    };
    _footer2.scrollView = _tableView2;
}

-(void)addRefresh2:(MJRefreshBaseView *)refresh
{
    if (refresh == _header2) {
        _page2 = 0;
        self.dataArray2 = [NSMutableArray arrayWithCapacity:0];
        [self loadData2];
    }
    else
    {
        _page2 ++;
        [self loadData2];
    }
}

-(void)loadData2
{
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    //美文
    [manager GET:[NSString stringWithFormat:UTTERANCEURL,_page2] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary * dic in responseObject[@"content"])
        {
            UtteranceModel * model = [[UtteranceModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray2 addObject:model];
        }
        
        //数据刷新完成之后停止刷新，隐藏活动指示器，刷新界面
        [self.hud hide:YES];
        if (_page2 == 1)
        {
            [_header2 endRefreshing];
        }
        else
        {
            [_footer2 endRefreshing];
        }
        
        [_tableView2 reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 创建美文的刷新
-(void)createRefresh1
{
    __weak ReadViewController * weakVC = self;
    
    //下拉刷新
    _header1 = [MJRefreshHeaderView header];
    _header1.beginRefreshingBlock = ^(MJRefreshBaseView * refresh)
    {
        [weakVC addRefresh1:refresh];
    };
    _header1.scrollView = _tableView1;
    
    //上拉加载
    _footer1 = [MJRefreshFooterView footer];
    _footer1.beginRefreshingBlock = ^(MJRefreshBaseView * refresh)
    {
        [weakVC addRefresh1:refresh];
    };
    _footer1.scrollView = _tableView1;
    
    //刚开始进入页面时主动刷新一次
    [_header1 beginRefreshing];
    
}

-(void)addRefresh1:(MJRefreshBaseView *)refresh
{
    if (refresh == _header1) {
        _page1 = 1;
        self.dataArray1 = [NSMutableArray arrayWithCapacity:0];
        [self loadData1];
    }
    else
    {
        _page1 ++;
        [self loadData1];
    }
}

#pragma mark - 请求数据
//美文
-(void)loadData1
{
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    //美文
    [manager GET:[NSString stringWithFormat:ARTICALURL,_page1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary * dic in responseObject[@"data"])
        {
            ArticalModel * model = [[ArticalModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray1 addObject:model];
        }
        
        //数据刷新完成之后停止刷新，隐藏活动指示器，刷新界面
        [self.hud hide:YES];
        if (_page1 == 1)
        {
            [_header1 endRefreshing];
        }
        else
        {
            [_footer1 endRefreshing];
        }
        
        [_tableView1 reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -创建UI
-(void)createUI
{
    //读美文
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    [self.view addSubview:_tableView1];
    
    //看语录
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    [self.view addSubview:_tableView2];
    
    //让tableView1先显示
    [self.view bringSubviewToFront:_tableView1];
    
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
    if (tableView == _tableView1)
    {
        return self.dataArray1.count;
    }
    
    return self.dataArray2.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView1)
    {
        ArticalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (!cell)
        {
            cell = [[ArticalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID1"];
            //取消选中状态
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (self.dataArray1)
        {
            ArticalModel * model = self.dataArray1[indexPath.row];
            [cell configUI:model];
        }
        
        return cell;
    }
    
    UtteranceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell)
    {
        cell = [[UtteranceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        //取消选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataArray2)
    {
        UtteranceModel * model = self.dataArray2[indexPath.row];
        [cell configUI:model];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView1)
    {
        return 135;
    }
    
    UtteranceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    UtteranceModel * model = self.dataArray2[indexPath.row];
    [cell configUI:model];
    
    return cell.cellHeight;
}

#pragma mark - 分段选择器
-(void)changeOption:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        [self.view bringSubviewToFront:_tableView1];
    }
    else
    {
        [self.view bringSubviewToFront:_tableView2];
        [_header2 beginRefreshing];
    }
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
