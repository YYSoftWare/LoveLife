//
//  LeftViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/26.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "LeftViewController.h"
#import "WeatherViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(255,156,187,1);
    [self createTableView];
}

#pragma mark - 创建tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 200, 200, SCREEN_H - 150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = RGB(255,156,187,1);
    _tableView.separatorColor =[UIColor clearColor];
    
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.backgroundColor = RGB(255,156,187,1);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //赋值
    if (indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-chatianqi"];
        cell.textLabel.text = @"天气查询";
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    else if (indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-ditu"];
        cell.textLabel.text = @"我的附近";
        cell.textLabel.textColor = [UIColor whiteColor];
    }
        
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //天气查询
        WeatherViewController * weatherVC = [[WeatherViewController alloc]init];
        [self presentViewController:weatherVC animated:YES completion:nil];
    }
    else
    {
        //我的附近
        
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
