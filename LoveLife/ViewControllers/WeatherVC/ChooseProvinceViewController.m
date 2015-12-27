//
//  ChooseProvinceViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ChooseProvinceViewController.h"
#import "WeatherModel.h"
@interface ChooseProvinceViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    //搜索框
    UISearchBar *_sb;
    //搜索展示控制器
    UISearchDisplayController *_sc;
    //用来存放搜索结果
    NSMutableArray *_seachResults;
}
@end

@implementation ChooseProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    _seachResults = [[NSMutableArray alloc]initWithCapacity:0];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self getTheModelData];
    [self createTableView];
}
- (void)getTheModelData{
    NSArray *arr = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    for (NSDictionary *dic in arr) {
        WeatherModel *model = [[WeatherModel alloc]init];
        model.State = dic[@"State"];
        model.Cities = dic[@"Cities"];
        [_dataArr addObject:model];
    }
}
- (void)createTableView{
    CGRect frame =self.view.frame;
//    frame.origin.y =64;
//    frame.size.height -=64;
    _tableView = [[UITableView alloc]initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //构建搜索功能
    _sb = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    _tableView.tableHeaderView = _sb;
    //将搜索控制器和seachBar联系起来
    _sc = [[UISearchDisplayController alloc]initWithSearchBar:_sb contentsController:self];
    _sc.delegate = self;
    
    _sc.searchResultsDataSource = self;
    _sc.searchResultsDelegate = self;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    //seach里面文字发生了改变，都会走这个方法
    [_seachResults removeAllObjects];
    for (WeatherModel *model in _dataArr) {
        for (NSDictionary *cityDic in model.Cities) {
            NSString *str = cityDic[@"city"];
            NSRange range = [str rangeOfString:searchString];
            if (range.length) {
                [_seachResults addObject:str];
            }
        }
    }
    return YES;
}

//返回行段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView != _tableView) {
        return 1;
    }
    return _dataArr.count;
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView != _tableView) {
        return _seachResults.count;
    }
    WeatherModel *model = _dataArr[section];
    return model.Cities.count;
}
//设置段高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//返回段头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView != _tableView) {
        return @"搜索结果";
    }
    WeatherModel *model = _dataArr[section];
    return model.State;
}
//返回段
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *provinceName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
//    provinceName.backgroundColor = [UIColor lightGrayColor];
//    WeatherModel *model = _dataArr[section];
//    provinceName.text = model.State;
//    provinceName.textAlignment = NSTextAlignmentCenter;
//    return provinceName;
//}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"110"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"110"];
    }
    if (tableView != _tableView) {
        cell.textLabel.text = [_seachResults objectAtIndex:indexPath.row];
    }else{
        WeatherModel *model = _dataArr[indexPath.section];
        
        cell.textLabel.text = model.Cities[indexPath.row][@"city"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.delegate backTheCityName:cell.textLabel.text];
    [self.navigationController popViewControllerAnimated:YES];
}
//清除tableViewHeaderView的黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat sectionHeaderHeight = 40;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }
//    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
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
