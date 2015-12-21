
//
//  MyCollectionViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/21.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

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
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imageView];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.imageView.frame.size.width, 25)];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:13];
    self.label.center = self.imageView.center;
    [self.contentView addSubview:self.label];
}


@end
