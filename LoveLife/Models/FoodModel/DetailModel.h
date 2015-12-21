//
//  DetailModel.h
//  PocketKichen
//
//  Created by 杨阳 on 15/11/26.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property(nonatomic,copy) NSString * dashes_id;
@property(nonatomic,copy) NSString * dishes_name;
@property(nonatomic,copy) NSString * image;
@property(nonatomic,copy) NSString * material_desc;
@property(nonatomic,copy) NSString * material_video;
@property(nonatomic,copy) NSString * process_video;
@property(nonatomic,copy) NSString * share_url;
@property(nonatomic,strong) NSArray * step;

@end
