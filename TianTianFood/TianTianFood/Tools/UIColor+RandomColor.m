//
//  UIColor+RandomColor.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+(UIColor *) randomColor
{
    return [UIColor randomColorWithAlpha:1];
}

+(UIColor *) randomColorWithAlpha:(CGFloat)alpha
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

@end
