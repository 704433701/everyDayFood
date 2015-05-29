//
//  SubjectHot.m
//  TianTianFood
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SubjectHot.h"

@implementation SubjectHot
- (void)dealloc
{
    [_ID release];
    [_title release];
    [_thumb release];
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
