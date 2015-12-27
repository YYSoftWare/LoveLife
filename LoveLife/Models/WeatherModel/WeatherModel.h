//
//  WeatherModel.h
//  jiaqiqunaer
//
//  Created by MS on 15-9-28.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
//chossseVC用的
@property (nonatomic,strong) NSArray *Cities;
@property (nonatomic,copy) NSString *State;
//weatherVC用的
@property (nonatomic,copy) NSString *date;
@property (nonatomic,strong) NSArray *results;
@property (nonatomic,strong) NSArray *weather_data;

@end
