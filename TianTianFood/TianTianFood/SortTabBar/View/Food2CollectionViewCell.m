//
//  Food2CollectionViewCell.m
//  TianTianFood
//
//  Created by dlios on 15/3/23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "Food2CollectionViewCell.h"

@implementation Food2CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.yinYingView = [[UIView alloc] init];
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
    CGFloat width = layoutAttributes.frame.size.width;
    CGFloat height = layoutAttributes.frame.size.height;
    self.imageView.frame = CGRectMake(2, 2, width - 4, height - 20 - 4);
    self.imageView.layer.cornerRadius = 5;
    self.label.frame = CGRectMake(0, height - 20, width, 20);
    self.label.layer.cornerRadius = 2;
    self.yinYingView.frame = CGRectMake(0, 0, width, height - 20);
    self.yinYingView.layer.cornerRadius = 5;
    self.yinYingView.backgroundColor = [UIColor blackColor];
    self.yinYingView.alpha = 0.1;
    
}


- (void)dealloc
{
    [_imageView release];
    [_label release];
    [super dealloc];
}









@end
