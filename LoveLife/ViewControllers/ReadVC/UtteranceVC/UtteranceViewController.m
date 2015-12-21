//
//  UtteranceViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/15.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "UtteranceViewController.h"
#import "UtteranceModel.h"
#import "UtteranceTableViewCell.h"

@interface UtteranceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    
    //分页
    int _page;
    
    //不定高cell的高度
    float cellHeight;
}

//活动指示器
@property(nonatomic,strong) MBProgressHUD * hud;

//数据源
@property(nonatomic,strong)NSMutableArray* dataArray;

@end

@implementation UtteranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self createUI];
    [self createRefresh];
    [_tableView.header beginRefreshing];
}

#pragma mark - 创建语录的刷新
-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
}

- (void)downRefresh{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
}
- (void)upRefresh{
    _page++;
    [self loadData];
}

-(void)loadData
{
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    //美文
    [manager GET:[NSString stringWithFormat:UTTERANCEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * contentArray = [NSMutableArray arrayWithArray:responseObject[@"content"]];
        [contentArray removeObjectAtIndex:0];
        
        for (NSDictionary * dic in contentArray)
        {
            UtteranceModel * model = [[UtteranceModel alloc]init];
            model.pub_time = dic[@"pub_time"];
            model.publisher_icon_url = dic[@"publisher_icon_url"];
            model.publisher_name = dic[@"publisher_name"];
            model.text = dic[@"text"];
            model.image_url = dic[@"image_urls"][0][@"middle"];
            [self.dataArray addObject:model];
        }
        
        //数据刷新完成之后停止刷新，隐藏活动指示器，刷新界面
        [self.hud hide:YES];
        if (_page == 0)
        {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -创建UI
-(void)createUI
{
    //看语录
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
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UtteranceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell)
    {
        cell = [[UtteranceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        //取消选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataArray)
    {
        UtteranceModel * model = self.dataArray[indexPath.row];
        [cell configUI:model];
        
        cellHeight = cell.cellHeight;
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
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
