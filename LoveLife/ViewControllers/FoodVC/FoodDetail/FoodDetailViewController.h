//
//  FoodDetailViewController.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/21.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "RootViewController.h"

@interface FoodDetailViewController : RootViewController

//id
@property(nonatomic,copy) NSString * dataId;
//菜名
@property(nonatomic,copy) NSString * NavTitle;
//视频url
@property(nonatomic,strong) NSString * videoUrl;

@end
