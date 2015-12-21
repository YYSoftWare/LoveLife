//
//  StepCell.h
//  PocketKichen
//
//  Created by 杨阳 on 15/11/26.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepModel.h"

@interface StepCell : UITableViewCell
{
    UIImageView * _stepImageView;
    UILabel * _stepLabel;
}
-(void)config:(StepModel *)model indexPath:(NSIndexPath *)indexPath;

@end
