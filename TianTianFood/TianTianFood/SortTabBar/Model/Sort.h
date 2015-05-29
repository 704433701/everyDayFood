//
//  Sort.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sort : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *title; // 标题
@property (nonatomic, retain) NSString *effect; // 类型
@property (nonatomic, retain) NSString *yingyang; // 营养
 // 图片小图
@property (nonatomic, retain) NSString *thumb_2; // 图片小图
@property (nonatomic, retain) NSString *yuanliao; // 原料

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
