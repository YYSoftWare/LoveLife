//
//  ReadViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticalViewController.h"
#import "UtteranceViewController.h"

@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    
    UISegmentedControl * _segment;
}

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self settingNav];
    [self createUI];
}

#pragma mark - 修改导航属性
-(void)settingNav
{
    //创建分段选择器
    _segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    [_segment insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segment insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    _segment.selectedSegmentIndex = 0;
    _segment.tintColor = [UIColor whiteColor];
    [_segment addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    
    //隐藏左按钮
    self.leftButton.hidden = YES;
}

#pragma mark - 创建UI
-(void)createUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    //设置分页属性
    _scrollView.pagingEnabled = YES;
    //隐藏横向滑条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(SCREEN_W * 2, _scrollView.frame.size.height);
    
    //添加子页面，滚动式框架实现，在VC中管理子VC的view
    ArticalViewController * articalVC = [[ArticalViewController alloc]init];
    UtteranceViewController * utteranceVC = [[UtteranceViewController alloc]init];
    
    NSArray * subVCArray = @[articalVC,utteranceVC];
    int i = 0;
    
    for (UIViewController * vc in subVCArray)
    {
        vc.view.frame = CGRectMake(i * SCREEN_W, 0, SCREEN_W, _scrollView.frame.size.height);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i ++;
    }
}
#pragma mark - scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //实现segment和scrollView的联动
    if (_scrollView.contentOffset.x == SCREEN_W)
    {
        _segment.selectedSegmentIndex = 1;
    }
    else if(_scrollView.contentOffset.x == 0)
    {
        _segment.selectedSegmentIndex = 0;
    }
}

#pragma mark - 分段选择器
-(void)changeOption:(UISegmentedControl *)segment
{
    //每次点击切换的时候更改scrollView的contentOffset值
    _scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex * SCREEN_W, 0);
    
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
