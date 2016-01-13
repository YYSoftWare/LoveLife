//
//  MyCollectionViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/11.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ArticalTableViewCell.h"
#import "ArticalModel.h"
#import "DBManager.h"
#import "ArticalDetailViewController.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //提示
    UILabel * _label;
}

@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,strong) NSMutableArray * selectArray;

@end

@implementation MyCollectionViewController

-(void)viewWillAppear:(BOOL)animated
{
    if(self.dataArray.count==0)
    {
        _label=[[UILabel alloc]initWithFrame:CGRectMake(0, (SCREEN_H - 30) / 2, SCREEN_W, 30)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines=0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.text=@"您还没有收藏哦！";
        _label.textColor = [UIColor lightGrayColor];
        _label.font = [UIFont systemFontOfSize:25];
        [self.view addSubview:_label];
    }
    else
    {
        [_label removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self getData];
    [self createTableView];
    
}

#pragma mark - 获取数据库的数据
-(void)getData
{
    DBManager * manager = [DBManager defaultManager];
    NSArray * array =[manager getData];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [_tableView reloadData];}

#pragma mark - 创建tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor = RGB(255,156,187,1);
    _tableView.tableFooterView = [[UIView alloc]init];
    
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ArticalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ArticalModel * model = self.dataArray[indexPath.row];
    [cell configUI:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectArray addObject:indexPath];
    ArticalDetailViewController * vc = [[ArticalDetailViewController alloc]init];
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectArray removeObject:indexPath];
}

//实现cell的删除
//设置编辑cell的类型
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//设置cell可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除的思路：1.先删除数据库中的数据，2.然后删除界面的cell，3.最后刷新界面
    DBManager * manager = [DBManager defaultManager];
    ArticalModel * model = self.dataArray[indexPath.row];
    [manager deleteNameFromTable:model.dataID];
    
    //删除cell
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //刷新界面
    //[_tableView reloadData];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"我的喜欢";
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    
    [self setLeftButtonSelector:@selector(leftButtonClick)];
    [self setRightButtonSelector:@selector(rightButtonClick:)];
}

#pragma mark - 按钮响应事件
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//删除
-(void)rightButtonClick:(UIButton *)button
{
    button.selected=!button.selected;
    
    if (button.selected)
    {
        [button setTitle:@"删除" forState:UIControlStateNormal];
    }
    else
    {
        [button setTitle:@"编辑" forState:UIControlStateNormal
         ];
    }
    _tableView.editing=!_tableView.editing;
    //在编辑期间被选择
    //_tableView.allowsMultipleSelectionDuringEditing = YES;
    
//    if (self.selectArray.count>0)
//    {
//        GDDataManager * manager=[GDDataManager shareManager];
//        for (int i=0; i<self.selectArray.count; i++)
//        {
//            NSIndexPath * path=self.selectArray[i];
//            ArticalModel * model=self.dataArray[path.row];
//            
//            [_dataArray replaceObjectAtIndex:path.row withObject:@""];
//            [manager deleteWith:model.title];
//            
//        }
//        [_dataArray removeObject:@""];
//        //数据源变的时候就要刷新数据,或者cell的格式变了得时候，这里还有reloadsection的，区的状态发生了变化或者是区里面的row方生了改变
//        [_tableView reloadData];
//        
//        [self.selectArray removeAllObjects];
//        
//        
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
