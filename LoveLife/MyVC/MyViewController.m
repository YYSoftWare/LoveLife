//
//  MyViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //头部图片
    UIImageView * _headImageView;
}

@end

@implementation MyViewController

static CGFloat kImageOriginHeight = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createTableView];
    [self createTableHeaderView];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"我的";
}

#pragma mark - 创建tableView的头部视图

-(void)createTableHeaderView
{
    _headImageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome1"]];
    _headImageView.frame=CGRectMake(0, -kImageOriginHeight,SCREEN_W,kImageOriginHeight);
    [_tableView addSubview:_headImageView];
}

#pragma mark - 创建tableView

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]init];
    
    //tableView的内容由kImageOriginHeight 处开始显示。
    _tableView.contentInset=UIEdgeInsetsMake(kImageOriginHeight,0,0,0);
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    return cell;
}

#pragma mark - scrollView的代理方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //通过scrollView的偏移量来改变图片的位置和大小
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + kImageOriginHeight) / 2;
    
    if(yOffset < -kImageOriginHeight)
    {
        CGRect f =_headImageView.frame;
        f.origin.y = yOffset ;
        f.size.height =  -yOffset;
        f.origin.x = xOffset;
        f.size.width = SCREEN_W + fabs(xOffset) * 2;
        _headImageView.frame = f;
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
