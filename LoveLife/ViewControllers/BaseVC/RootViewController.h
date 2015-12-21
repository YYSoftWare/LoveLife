//
//  RootViewController.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
//左按钮
@property(nonatomic,strong) UIButton * leftButton;
//右按钮
@property(nonatomic,strong) UIButton * rightButton;
//标题
@property(nonatomic,strong) UILabel * titleLabel;

//响应方法
-(void)setLeftButtonSelector:(SEL)leftSelector;
-(void)setRightButtonSelector:(SEL)rightSelector;

@end
