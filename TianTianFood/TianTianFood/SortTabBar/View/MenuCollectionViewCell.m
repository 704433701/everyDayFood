//
//  MenuCollectionViewCell.m
//  TianTianFood
//
//  Created by dlios on 15/3/23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MenuCollectionViewCell.h"


@implementation MenuCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.yinYingView = [[UIView alloc] init];
        self.yinYingView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.yinYingView];
        [_yinYingView release];
        
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        [_imageView release];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        [_label release];
        
    }
    return self;
}



- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    CGFloat width = layoutAttributes.frame.size.width; // 105
    CGFloat height = layoutAttributes.frame.size.height; // 100
 
    self.imageView.frame = CGRectMake(0, 0, width - 20, width - 20);
    self.imageView.center = CGPointMake(width / 2, height / 2 - 15);
    self.imageView.layer.cornerRadius = (width - 20) / 2;
    self.label.frame = CGRectMake(0, height - 30, width, 30);
    
    
    self.yinYingView.layer.frame = CGRectMake(0, 0, width - 15, width - 15);
    self.yinYingView.center = CGPointMake(width / 2, height / 2 - 15);
    self.yinYingView.layer.cornerRadius = (width - 15) / 2;
    self.yinYingView.alpha = 0.2;
    
}


- (void)dealloc
{
    [_imageView release];
    [_label release];
    [super dealloc];
}






@end
