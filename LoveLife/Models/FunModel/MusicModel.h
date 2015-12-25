//
//  MusicModel.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/22.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property(nonatomic,copy) NSString * artist;
@property(nonatomic,copy) NSString * coverURL;
@property(nonatomic,copy) NSString * lyricURL;
@property(nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,strong) NSNumber * sid;

@property (nonatomic,strong)NSData * imageData;
@property (nonatomic,strong) NSString * lrcStr;
@property (nonatomic,strong) NSNumber * length;

@end
