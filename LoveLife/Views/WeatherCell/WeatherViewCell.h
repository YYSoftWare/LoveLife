//
//  WeatherViewCell.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//


#import <UIKit/UIKit.h>
@class WeatherModel;
@interface WeatherViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *city;

@property (nonatomic,strong) UILabel *wendu;
@property (nonatomic,strong) UILabel *wind;
@property (nonatomic,strong) UILabel *cityTem;
@property (nonatomic,strong) UILabel *tianqi;
@property (nonatomic,strong) UILabel *pm;
@property (nonatomic,strong) UILabel *date;
@property (nonatomic,strong) UILabel *clothes;
@property (nonatomic,strong) UILabel *advice;
@property (nonatomic,strong) UILabel *ganmao;
@property (nonatomic,strong) UILabel *advice1;
@property (nonatomic,strong) UILabel *travel;
@property (nonatomic,strong) UILabel *advice2;
@property (nonatomic,strong) UILabel *mingtian;
@property (nonatomic,strong) UILabel *weather1;
@property (nonatomic,strong) UILabel *temperature1;
@property (nonatomic,strong) UILabel *houtian;
@property (nonatomic,strong) UILabel *weather2;
@property (nonatomic,strong) UILabel *temperature2;
@property (nonatomic,strong) UILabel *dahoutian;
@property (nonatomic,strong) UILabel *weather3;
@property (nonatomic,strong) UILabel *temperature3;

@property (nonatomic,strong) UIImageView *dayView1;
@property (nonatomic,strong) UIImageView *nightView1;
@property (nonatomic,strong) UIImageView *dayView2;
@property (nonatomic,strong) UIImageView *nightView2;
@property (nonatomic,strong) UIImageView *dayView3;
@property (nonatomic,strong) UIImageView *nightView3;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)relyoutUI:(WeatherModel *)_model;
@end
