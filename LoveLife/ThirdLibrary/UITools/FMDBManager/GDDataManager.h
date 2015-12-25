//
//  GDDataManager.h
//  DeliciousMemory
//
//  Created by 杨阳 on 15/12/25.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface GDDataManager : NSObject{

    FMDatabase * fm;
}

// 单利
+ (id)shareManager;

// 保存数据
- (void)saveDic:(NSDictionary *)dict;

// 读取数据

- (NSMutableArray *)loadData;

// 删除数据
- (void)deleteWith:(NSString *)name;

//查询数据
-(BOOL)findDataWithTitle:(NSString *)title;


@end
