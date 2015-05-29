//
//  CustomFavoriteTableViewCell.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewCell.h"

@interface CustomFavoriteTableViewCell : HomeTableViewCell

@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, assign) id target;
@end
