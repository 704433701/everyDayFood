//
//  SubjectCollectionViewCell.m
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SubjectCollectionViewCell.h"

@implementation SubjectCollectionViewCell
- (void)dealloc
{
    [_subject release];
    [_headView release];
    [_picView release];
    [_label release];
    [_imageView release];
    [super dealloc];
}

// 自定义collectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.picView = [[UIView alloc] init];
//        self.picView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.picView];
        
        self.imageView = [[UIImageView alloc] init];
//        self.imageView.backgroundColor = [UIColor darkGrayColor];
        [self.picView addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:14];
//        self.label.backgroundColor = [UIColor orangeColor];
        [self.picView addSubview:self.label];
        
        self.headView = [[UIImageView alloc] init];
        self.headView.layer.cornerRadius = 10;
        self.headView.clipsToBounds = YES;
//        self.headView.backgroundColor = [UIColor cyanColor];
        [self.picView addSubview:self.headView];
        
        [_headView release];
        [_imageView release];
        [_picView release];
        [_label release];
    }
    return self;
}

- (void) setSubject:(Subject *)subject
{
    if (_subject != subject) {
        [_subject release];
        _subject = [subject retain];
    }
    [self.imageView sd_setImageWithURL:self.subject.ImageUrl placeholderImage:[UIImage imageNamed:@"location.png"]];
    [self.headView sd_setImageWithURL:self.subject.UserImageUrl placeholderImage:[UIImage imageNamed:@"headicon.png"]];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.picView.frame = layoutAttributes.bounds;
    self.imageView.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height - 50);
    self.headView.frame = CGRectMake(0, layoutAttributes.frame.size.height - 40, 40, 40);
    self.label.frame = CGRectMake(50, layoutAttributes.frame.size.height - 30, layoutAttributes.frame.size.width - 50, 30);
}











@end
