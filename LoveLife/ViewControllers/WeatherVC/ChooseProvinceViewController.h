//
//  ChooseProvinceViewController.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/27.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol ChooseProvinceDelegate <NSObject>

- (void)backTheCityName:(NSString *)city;

@end

@interface ChooseProvinceViewController : UIViewController
@property (nonatomic,assign) id<ChooseProvinceDelegate>delegate;
@end
