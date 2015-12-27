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
    
    //用户头像
    UIImageView * _iconImageView;
    //昵称
    UILabel * _nameLabel;
}

@end

@implementation LeftViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * userName = [user objectForKey:@"userName"];
    NSString * iconURL = [user objectForKey:@"iconURL"];
    _nameLabel.text = userName;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:[UIImage imageNamed:@"5.jpg"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(255,156,187,1);
    [self createUI];
    [self createTableView];
}

#pragma mark - 创建UI
-(void)createUI
{
    //头像
    _iconImageView = [FactoryUI createImageViewWithFrame:CGRectMake(((SCREEN_W - 100) - 70) / 2 ,50, 70, 70) imageName:@"5.jpg"];
    _iconImageView.layer.cornerRadius = _iconImageView.frame.size.width / 2;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_iconImageView];

    //昵称
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _iconImageView.center.y + _iconImageView.frame.size.height / 2 + 10, SCREEN_W - 100, 20) text:@"yangyangyang" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18]];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameLabel];
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
//        WeatherViewController * weatherVC = [[WeatherViewController alloc]init];
//        [self presentViewController:weatherVC animated:YES completion:nil];
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
