//
//  BaseView.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger keyword;

@property (nonatomic, retain) PQFBouncingBalls *bouncingBalls;

//要执行方法的对象
@property (nonatomic, assign) id target;

- (instancetype)initWithFrame:(CGRect)frame keyword:(NSInteger)keyword;

@end
