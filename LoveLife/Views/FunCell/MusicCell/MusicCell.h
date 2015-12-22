//
//  MusicCell.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/22.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicCell : UITableViewCell
{
    //图片
    UIImageView * _imageView;
    //标题
    UILabel * _titleLabel;
    //作者
    UILabel * _authorLabel;
}

-(void)configUI:(MusicModel *)model;

@end
