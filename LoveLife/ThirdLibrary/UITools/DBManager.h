//
//  DBManager.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ArticalModel.h"
@interface DBManager : NSObject
+(DBManager *)defaultManager;
//插入数据
- (void)insertDataModel:(ArticalModel *)model;
//查询数据
- (BOOL)isHasDataIDFromTable:(NSString *)dataId;
//删除数据
- (void)deleteNameFromTable:(NSString *)dataId;
//查询所有
- (NSArray *)getData;


@end
