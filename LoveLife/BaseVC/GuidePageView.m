//
//  GuidePageView.m
//  ProgramGuidePage
//
//  Created by 杨阳 on 15/12/10.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//


#define kKEY_WINDOW [[UIApplication sharedApplication] keyWindow]

#import "GuidePageView.h"

@interface GuidePageView ()

@property (nonatomic, retain) UIScrollView * grideScroll;

@end

@implementation GuidePageView

- (id)initWithFrame:(CGRect)frame
     namesArray:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = [[UIScreen mainScreen] bounds];
        [kKEY_WINDOW addSubview:self];
        
        self.grideScroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.grideScroll.contentSize = CGSizeMake(SCREEN_W * items.count, SCREEN_H + 64);
        self.grideScroll.backgroundColor = [UIColor yellowColor];
        self.grideScroll.pagingEnabled = YES;
        [self addSubview:self.grideScroll];
        [self loadImagesWithArray:items];
    }
    return self;
}

- (void)loadImagesWithArray:(NSArray *)items
{
    for (int i = 0; i < items.count; i++)
    {
        //引导页图片
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H + 64)];
        imageView.backgroundColor = [UIColor greenColor];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:items[i]];
        [self.grideScroll addSubview:imageView];
        
        //引导页文字
        UILabel * guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * SCREEN_W + 20, 200, SCREEN_W - 40, 30)];
        guideLabel.font = [UIFont systemFontOfSize:25];
        guideLabel.textAlignment = NSTextAlignmentCenter;
        guideLabel.tag = 10 + i;
        [self.grideScroll addSubview:guideLabel];
        //设置文字
        switch (guideLabel.tag - 10) {
            case 0:
            {
                guideLabel.text = @"用心去聆听";
                guideLabel.textColor = [UIColor purpleColor];
                guideLabel.frame = CGRectMake(100, 200, SCREEN_W - 40, 30);
            }
                break;
            case 1:
            {
                guideLabel.text = @"用心去发现";
                guideLabel.textColor = [UIColor cyanColor];
                guideLabel.frame = CGRectMake(SCREEN_W + 30, 250, SCREEN_W - 40, 30);
                guideLabel.textAlignment = NSTextAlignmentLeft;
            }
                break;
            case 2:
            {
                guideLabel.text = @"用心去感受";
                guideLabel.textColor = [UIColor redColor];
                guideLabel.frame = CGRectMake(SCREEN_W * 2 + 20, 250, SCREEN_W - 40, 30);
            }
                break;
            case 3:
            {
                guideLabel.text = @"爱生活，爱自己";
                guideLabel.textColor = [UIColor brownColor];
                guideLabel.frame = CGRectMake(SCREEN_W * 3 + 20, 170, SCREEN_W - 40, 30);
            }
                break;
                
            default:
                break;
        }
        
        if (i == items.count - 1)
        {
            self.guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _guideBtn.frame = CGRectMake((SCREEN_W - 70) / 2,SCREEN_H + 64 - 100,100,70);
            _guideBtn.layer.cornerRadius = 20;
            [_guideBtn setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
            [imageView addSubview:_guideBtn];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
