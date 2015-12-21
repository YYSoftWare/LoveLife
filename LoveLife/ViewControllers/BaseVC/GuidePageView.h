//
//  GuidePageView.h
//  ProgramGuidePage
//
//  Created by 杨阳 on 15/12/10.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageView : UIView

@property (nonatomic, strong)UIButton * guideBtn;

- (id)initWithFrame:(CGRect)frame namesArray:(NSArray *)items;

@end
