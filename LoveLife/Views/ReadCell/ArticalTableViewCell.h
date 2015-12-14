//
//  ArticalTableViewCell.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/14.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticalModel.h"

@interface ArticalTableViewCell : UITableViewCell
{
    //图片
    UIImageView * _imageView;
    //标题
    UILabel * _titleLabel;
    //作者
    UILabel * _authorLabel;
    //时间
    UILabel * _timeLabel;
}

-(void)configUI:(ArticalModel *)model;

@end
