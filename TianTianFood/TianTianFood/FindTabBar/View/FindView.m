//
//  FindView.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "FindView.h"
#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FindView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.yinYingView = [[UIView alloc] initWithFrame:CGRectMake(- 3, - 3, frame.size.width + 6, frame.size.width + 6)];
        self.yinYingView.layer.cornerRadius= (frame.size.width + 3) / 2;
        [self addSubview:self.yinYingView];
        [_yinYingView release];
        
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];

        // 添加点击手势 (封装)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        self.imageView1.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        [self.imageView1 addGestureRecognizer:tap];
        [tap release];
        
        [self addSubview:self.imageView1];
        self.imageView1.clipsToBounds = YES;
        [_imageView1 release];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor grayColor];
        self.label.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.label];
        [_label release];
    }
    return self;
}

// 重写set方法 赋值
- (void)setFind:(Find *)find
{
    if (_find != find) {
        [_find release];
        _find = [find retain];
    }

    [self.imageView1 sd_setImageWithURL:self.find.thumb_2 placeholderImage:[UIImage imageNamed:@"location1.png"]];
    self.label.text = self.find.title;
    self.yinYingView.backgroundColor = [UIColor randomColorWithAlpha:0.5];
    
}

- (void)dealloc
{
    [_imageView1 release];
    [_label release];
    [_find release];
    [super dealloc];
}


// 点击方法推出(协议)
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(push:)]) {
        [self.delegate push:self.find];
    }
    
}











@end
