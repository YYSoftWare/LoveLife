//
//  MyViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MyViewController.h"
#import "MyCollectionViewController.h"
#import "AppDelegate.h"
#import "AboutViewController.h"
#import "LoginViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //头部图片
    UIImageView * _headImageView;
    
    //夜间模式
    UIView * _darkView;
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
    self.leftButton.hidden = YES;
    [self.rightButton setTitle:@"登录" forState:UIControlStateNormal];
    [self setRightButtonSelector:@selector(rightButtonClick)];
}

#pragma mark - 创建tableView的头部视图

-(void)createTableHeaderView
{
    _headImageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome1"]];
    _headImageView.frame=CGRectMake(0, -kImageOriginHeight,SCREEN_W,kImageOriginHeight);
    [_tableView addSubview:_headImageView];
    
    //夜间模式遮罩view
    _darkView = [FactoryUI createViewWithFrame:[UIScreen mainScreen].bounds];
}

#pragma mark - 创建tableView

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorColor= RGB(255,156,187,1);
    
    //tableView的内容由kImageOriginHeight 处开始显示。
    _tableView.contentInset=UIEdgeInsetsMake(kImageOriginHeight,0,0,0);
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ((indexPath.section == 0 && indexPath.row == 2) || indexPath.row == 3)
        {
            UISwitch * swi = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_W - 70,6, 40, 20)];
            swi.onTintColor = [UIColor greenColor];
            swi.tag = 10 + indexPath.row;
            [swi addTarget:self action:@selector(switchOption:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:swi];
        }
        if ((indexPath.section == 0 && indexPath.row == 0)|| indexPath.row == 1 || indexPath.section == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    //赋值
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfontaixinyizhan"];
            cell.textLabel.text = @"我的喜欢";
        }
        else if(indexPath.row == 1)
        {
            cell.imageView.image = [UIImage imageNamed:@"iconfont-lajitong"];
            cell.textLabel.text = @"清除缓存";
        }
        else if(indexPath.row == 2)
        {
            cell.imageView.image = [UIImage imageNamed:@"iconfont-yejianmoshi"];
            cell.textLabel.text = @"夜间模式";
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"iconfont-zhengguiicon40"];
            cell.textLabel.text = @"推送消息";
        }
        
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-guanyu"];
        cell.textLabel.text = @"关于";
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            //收藏
            MyCollectionViewController * myCollectionView = [[MyCollectionViewController alloc]init];
            myCollectionView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myCollectionView animated:YES];
            
        }
        else if(indexPath.row == 1)
        {
            //清除缓存
            [self folderSizeWithPath:[self getPath]];
        }
    }
    else
    {
        //关于
        AboutViewController * aboutVC = [[AboutViewController alloc]init];
        aboutVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

#pragma mark - 夜间模式响应方法
-(void)switchOption:(UISwitch *)swi
{
    if (swi.tag == 12) {
        //清除缓存
        if (swi.on == YES)
        {
            UIApplication * app = [UIApplication sharedApplication];
            AppDelegate * delegate = app.delegate;
            _darkView.backgroundColor = [UIColor blackColor];
            _darkView.alpha = 0.3;
            //关闭用户交互属性
            _darkView.userInteractionEnabled = NO;
            [delegate.window addSubview:_darkView];
        }
        else
        {
            [_darkView removeFromSuperview];
        }
    }
    else
    {
        //推送消息
        
    }
    
    
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

#pragma mark - 第一步，计算缓存文件的大小
//首先获取缓存文件的路径
-(NSString *)getPath
{
    //沙盒目录下library文件夹下的cache文件夹就是缓存文件夹
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return path;
}

-(CGFloat)folderSizeWithPath:(NSString *)path
{
    //初始化文件管理类
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    float folderSize = 0.0;
    
    if ([fileManager fileExistsAtPath:path])
    {
        //如果存在
        //计算文件的大小
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        for (NSString * fileName in fileArray)
        {
            //获取每个文件的路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            //计算每个子文件的大小
            long fileSize = [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;//字节数
            folderSize = folderSize + fileSize / 1024.0 / 1024.0;
            
        }
        
        //删除缓存文件
        [self deleteFileSize:folderSize];
        
        return folderSize;
    }
    
    return 0;
    
}
#pragma mark - 弹出是否删除的一个提示框，并且告诉用户目前有多少缓存
-(void)deleteFileSize:(CGFloat)folderSize
{
    if (folderSize > 0.01)
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小:%.2fM,是否清除？",folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存已全部清理" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //彻底删除文件
        [self clearCacheWith:[self getPath]];
    }
}

-(void)clearCacheWith:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        for (NSString * fileName in fileArray)
        {
            //可以过滤掉特殊格式的文件
            if ([fileName hasSuffix:@".png"])
            {
                NSLog(@"不删除");
            }
            else
            {
                //获取每个子文件的路径
                NSString * filePath = [path stringByAppendingPathComponent:fileName];
                //移除指定路径下的文件
                [fileManager removeItemAtPath:filePath error:nil];
            }
        }
    }
}

#pragma mark - 按钮响应函数
-(void)rightButtonClick
{
    LoginViewController * vc = [[LoginViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
