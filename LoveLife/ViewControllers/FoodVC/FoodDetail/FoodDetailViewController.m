
//
//  FoodDetailViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/21.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "FoodDetailViewController.h"

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
}
@property(nonatomic,strong) NSMutableArray * dataArray;

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
//    [self setingNav];
//    [self createTableHeaderView];
//    [self createTableView];
    [self loadData];
}

#pragma mark - 请求数据
-(void)loadData
{
//    self.dataArray = [NSMutableArray arrayWithCapacity:0];
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary * dic = @{@"dishes_id": self.dataId, @"methodName": @"DishesView"};
//    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([responseObject[@"code"] intValue] == 0)
//        {
//            NSDictionary * detailDic = responseObject[@"data"];
//            DetailModel * model = [[DetailModel alloc]init];
//            model.image = detailDic[@"image"];
//            model.dishes_name= detailDic[@"dishes_name"];
//            model.material_desc = detailDic[@"material_desc"];
//            model.step = detailDic[@"step"];
//            for (NSDictionary * dic in model.step)
//            {
//                StepModel * stepModel = [[StepModel alloc]init];
//                stepModel.dishes_step_desc = dic[@"dishes_step_desc"];
//                stepModel.dishes_step_image = dic[@"dishes_step_image"];
//                [self.dataArray addObject:stepModel];
//            }
//            
//            [self refreshUI:model];
//            [_tableView reloadData];
//            
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    //}];
}

#pragma mark - 创建头部视图
-(void)createTableHeaderView
{
    
}

#pragma mark - 创建tableView
-(void)createTableView

{
    
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FoodDetailID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FoodDetailID"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
