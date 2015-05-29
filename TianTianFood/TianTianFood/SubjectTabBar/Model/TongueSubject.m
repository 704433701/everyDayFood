//
//  TongueSubject.m
//  TianTianFood
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TongueSubject.h"

@implementation TongueSubject
- (void)dealloc
{
    [_age release];
    [_ID release];
    [_thumb_2 release];
    [_title release];
    [_effect release];
    [_category release];
    [super dealloc];
}

- (instancetype) initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
