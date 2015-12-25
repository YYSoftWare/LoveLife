//
//  LZZLrcAnlisis.m
//  只为你能看见
//
//  Created by MS on 15-9-30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "LZZLrcAnlisis.h"

@interface LZZLrcAnlisis ()
/**存放歌词模型*/
@property (nonatomic,strong)NSMutableArray * lrcArray;

@end

@implementation LZZLrcAnlisis

+ (void)anlisisLrc:(NSURL *)url withCompleteBlock:(void (^)(id lrc))block
{
    [self anlisisLrc:url AnlisisType:LZZAnlisisTypeDefault withCompleteBlock:block];
}

+ (void)anlisisLrc:(NSURL *)url AnlisisType:(LZZAnlisisType)type withCompleteBlock:(void (^)(id lrc))block
{
    __block NSString * str = @"";
    
    NSMutableURLRequest * rq = [NSMutableURLRequest requestWithURL:url];
    rq.timeoutInterval = 8;
    [NSURLConnection sendAsynchronousRequest:rq queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        if (type == LZZAnlisisTypeDefault|| type == LZZAnlisisTypeLrcArray) {
            
            NSArray * lrcsArray = [self LrcArray:str];
            
            block(lrcsArray);
        }else{
        
        NSString * someLrc = [self showSomeLrc:str];
        block(someLrc);
     }
    }];
}


- (void)analyLrc:(NSString *)str
{
    
    NSArray * array = [str componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < array.count; i++) {
        [self analyLrcEachLine:array[i]];
    }
}

- (void)analyLrcEachLine:(NSString *)lrc{
    
    if (lrc.length>1) {

    unichar c = [lrc characterAtIndex:1];
    
    if ( isnumber(c)) {
        
        NSArray * array = [lrc componentsSeparatedByString:@"]"];
        
        for (int i = 0; i < array.count-1; i++) {
            
            PlayModel * myLrc = [[PlayModel alloc]init];
            myLrc.geci = array.lastObject;
            NSDateFormatter * df = [[NSDateFormatter alloc]init];
            df.dateFormat = @"[mm:ss.S";
            // LZZLog(@"%@",array[i]);
            NSDate * date = [df dateFromString:array[i]];
            NSTimeInterval tf = [date timeIntervalSince1970];
            NSDate * date2 = [df dateFromString:@"[00:00.0"];
            NSTimeInterval tf2 = [date2 timeIntervalSince1970];
            NSTimeInterval lrctime = tf - tf2;
            myLrc.timelength = lrctime;
            [self.lrcArray addObject:myLrc];
        }
        
    }else{
        //这是歌曲介绍信息.
     }
    }
}

- (void)sortArray{
    
    [self.lrcArray sortUsingComparator:^NSComparisonResult(PlayModel * obj1, PlayModel * obj2) {
        return obj1.timelength > obj2.timelength;
    }];
}

- (NSMutableArray *)lrcArray
{
    if (!_lrcArray) {
        _lrcArray = [NSMutableArray new];
    }
    return _lrcArray;
}

- (void)clearAllLrc
{
    [_lrcArray removeAllObjects];
}

/**拼接歌词信息*/
- (NSString *)jointArrayLrc
{
    NSString * AllLrc = @"";
    for (PlayModel * lrcModel in self.lrcArray) {
        
        AllLrc = [AllLrc stringByAppendingFormat:@" %@",lrcModel.geci];
    }
   return AllLrc;
}

+ (NSString *)showSomeLrc:(NSString *)str
{
    LZZLrcAnlisis * myLrc = [[LZZLrcAnlisis alloc]init];
    
    [myLrc analyLrc:str];
    [myLrc sortArray];
     return [myLrc jointArrayLrc];
}


+ (NSArray *)LrcArray:(NSString *)str
{
    LZZLrcAnlisis * myLrc = [[LZZLrcAnlisis alloc]init];
    
    [myLrc analyLrc:str];
    [myLrc sortArray];
    return myLrc.lrcArray;
}

+ (void)stopAnlisis
{
    [NSURLConnection cancelPreviousPerformRequestsWithTarget:self];
}

@end
