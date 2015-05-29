//
//  Home.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "Home.h"

@implementation Home

- (void)dealloc
{
    [_ID release];
    [_category release];
    [_age release];
    [_effect release];
    [_title release];
    [_thumb release];
    [_thumb_2 release];
    [_yingyang release];
    [_yuanliao release];
    [super dealloc];
}

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"yingyang"]) {
        self.yingyang = [value stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    }
}

- (void)setYingyang:(NSString *)yingyang
{
    if (_yingyang != yingyang) {
        [_yingyang release];
        yingyang = [yingyang stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        yingyang = [yingyang stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        yingyang = [yingyang stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        if ([yingyang isEqualToString:@""]) {
            yingyang = self.yuanliao;
        }
        _yingyang = [yingyang retain];
    }
}

- (instancetype)initWithFind:(id *)find
{
    self = [super init];
    if (self) {
        self.ID = [find ID];
        self.title = [find title];
        self.thumb_2 = [find thumb_2];
    }
    return self;
}
@end
