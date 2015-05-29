//
//  Home.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Find.h"

@interface Home : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *category; // 类型
@property (nonatomic, retain) NSString *age; // 分类
@property (nonatomic, retain) NSString *effect; // 效果
@property (nonatomic, retain) NSString *title; // 名字
@property (nonatomic, retain) NSString *thumb; // 图片
@property (nonatomic, retain) NSString *thumb_2; // 大图
@property (nonatomic, retain) NSString *yingyang; // 营养
@property (nonatomic, retain) NSString *yuanliao; // 原料
@property (nonatomic, retain) NSString *time; // 制作时间

- (instancetype)initWithDictionary:(NSDictionary *)dic;

- (instancetype)initWithFind:(id *)find;

@end
