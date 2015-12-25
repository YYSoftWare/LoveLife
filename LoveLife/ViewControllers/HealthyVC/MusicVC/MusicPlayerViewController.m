//
//  MusicPlayerViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/24.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "PlayModel.h"
#import "AFSoundItem.h"
#import "AFSoundQueue.h"
#import "LZZLrcAnlisis.h"

@interface MusicPlayerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    
}
//音频播放
@property (nonatomic,strong)AFSoundQueue * queue;
@property (nonatomic,strong)AFSoundPlayback * playBack;
@property (nonatomic,strong) NSOperationQueue * operQueue;
@property (nonatomic,strong)NSMutableDictionary * itemDict;

@property (nonatomic,strong)NSArray * lrcArray;

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) NSInteger AFSindex;

//进度条
@property(nonatomic,strong) UISlider * songSlider;
//显示时间
@property(nonatomic,strong) UILabel * showTimeLabel;
//提示
@property (nonatomic,strong) UILabel * noLrcLabel;

@end

@implementation MusicPlayerViewController

#pragma mark - 页面切换
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _operQueue = [[NSOperationQueue alloc]init];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)itemDict
{
    if (!_itemDict) {
        _itemDict = [NSMutableDictionary new];
    }
    return _itemDict;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self refreshUI];
    [self createPlayQuene];
}

#pragma mark - 创建UI
-(void)createUI
{
    //背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"15f81d189d5044b8ff2f825c0cbf1d24.jpg"]];
    
    //返回按钮
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 20, 30, 30) title:nil titleColor:nil imageName:@"iconfont-music-fanhui" backgroundImageName:nil target:self selector:@selector(backButtonClick)];
    [self.view addSubview:backButton];
    
    //标题
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 40, SCREEN_W, 30) text:self.titleString textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:22]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //图片
    //UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake((SCREEN_W - 70) / 2, titleLabel.frame.size.height + titleLabel.frame.origin.y + 10, 70, 70) imageName:<#(NSString *)#>]
    
    //歌词展示
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, titleLabel.frame.size.height + titleLabel.frame.origin.y + 140, SCREEN_W - 40, 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor = [UIColor clearColor];
    
    //进度条
    _songSlider = [[UISlider alloc]initWithFrame:CGRectMake(20, SCREEN_H - 50, SCREEN_W - 20, 10)];
    _songSlider.continuous = NO;
    [self.view addSubview:_songSlider];
}

#pragma mark - 刷新UI
-(void)refreshUI
{
    
}

#pragma mark - 播放队列
-(void)createPlayQuene
{
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queues = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t  group = dispatch_group_create();
    
    dispatch_group_async(group, queues, ^{
        [weakSelf settingPlayQueue];
    });
    dispatch_group_async(group, queues, ^{
        //解析歌词 并将歌词展示出来,并更新歌词UI
        [weakSelf anlisisLrc:_lrcInfo.lyricURL];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        //展示歌词
        [weakSelf shoWlrc];
        //[weakSelf.loadingView stopAnimating];
    });
}

-(void)settingPlayQueue
{
    NSLog(@"开始设置队列");
    AFSoundItem * currentItem = [[AFSoundItem alloc]initWithStreamingURL:[NSURL URLWithString:_lrcInfo.url]];
    _queue = [[AFSoundQueue alloc]initWithItems:@[currentItem]];
    [_queue playCurrentItem];
    NSLog(@"队列设置完成");
}

//展示歌词
-(void)shoWlrc
{
    __weak typeof(self) weakSelf = self;
    NSInteger count = weakSelf.lrcArray.count;
    NSLog(@"展示歌词");
    [_queue listenFeedbackUpdatesWithBlock:^(AFSoundItem *item) {
        NSLog(@"队列回调");
        weakSelf.songSlider.value = item.timePlayed;
        weakSelf.showTimeLabel.text = [NSString stringWithFormat:@"%zd/%zd",item.timePlayed,item.duration];
        
        for (int i = 0; i < count; i++) {
            PlayModel * lrcModel = weakSelf.lrcArray[i];
            int nextI = i+1;
            PlayModel * nextLrcModel = nil;
            if (nextI < count) {
                nextLrcModel = weakSelf.lrcArray[nextI];
            }
            
            if (lrcModel.timelength <= item.timePlayed*1.0 && nextLrcModel.timelength > item.timePlayed*1.0) {
                
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                [weakSelf tableView:_tableView didSelectRowAtIndexPath:indexPath];
                break;
            }
        }
        
    } andFinishedBlock:^(AFSoundItem *nextItem) {
        
    }];

}

- (void)panDuan
{
    NSLog(@"设置播放队列");
    if (!self.itemDict[[self.lrcInfos[_currentIndex] url]]) {
        
        AFSoundItem * item = [[AFSoundItem alloc]initWithStreamingURL:[NSURL URLWithString:(NSString *)[self.lrcInfos[_currentIndex] url]]];
        
        [_queue addItem:item];
        
        [self.itemDict setObject:item forKey:[self.lrcInfos[_currentIndex] url]];
    }
    NSLog(@"播放队列设置成功");
}

- (void)changInfo
{
    self.lrcArray = nil;
    [_tableView reloadData];
    _songSlider.value = 0;
    MusicModel * model = self.lrcInfos[_currentIndex] ;
    _songSlider.maximumValue = [[model length] floatValue];
    
    //self.backGroundImage.image = [UIImage imageWithData:[self.lrcInfos[_currentIndex] imageData]];
}


//解析歌词
- (void)anlisisLrc:(NSString *)urlStr
{
    NSLog(@"开始解析歌词");
    [LZZLrcAnlisis anlisisLrc:[NSURL URLWithString:urlStr] withCompleteBlock:^(NSArray * lrc) {
        
        if (lrc.count<=1) {
            
            self.noLrcLabel.hidden = NO;
            self.lrcArray = nil;
            [_tableView reloadData];
            NSLog(@"歌词解析失败  －－－－");
            
        }else
        {
            self.noLrcLabel.hidden = YES;
            self.lrcArray = lrc;
            [_tableView reloadData];
            NSLog(@"解析歌词成功－－－－%@",lrc[1]);
        }
    }];
}


#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"qqq"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qqq"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor clearColor];
        UIView * view = [[UIView alloc]initWithFrame:cell.bounds];
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
        cell.selectedBackgroundView = view;
    }
    PlayModel * lrcModel = self.lrcArray[indexPath.row];
    cell.textLabel.text = [lrcModel geci];
    return cell;
}


#pragma mark - 按钮响应函数
-(void)backButtonClick
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
