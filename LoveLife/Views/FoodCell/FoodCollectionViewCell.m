
//
//  FoodCollectionViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/20.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "FoodCollectionViewCell.h"

@interface FoodCollectionViewCell ()
@property(nonatomic,strong) FoodModel * foodModel;

@end

@implementation FoodCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self makeUI];
    }
    
    return self;
}

-(void)makeUI
{
    _mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 130) imageName:nil];
    [self.contentView addSubview:_mainImageView];
    
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _mainImageView.frame.size.height + 5, _mainImageView.frame.size.width, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 5, _mainImageView.frame.size.width, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_detailLabel];
    
    //创建播放按钮
    self.playButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"iconfont-bofang" backgroundImageName:nil target:self selector:@selector(playButtonClick)];
    self.playButton.center = _mainImageView.center;
    [self.contentView addSubview:self.playButton];
}

-(void)configUI:(FoodModel *)model
{
    _foodModel = model;
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    _titleLabel.text = model.title;
    _detailLabel.text = model.detail;
}



-(void)playButtonClick
{
    if ([_delegate respondsToSelector:@selector(deliverModel:)])
    {
        [_delegate deliverModel:_foodModel];
    }
}

@end
