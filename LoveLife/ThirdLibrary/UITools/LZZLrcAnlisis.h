//
//  LZZLrcAnlisis.h
//  只为你能看见
//
//  Created by MS on 15-9-30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayModel.h"

typedef NS_ENUM(NSUInteger, LZZAnlisisType) {
    LZZAnlisisTypeDefault = 0,
    LZZAnlisisTypeLrcArray = 1,
    LZZAnlisisTypeAllWords = 2
};

typedef void(^LZZblock)(id);
typedef void(^LZZblockLrcArray)(NSArray *);
@interface LZZLrcAnlisis : NSObject

@property (nonatomic,copy)LZZblock block;
@property (nonatomic,copy)LZZblockLrcArray blockArray;
@property (nonatomic,assign)LZZAnlisisType type;

+ (void)anlisisLrc:(NSURL *)url withCompleteBlock:(void (^)(id lrc))block;

+ (void)anlisisLrc:(NSURL *)url AnlisisType:(LZZAnlisisType)type withCompleteBlock:(void(^)(id lrc))block;

+ (void)stopAnlisis;

@end
