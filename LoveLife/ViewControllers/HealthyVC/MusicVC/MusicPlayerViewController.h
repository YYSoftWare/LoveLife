//
//  MusicPlayerViewController.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/24.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicPlayerViewController : UIViewController

//标题
@property(nonatomic,copy) NSString * titleString;
//图片
@property(nonatomic,copy) NSString * imageUrl;

@property (nonatomic,strong)MusicModel * lrcInfo;
@property (nonatomic,weak) NSArray * lrcInfos;
@property (nonatomic,strong) NSIndexPath * indexPath;

@end
