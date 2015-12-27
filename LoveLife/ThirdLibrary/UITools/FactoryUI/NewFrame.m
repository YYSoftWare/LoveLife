//
//  NewFrame.m
//  代码适配
//
//  Created by MS on 15-9-23.
//  Copyright (c) 2015年 student. All rights reserved.
//


#define IPHONE4S (([UIScreen mainScreen].bounds.size.width)==320&&([UIScreen mainScreen].bounds.size.height==480))
#define IPHONE5 (([UIScreen mainScreen].bounds.size.width)==320&&([UIScreen mainScreen].bounds.size.height==568))
#define IPHONE6 (([UIScreen mainScreen].bounds.size.width)==375&&([UIScreen mainScreen].bounds.size.height==667))
#define IPHONE6P (([UIScreen mainScreen].bounds.size.width)==414&&([UIScreen mainScreen].bounds.size.height==736))

#import "NewFrame.h"

@implementation UIView (NewFrame)

+ (CGRect)getRectWithX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height{
    CGRect rect = CGRectZero;
    CGFloat height4s = 480.;
    CGFloat width4s = 320.;
    if (IPHONE4S) {
        rect = CGRectMake(x, y, width, height);
    }else if (IPHONE5){
        rect = CGRectMake(x, 568/height4s*y, width, 568/height4s*height);
    }else if (IPHONE6){
        rect = CGRectMake(375/width4s*x, 667/height4s*y, 375/width4s*width, 667/height4s*height);
    }else if (IPHONE6P){
        rect = CGRectMake(414/width4s*x, 736/height4s*y, 414/width4s*width, 736/height4s*height);
    }
    return rect;
}


@end


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

