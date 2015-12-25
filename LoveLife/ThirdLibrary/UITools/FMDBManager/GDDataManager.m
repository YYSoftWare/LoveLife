//
//  GDDataManager.m
//  DeliciousMemory
//
//  Created by 杨阳 on 15/12/25.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "GDDataManager.h"
#import "ArticalModel.h"

@implementation GDDataManager

static  GDDataManager * manager = nil;

+ (id)shareManager{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken ,^{
        
        if (manager == nil) {
            manager = [[GDDataManager alloc] init];
        }
    });
    return manager;
}

// 重写INIt

- (instancetype)init

{
    self = [super init];
    if (self) {
        NSString * path = [NSString stringWithFormat:@"%@/Documents/yangyang.db",NSHomeDirectory()];
        NSLog(@"%@",path);
        fm = [[FMDatabase alloc] initWithPath:path];
        if ([fm open]) {
            NSLog(@"打开数据库成功");
        }else{
            
            NSLog(@"打开数据库失败");
        }
        // 创建表格
        BOOL isSucceed = [fm executeUpdate:@"create table yangyang (id,title,pic,createtime,author)"];
        if (isSucceed) {
            NSLog(@"表格创建成功");
            
        }else{
            NSLog(@"表格已存在或者创建失败");
        }
    }
    return self;
}

#pragma mark -- 存储数据
- (void)saveDic:(NSDictionary *)dict{
    
    BOOL isSucceed = [fm executeUpdate:@"insert into yangyang values(?,?,?,?,?)",dict[@"id"],dict[@"title"],dict[@"pic"],dict[@"createtime"],dict[@"author"]];
    if (isSucceed) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
}

#pragma mark -- 读取数据
- (NSMutableArray *)loadData{
    
    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:0];
    FMResultSet * result = [fm executeQuery:@"select * from yangyang"];
    
    while ([result next]) {
        NSString * dataID = [result stringForColumn:@"id"];
        NSString * title = [result stringForColumn:@"title"];
        NSString * pic = [result stringForColumn:@"pic"];
        NSString * createtime = [result stringForColumn:@"createtime"];
        NSString * author = [result stringForColumn:@"author"];
        ArticalModel * model = [[ArticalModel alloc] init];
        model.dataID = dataID;
        model.title = title;
        model.pic = pic;
        model.createtime = createtime;
        model.author = author;
        [dataArray addObject:model];
    }
    return dataArray;
}

#pragma mark - 查找

//3.查找数据
-(BOOL)findDataWithTitle:(NSString *)title
{
    NSString *sql = @"select count(*) from applist where title =?";
    //注意：只有查找时，用的方法是executeQuery：其他的都用executeUpdate：
    //里面保存的是查找到的内容
    FMResultSet *set = [fm executeQuery:sql,title];
    int count = 0;
    if ([set next]) {
        count = [set intForColumnIndex:0];
    }
    return count;
    
}

#pragma mark -- 删除数据

- (void)deleteWith:(NSString *)title{
    
    NSString * deleteSql = @"DELETE FROM yangyang WHERE title = ?";
    
    BOOL isSuc = [fm executeUpdate:deleteSql,title];
    
    if (isSuc) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}


@end
