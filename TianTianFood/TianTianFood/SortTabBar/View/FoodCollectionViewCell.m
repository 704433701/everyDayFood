//
//  FoodCollectionViewCell.m
//  TianTianFood
//
//  Created by dlios on 15/3/23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "FoodCollectionViewCell.h"

@implementation FoodCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    self.imageView.frame = CGRectMake(0, 0, width - 18, width - 18);
    self.imageView.center = CGPointMake(width / 2, height / 2 - 9);
    self.imageView.layer.cornerRadius = (width - 18) / 2;
    self.label.frame = CGRectMake(0, height - 18, width, 18);
    
    
}

- (void)dealloc
{
    [_imageView release];
    [_label release];
    [super dealloc];
}








@end
