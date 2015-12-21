//
//  FoodTitleCollectionViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/20.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "FoodTitleCollectionViewCell.h"

@implementation FoodTitleCollectionViewCell

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
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:19]];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = RGB(255,156,187,1);
    [self.contentView addSubview:_titleLabel];
}

@end
