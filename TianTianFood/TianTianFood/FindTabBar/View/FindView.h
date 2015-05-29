//
//  FindView.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Find.h"


// 协议代理
@protocol FindViewDelegate <NSObject>

@optional

- (void)push:(Find *)find;

@end


@interface FindView : UIView

@property (nonatomic, retain) UIView *yinYingView;
@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) Find *find;

@property (nonatomic, assign) id <FindViewDelegate> delegate;



@end
