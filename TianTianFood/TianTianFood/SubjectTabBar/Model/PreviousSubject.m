//
//  PreviousSubject.m
//  TianTianFood
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PreviousSubject.h"

@implementation PreviousSubject
- (void)dealloc
{
    [_ID release];
    [_RecipeGuid release];
    [_RecipeName release];
    [_RecipeContent release];
    [_RecipeNotes release];
    [_MainImageUrl release];
    [_Ingredients release];
    [_Seasoning release];
    [_imageSubject release];
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
