//
//  Find.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "Find.h"

@implementation Find


- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// 纠错方法 数据不匹配时候修改
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"thumb"]) {
        self.thumb_2 = value;
    }
}

// 重写setter方法修改网络数据
- (void)setYingyang:(NSString *)yingyang
{
    if (_yingyang != yingyang) {
        [_yingyang release];
        yingyang = [yingyang stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        _yingyang = [yingyang retain];
    }
}


- (void)dealloc
{
    [_ID release];
    [_thumb_2 release];
    [_title release];
    [_yingyang release];
    [super dealloc];
}







@end
