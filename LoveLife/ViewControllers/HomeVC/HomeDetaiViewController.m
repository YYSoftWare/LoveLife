//
//  HomeDetaiViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/15.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "HomeDetaiViewController.h"

@interface HomeDetaiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //头部图片
    UIImageView * _headerImageView;
    //头部文字描述
    UILabel * _desLabel;
}

//数据源
//头部的数据
@property(nonatomic,strong) NSDictionary * dataDic;
//tableView的数据
@property(nonatomic,strong) NSMutableArray * dataArray;
//image的数组
@property(nonatomic,strong) NSMutableArray * imageArray;

@end

@implementation HomeDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self makeUI];
    [self loadData];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"详情";
//    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-shoucangweishoucang-2"] forState:UIControlStateNormal];
//    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-shoucangyishoucang"] forState:UIControlStateSelected];
    
    [self setLeftButtonSelector:@selector(leftButtonClick)];
    //[self setRightButtonSelector:@selector(rightButtonClick:)];
}

#pragma mark - 数据请求
-(void)loadData
{
    //初始化数组
    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEDETAIL,[self.stringUrl intValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //头部的数据
        self.dataDic = responseObject[@"data"];
        
        //tableView的数据
        self.dataArray = self.dataDic[@"product"];
        
        //刷新界面
        [self refreshHeaderView];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)refreshHeaderView
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    _desLabel.text = self.dataDic[@"desc"];
}

#pragma mark - 创建UI
-(void)makeUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H + 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorColor = RGB(255,156,187,1);
    
    //头部视图
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_W, 200) imageName:nil];
    _desLabel = [FactoryUI createLabelWithFrame:CGRectMake(0,_headerImageView.frame.size.height - 40 , SCREEN_W, 40) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14]];
    _desLabel.numberOfLines = 0;
    _desLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _desLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [_headerImageView addSubview:_desLabel];
    
    //设置_headerImageView为tableView的头视图
    _tableView.tableHeaderView = _headerImageView;
}

#pragma mark - 实现tableView的代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionArray = self.dataArray[section][@"pic"];
    return sectionArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SCREEN_W - 20, 200) imageName:nil];
        imageView.backgroundColor = [UIColor redColor];
        imageView.tag = 10;
        [cell.contentView addSubview:imageView];
    }
    UIImageView * imageView = (UIImageView *)[cell.contentView viewWithTag:10];
    
    //赋值
    if (self.imageArray)
    {
        NSArray * sectionArray = self.dataArray[indexPath.section][@"pic"];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArray[indexPath.row][@"pic"]] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    UIButton * indexButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 10, 40, 40) title:nil titleColor:[UIColor lightGrayColor] imageName:nil backgroundImageName:@"" target:self selector:nil];
    indexButton.layer.borderWidth = 2;
    indexButton.layer.borderColor = RGB(255,156,187,1).CGColor;
    [indexButton setTitleColor:RGB(255,156,187,1) forState:UIControlStateNormal];
    [bgView addSubview:indexButton];
    
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(indexButton.frame.size.width + indexButton.frame.origin.x + 20, 18, SCREEN_W - 50, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    [bgView addSubview:titleLabel];
    
    //赋值
    NSDictionary * dic = self.dataArray[section];
    [indexButton setTitle:[NSString stringWithFormat:@"%ld",section + 1] forState:UIControlStateNormal];
    titleLabel.text = dic[@"title"];
    
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

#pragma mark - 按钮响应函数
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton *)button
{
    
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
