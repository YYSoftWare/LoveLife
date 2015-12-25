//
//  PlayModel.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/24.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayModel : NSObject

@property (nonatomic,copy)NSString * geci;
//播放时间
@property (nonatomic,copy) NSString * playTime;
//一句歌词播放时间长度
@property (nonatomic,assign) NSTimeInterval timelength;
//总播放时间长度
@property (nonatomic,assign) NSTimeInterval allTimeLength;
//记录这段歌词是否被选中
@property (nonatomic,assign,getter=isSelected) BOOL selected;

@end
