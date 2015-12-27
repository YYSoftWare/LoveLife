
//
//  MusicViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/22.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicModel.h"
#import "MusicCell.h"
//播放界面
#import "MusicPlayerViewController.h"

@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //分页
    int _page;
}

@property(nonatomic,strong) NSMutableArray * dataArray;
//活动指示器
@property(nonatomic,strong) MBProgressHUD * hud;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createTableView];
    [self createRefresh];
    //刷新
    [_tableView.header beginRefreshing];
}

#pragma mark - 获取网络数据
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
    [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary * dic in responseObject[@"data"]) {
            MusicModel * model = [[MusicModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
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



#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = self.typeString;
    [self setLeftButtonSelector:@selector(leftButtonClick)];
}

#pragma mark - 创建tableVIew
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
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

#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[MusicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置尾部样式
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (self.dataArray) {
        MusicModel * model = self.dataArray[indexPath.row];
        [cell configUI:model];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayerViewController * vc = [[MusicPlayerViewController alloc]init];
    //传值
    MusicModel * model = self.dataArray[indexPath.row];
    vc.titleString = model.title;
    vc.imageUrl = model.coverURL;
    vc.lrcInfo = model;
    vc.lrcInfos = self.dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 按钮响应方法
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
