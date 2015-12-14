//
//  UtteranceTableViewCell.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/14.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtteranceModel.h"

@interface UtteranceTableViewCell : UITableViewCell
{
    //头像
    UIImageView * _headImageView;
    //昵称
    UILabel * _nickNameLabel;
    //时间
    UILabel * _timeLabel;
    UIImageView * _mainImageView;
    UILabel * _contentLabel;
}

//获取cell的高度
@property(nonatomic,assign) CGFloat cellHeight;

-(void)configUI:(UtteranceModel *)model;

@end
