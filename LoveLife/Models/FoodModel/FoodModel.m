//
//  FoodModel.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/20.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"])
    {
        self.detail = value;
    }
}

@end
