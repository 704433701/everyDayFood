//
//  Sort.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "Sort.h"

@implementation Sort

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)dealloc
{
    [_ID release];
    [_thumb_2 release];
    [_title release];
    [_yuanliao release];
    [_yingyang release];
    [_effect release];
    [super dealloc];
}

// 重写set方法 改数据符号

- (void)setYingyang:(NSString *)yingyang
{
    if (_yingyang != yingyang) {
        [_yingyang release];
        yingyang = [yingyang stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        yingyang = [yingyang stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        yingyang = [yingyang stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        _yingyang = [yingyang retain];
    }
}

- (void)setYuanliao:(NSString *)yuanliao
{
    if (_yuanliao != yuanliao) {
        [_yuanliao release];
        yuanliao = [yuanliao stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        yuanliao = [yuanliao stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        yuanliao = [yuanliao stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        yuanliao = [yuanliao stringByReplacingOccurrencesOfString:@"<span>" withString:@""];
        yuanliao = [yuanliao stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
        _yuanliao = [yuanliao retain];
    }
}


@end
