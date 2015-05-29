//
//  ImageSubject.m
//  TianTianFood
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ImageSubject.h"

@implementation ImageSubject
- (void)dealloc
{
    [_ImageHeight release];
    [_StepGraph release];
    [super dealloc];
}

@end
