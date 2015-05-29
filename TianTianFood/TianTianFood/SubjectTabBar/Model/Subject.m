//
//  Subject.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "Subject.h"

@implementation Subject
- (void)dealloc
{
    [_flag release];
    [_ID release];
    [_Guid release];
    [_RecipeGuid release];
    [_UserGuid release];
    [_NickName release];
    [_UserGuid release];
    [_ImageUrl release];
    [_DateCreated release];
    [_RecipeName release];
    [_LastUpdTime release];
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
