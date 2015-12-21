//
//  FoodCollectionViewCell.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/20.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@protocol PlayDelegte <NSObject>

-(void)deliverModel:(FoodModel *)model;

@end

@interface FoodCollectionViewCell : UICollectionViewCell

{
    UIImageView * _mainImageView;
    UILabel * _titleLabel;
    UILabel * _detailLabel;
}

//播放按钮
@property(nonatomic,strong) UIButton * playButton;

@property(nonatomic,weak) id<PlayDelegte>delegate;

-(void)configUI:(FoodModel *)model;

@end
